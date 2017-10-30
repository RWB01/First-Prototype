class InputLogsController < ApplicationController

  def add_log
    data = params

    input_log = InputLog.new
    input_log.user_id = data[:user_id]
    input_log.input_value_set_id = data[:input_value_set_id]
    input_log.algorithm_id = data[:algorithm_id]
    input_log.question_number = data[:question_number]
    input_log.wrong_data = data[:wrong_data]
    input_log.all_data = data[:all_data]
    input_log.algorithm_output_data_id = data[:algorithm_output_data_id]
    input_log.error = data[:error]
    input_log.timestamp = data[:timestamp]

    input_log.save
  end

end
