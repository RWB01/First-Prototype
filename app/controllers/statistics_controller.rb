require 'csv'
class StatisticsController < ApplicationController

  def show
    disciplines_data = Array.new
    current_user.disciplines.each do |discipline|
      data = Hash.new
      data[:id] = discipline.id
      data[:title] = discipline.title

      disciplines_data.push data
    end

    data = [{date: '2014-11-01', value: 12}, {date: '2014-11-02', value: 18}]

    respond_to do |format|
      format.html { render :show, :locals => {:disciplines_data => disciplines_data, :data => data }}
    end
  end

  def algorithm_statistic
    algorithm = Algorithm.find params[:algorithm_id]

    general_data = Hash.new

    algorithm.tests.each do |test|
      input_value_set_id = test.input_value_set_id

      AlgorithmOutput.where(
          algorithm_id: algorithm.id,
          input_value_set_id: input_value_set_id
      ).find_each do |algorithm_output|

        logs = Array.new

        InputLog.where(
            user_id: test.user_id,
            algorithm_id: algorithm.id,
            input_value_set_id: input_value_set_id,
            algorithm_output_data_id: algorithm_output.id
        ).find_each do |log|
          logs.push log

          general_data['users_results'] ||= Hash.new
          general_data['users_results'][test.user_id] ||= Hash.new
          general_data['users_results'][test.user_id][log.question_number] = true

          general_data['questions_info'] ||= Hash.new
          general_data['questions_info'][log.question_number] ||= Hash.new
          general_data['questions_info'][log.question_number]['errors_count'] = 0
          general_data['questions_info'][log.question_number]['current_step_id'] = log.current_step_id
        end

        logs.each do |x|
          if x.error
            general_data['users_results'][test.user_id][x.question_number] = !x.error
            general_data['questions_info'][x.question_number]['errors_count'] += 1
          end
        end

      end
    end


    p general_data


    right_steps_answers = Hash.new

    user_results_matrix = Hash.new

    users_count = 0

    general_data['users_results'].each do |user_id, results|

      users_count += 1

      user_results_matrix[user_id] = Hash.new
      right_answers = 0
      wrong_answers = 0
      questions_count = 0
      results.each do |question_number, result|
        user_results_matrix[user_id][question_number] = result

        right_steps_answers[question_number] ||= 0

        if result
          right_answers += 1
          right_steps_answers[question_number] += 1
        else
          wrong_answers += 1
        end
        questions_count += 1
      end

      user_results_matrix[user_id]['pi'] = right_answers.to_f/questions_count.to_f
      user_results_matrix[user_id]['qi'] = wrong_answers.to_f/questions_count.to_f
      #wrong_answers can be zero
      if user_results_matrix[user_id]['qi'] != 0 && user_results_matrix[user_id]['pi'] != 0
        user_results_matrix[user_id]['pi/qi'] = user_results_matrix[user_id]['pi']/user_results_matrix[user_id]['qi']
      else
        if user_results_matrix[user_id]['qi'] == 0
          user_results_matrix[user_id]['pi/qi'] = 1
        else #user_results_matrix[user_id]['pi'] == 0
          user_results_matrix[user_id]['pi/qi'] = user_results_matrix[user_id]['qi']
        end
      end
      # user_results_matrix[user_id]['pi/qi'] = user_results_matrix[user_id]['qi'] != 0 ?
      #     user_results_matrix[user_id]['pi']/user_results_matrix[user_id]['qi'] : user_results_matrix[user_id]['pi']
      user_results_matrix[user_id]['Oi'] = Math.log(user_results_matrix[user_id]['pi/qi'], Math::E)
    end


    p user_results_matrix


    questions_coefficients = Hash.new
    general_data['questions_info'].each do |question_number, question_info|
      question_data = Hash.new
      question_data['Rj'] = right_steps_answers[question_number]
      wrong_answers = users_count - right_steps_answers[question_number]
      question_data['Wj'] = wrong_answers
      question_data['pj'] = right_steps_answers[question_number].to_f/users_count.to_f
      question_data['qj'] = wrong_answers.to_f/users_count.to_f
      #wrong_answers can be zero
      if question_data['qj'] != 0 && question_data['pj'] != 0
        question_data['pj/qj'] = question_data['pj']/question_data['qj']
      else
        if question_data['qj'] == 0
          question_data['pj/qj'] = 1
        else #question_data['pj'] == 0
          question_data['pj/qj'] = question_data['qj']
        end
      end
      # question_data['pj/qj'] = question_data['qj'] != 0 ? question_data['pj']/question_data['qj'] : question_data['pj']
      question_data['Bj'] = Math.log(question_data['pj/qj'], Math::E)
      question_data['step_number'] = question_info['current_step_id']
      if question_info['errors_count'] == 0
        aj = 0
      else
        aj = Math.log(question_info['errors_count'], Math::E)
      end
      question_data['aj'] = 1 + aj

      questions_coefficients[question_number] = question_data
    end


    p questions_coefficients


    output_data = Hash.new

    questions_difficulty = Array.new

    algorithm_difficulty = 0.0

    questions_coefficients.each do |key, value|
      graph_obj = Hash.new
      graph_obj['question'] = key
      algorithm_difficulty += value['Bj'] * value['aj']
      graph_obj['value'] = value['Bj'] * value['aj']
      questions_difficulty.push graph_obj
    end

    preparedness_level = Array.new
    user_number = 1

    user_results_matrix.each do |key, value|
      user_graph = Hash.new
      user_graph['number'] = user_number
      user_graph['value'] = value['Oi']
      preparedness_level.push user_graph
      user_number += 1
    end


    # answer_graph = Array.new
    #
    # general_data['users_results'].each do |key, value|
    #   user_answers = Array.new
    #   value.each do |question, answer|
    #     answers = Hash.new
    #     answers['question'] = question
    #     answers['answer'] = answer
    #     user_answers.push answers
    #   end
    #   answer_graph.push user_answers
    # end

    output_data['questions_difficulty'] = questions_difficulty
    output_data['algorithm_difficulty'] = algorithm_difficulty
    output_data['preparedness_level'] = preparedness_level
    # output_data['answer_graph'] = answer_graph


    respond_to do |format|
      format.js {render json: output_data.to_json}
    end
  end

  def get_stats
    algorithm = Algorithm.find params[:algorithm_id]
    # algorithm = Algorithm.find 35

    general_data = Hash.new

    algorithm.tests.each do |test|
      input_value_set_id = test.input_value_set_id

      AlgorithmOutput.where(
          algorithm_id: algorithm.id,
          input_value_set_id: input_value_set_id
      ).find_each do |algorithm_output|

        logs = Array.new

        InputLog.where(
            user_id: test.user_id,
            algorithm_id: algorithm.id,
            input_value_set_id: input_value_set_id,
            algorithm_output_data_id: algorithm_output.id
        ).find_each do |log|
          logs.push log

          general_data['users_results'] ||= Hash.new
          general_data['users_results'][test.user_id] ||= Hash.new
          general_data['users_results'][test.user_id][log.question_number] = true

          general_data['questions_info'] ||= Hash.new
          general_data['questions_info'][log.question_number] ||= Hash.new
          general_data['questions_info'][log.question_number]['errors_count'] = 0
          general_data['questions_info'][log.question_number]['current_step_id'] = log.current_step_id
        end

        logs.each do |x|
          if x.error
            general_data['users_results'][test.user_id][x.question_number] = !x.error
            general_data['questions_info'][x.question_number]['errors_count'] += 1
          end
        end

      end
    end

    right_steps_answers = Hash.new

    user_results_matrix = Hash.new

    users_count = 0

    questions_count = 0

    general_data['users_results'].each do |user_id, results|

      users_count += 1

      user_results_matrix[user_id] = Hash.new
      right_answers = 0
      wrong_answers = 0
      results.each do |question_number, result|
        user_results_matrix[user_id][question_number] = result

        right_steps_answers[question_number] ||= 0

        if result
          right_answers += 1
          right_steps_answers[question_number] += 1
        else
          wrong_answers += 1
        end
        questions_count += 1
      end

      user_results_matrix[user_id]['pi'] = right_answers.to_f/questions_count.to_f
      user_results_matrix[user_id]['qi'] = wrong_answers.to_f/questions_count.to_f
      #wrong_answers can be zero
      if user_results_matrix[user_id]['qi'] != 0 && user_results_matrix[user_id]['pi'] != 0
        user_results_matrix[user_id]['pi/qi'] = user_results_matrix[user_id]['pi']/user_results_matrix[user_id]['qi']
      else
        if user_results_matrix[user_id]['qi'] == 0
          user_results_matrix[user_id]['pi/qi'] = 1
        else #user_results_matrix[user_id]['pi'] == 0
          user_results_matrix[user_id]['pi/qi'] = user_results_matrix[user_id]['qi']
        end
      end
      user_results_matrix[user_id]['Oi'] = Math.log(user_results_matrix[user_id]['pi/qi'], Math::E)
    end

    questions_coefficients = Hash.new
    general_data['questions_info'].each do |question_number, question_info|
      question_data = Hash.new
      question_data['Rj'] = right_steps_answers[question_number]
      wrong_answers = users_count - right_steps_answers[question_number]
      question_data['Wj'] = wrong_answers
      question_data['pj'] = right_steps_answers[question_number].to_f/users_count.to_f
      question_data['qj'] = wrong_answers.to_f/users_count.to_f
      #wrong_answers can be zero
      if question_data['qj'] != 0 && question_data['pj'] != 0
        question_data['pj/qj'] = question_data['pj']/question_data['qj']
      else
        if question_data['qj'] == 0
          question_data['pj/qj'] = 1
        else #question_data['pj'] == 0
          question_data['pj/qj'] = question_data['qj']
        end
      end
      question_data['Bj'] = Math.log(question_data['pj/qj'], Math::E)
      question_data['step_number'] = question_info['current_step_id']
      if question_info['errors_count'] == 0
        aj = 0
      else
        aj = Math.log(question_info['errors_count'], Math::E)
      end
      question_data['aj'] = 1 + aj

      questions_coefficients[question_number] = question_data
    end

    csv_file = CSV.generate do |csv|

      csv << ['sep=,']

      title_data = Array.new
      title_data.push 'N N'
      questions_count.times do |i|
        title_data.push ('X' + (i + 1).to_s)
      end
      title_data.push 'pi'
      title_data.push 'qi'
      title_data.push 'pi/qi'
      title_data.push 'Oi'

      csv << title_data

      user_results_matrix.each do |key, value|
        user_array = Array.new
        user_array.push key
        value.each do |q_number, u_answer|
          user_array.push (u_answer ? 1: 0)
        end

        csv << user_array
      end

      q_coef = Array.new
      q_coef.push 'Rj'
      questions_coefficients.each do |key, value|
        q_coef.push value['Rj']
      end
      csv << q_coef
      q_coef.clear

      q_coef.push 'Wj'
      questions_coefficients.each do |key, value|
        q_coef.push value['Wj']
      end
      csv << q_coef
      q_coef.clear

      q_coef.push 'pj'
      questions_coefficients.each do |key, value|
        q_coef.push value['pj']
      end
      csv << q_coef
      q_coef.clear

      q_coef.push 'qj'
      questions_coefficients.each do |key, value|
        q_coef.push value['qj']
      end
      csv << q_coef
      q_coef.clear

      q_coef.push 'pj/qj'
      questions_coefficients.each do |key, value|
        q_coef.push value['pj/qj']
      end
      csv << q_coef
      q_coef.clear

      q_coef.push 'Bj'
      questions_coefficients.each do |key, value|
        q_coef.push value['Bj']
      end
      csv << q_coef
      q_coef.clear
    end

      # csv.generate_line title_data
    # end





    send_data csv_file, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=csv.csv"
  end

end
