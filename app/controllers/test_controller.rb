class TestController < ApplicationController

  before_action :set_test, only: [:start]
  before_action :set_algorithm, only: [:step]

  def start

    #test = @algorithm.get_test_by_user current_user.id
    #@algorithm = Algorithm.find(@test.algorithm_id)
    gon.user_id = current_user.id

    if @algorithm.nil?
      #THROW SOME EXCEPTION
    end

    java_json_package = 'public/java-packages/parser.jar'
    org_json_package = 'public/java-packages/org.json.jar'

    algorithm_class_path = 'public/system/modified_algorithms/' +
        @algorithm.id.to_s + '_' + @algorithm.title + '/' + @algorithm.code.original_filename.to_s

    algorithm_file_path = algorithm_class_path.gsub('.java', '.class')

    if !File.file?(algorithm_file_path)

      logger.debug "javac -cp #{java_json_package} \"#{algorithm_class_path}\""

      system("javac -cp #{java_json_package} \"#{algorithm_class_path}\"")

    end

    file_name = @algorithm.code.original_filename.to_s

    class_name = file_name.gsub('.java', '')

    class_file_path = algorithm_file_path.gsub("#{class_name}.class", '')

    #i need to compose all input variables right there!
    input_set = InputValueSet.find(@test.input_value_set_id)
    args = Hash.new
    input_set.input_variable_values.each do |variable_value|
      variable = Variable.find(variable_value.variable_id)
      if variable.alias == 'String'
        args[variable.name] = variable_value.value
      else
        args[variable.name] = JSON.parse variable_value.value
      end
    end

    json_of_args = args.to_json

    # logger.debug "java -cp \"#{org_json_package}:#{java_json_package}:#{class_file_path}\" #{class_name} #{json_of_args}"

    output = IO.popen "java -cp \"#{org_json_package}:#{java_json_package}:#{class_file_path}\" #{class_name} #{json_of_args}"

    #we can read output only once
    algorithm_results = output.read

    splitted_algoritm_results = algorithm_results.split "\n"

    p splitted_algoritm_results

    gon.algorithm_output_data = splitted_algoritm_results

    gon.algorithm_input_data = json_of_args

    algorithm_output = AlgorithmOutput.new
    algorithm_output.data = splitted_algoritm_results
    algorithm_output.algorithm_id = @algorithm.id
    algorithm_output.input_value_set_id = input_set.id
    algorithm_output.save

    gon.algorithm_output_id = algorithm_output.id
    gon.input_value_set_id = input_set.id

    respond_to do |format|
      #current_step nil because it's initial step
      format.html { render :test, :locals => {:current_step => nil }}
    end

    #javac -cp /home/rainwb/Rails/prototype_1/public/java-packages/org.json.jar /home/rainwb/Rails/prototype_1/public/system/algorithms/codes/000/000/001/original/Warshall.java

    #java -cp /home/rainwb/Rails/prototype_1/public/java-packages/org.json.jar:/home/rainwb/Rails/prototype_1/public/system/algorithms/codes/000/000/001/original/ Warshall [[0,10,18,8,-1,-1],[10,0,16,9,21,-1],[-1,16,0,-1,-1,15],[7,9,-1,0,-1,12],[-1,-1,-1,-1,0,23],[-1,-1,15,-1,23,0]]

  end


  def step

    step_id = params[:step_id]

    current_step = nil

    #current_step = @algorithm.steps.find_by step_number: params[:step_id]

    @algorithm.steps.each do |x|

      if x.step_number.equal? step_id.to_i
        current_step = x
        break
      end

    end

    if !current_step.nil?
      respond_to do |format|
        format.js {
          render :step, :locals => {
              :current_step => current_step,
              :current_question_id => params[:current_question_id]
          }
        }
      end
    else
      redirect_to :result_test
    end

  end

  def result

    input_value_set_id = params[:input_value_set_id].to_i

    algorithm = Algorithm.find(params[:algorithm_id])

    test_session = nil

    algorithm.tests.each do |test|
      if test.input_value_set_id == input_value_set_id
        test_session = TestSession.find test.test_session_id
      end
    end

    attempts = []

    InputLog.where(
        user_id: params[:user_id],
        timestamp: params[:timestamp],
        input_value_set_id: input_value_set_id
    ).find_each do |log|
      attempts.push log
    end

    if test_session.nil? || attempts.nil?
      respond_to do |format|
        format.html { render :error }
      end
    else

      errors_count = 0.to_f
      questions_count = 0.to_f

      attempts.each do |attempt|

        if attempt.question_number > questions_count
          questions_count = attempt.question_number
        end
        if attempt.error
          errors_count += 1
        end
      end

      estimation_formula = test_session.estimation_formula

      if estimation_formula == 'pass'
        scale = 100
      else
        scale = estimation_formula.to_f
      end

      one_error_coast = scale / questions_count

      repeated_error_coefficient = errors_count / questions_count

      total_error_coast = 0

      unique_errors = 0

      previous_question_number = nil
      attempts.each do |attempt|
        if attempt.error
          if !previous_question_number.nil? && previous_question_number == attempt.question_number
            total_error_coast += repeated_error_coefficient * one_error_coast
          else
            unique_errors += 1
            total_error_coast += one_error_coast
            previous_question_number = attempt.question_number
          end
        end
      end

      result = (scale - total_error_coast).round

      if result < 0
        result = 0
      end

      is_passed = nil

      if estimation_formula == 'pass' && result > 60
        is_passed = true
      end

      test_result = TestResult.new
      test_result.test_session_id = test_session.id
      test_result.result = result
      test_result.estimation_formula = estimation_formula
      test_result.errors_count = errors_count
      test_result.is_passed = is_passed
      test_result.unique_errors = unique_errors
      test_result.input_value_set_id = input_value_set_id
      test_result.user_id = params[:user_id]
      test_result.save


      respond_to do |format|
        format.js {
          render :end, :locals => {
              :result => result,
              :estimation_formula => estimation_formula,
              :errors_count => errors_count.to_i,
              :is_passed => is_passed,
              :unique_errors => unique_errors
          }
        }
      end
    end
  end

  private

    def set_test
      p params[:test_id]
      @test = Test.find(params[:test_id].to_i)
      @algorithm = Algorithm.find(@test.algorithm_id)
    end

    def set_algorithm
      @algorithm = Algorithm.find(params[:algorithm_id].to_i)
    end    

    # def step_params
    #   params.fetch
    # end

end
