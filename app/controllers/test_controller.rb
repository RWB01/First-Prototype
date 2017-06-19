class TestController < ApplicationController

  before_action :set_algorithm, only: [:start, :step]

  def start

    respond_to do |format|
        #current_step nil because it's initial step
        format.html { render :test, :locals => {:current_step => nil }}
    end


    java_json_package = '/home/rainwb/Rails/prototype_1/public/java-packages/org.json.jar'

    class_file_name = @algorithm.code.path.to_s.gsub('.java', '.class')

    if !File.file?(class_file_name)

      logger.debug "javac -cp #{java_json_package} #{@algorithm.code.path}"

      system("javac -cp #{java_json_package} #{@algorithm.code.path}")

    end

    file_name = @algorithm.code.original_filename.to_s

    class_name = file_name.gsub('.java', '')

    class_file_path = @algorithm.code.path.to_s.gsub(file_name, '')

    args = "[[0,10,18,8,-1,-1],[10,0,16,9,21,-1],[-1,16,0,-1,-1,15],[7,9,-1,0,-1,12],[-1,-1,-1,-1,0,23],[-1,-1,15,-1,23,0]]"

    logger.debug "java -cp #{class_file_path} #{class_name} #{args}"

    output = IO.popen "java -cp #{class_file_path} #{class_name} #{args}"

    logger.debug output.read

    #javac -cp /home/rainwb/Rails/prototype_1/public/java-packages/org.json.jar /home/rainwb/Rails/prototype_1/public/system/algorithms/codes/000/000/001/original/Warshall.java

    #java -cp /home/rainwb/Rails/prototype_1/public/java-packages/org.json.jar:/home/rainwb/Rails/prototype_1/public/system/algorithms/codes/000/000/001/original/ Warshall [[0,10,18,8,-1,-1],[10,0,16,9,21,-1],[-1,16,0,-1,-1,15],[7,9,-1,0,-1,12],[-1,-1,-1,-1,0,23],[-1,-1,15,-1,23,0]]

  end


  def step

    step_id = params[:step_id]

    current_step = nil

    @algorithm.steps.each do |x|

      if x.step_number.equal? step_id.to_i
        current_step = x
        break
      end

    end

    if !current_step.nil?
      respond_to do |format|
        format.js { render :step, :locals => {:current_step => current_step }}
      end
    else
      redirect_to :result_test
    end

  end

  def result
    respond_to do |format|
      format.html { render :end }
    end
  end

  private

    def set_algorithm
      @algorithm = Algorithm.find(params[:algorithm_id].to_i)
    end

    # def step_params
    #   params.fetch
    # end

end
