# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "turbolinks:load", ->

  $(document).ready ->

    timestamp = Math.round((new Date()).getTime() / 1000)

    # CURRENT QUESTION
    current_question_id = 0

    # CURRENT STEP
    current_step_id = 0

    # WE MUST KNOW WHAT THE STEP IS NEXT
    array_of_questions_and_steps = {}
    last_question_number = 0
    for key, value of gon.algorithm_output_data
      step_data = JSON.parse(value)
      array_of_questions_and_steps[step_data['QuestionNumber']] = step_data['StepNumber']
      last_question_number = last_question_number + 1

    preset_matrix_input_value =(input_variable, input_data) ->

      rows = input_variable.find '.matrix_row'
        cells = $(this).find '.matrix_cell'
        cells.each ->
          $(this).val input_data[$(this).data('row')][$(this).data('column')]

    # end of function

    preser_vector_input_value =(vector_el, input_data) ->

      cells = vector_el.find('.vector_cell')
      cells.each ->
        $(this).val input_data[$(this).data('column')]

    # end of function

    # if initial step, we shouldn't validate data
    # we can get current step number from nxt_step_btn
    # need to load data from controller and autofil inputs
    if gon != undefined
      if gon.algorithm_input_data != undefined
        if current_question_id == 0
          parsed_input_values = JSON.parse gon.algorithm_input_data

          for input_variable_name, input_variable_value of parsed_input_values
            input_variable = $("[data-variable-name=#{input_variable_name}]")
            if input_variable.hasClass 'matrix_type'
              preset_matrix_input_value(input_variable, input_variable_value)
            else if input_variable.hasClass 'vector_type'
              preser_vector_input_value(input_variable.find('.vector_row'), input_variable_value)
            else if input_variable.hasClass 'string_type'
              string_cell = input_variable.find('.string_cell')
              string_cell.val input_variable_value
            else if input_variable.hasClass 'number_type'
              number_cell = input_variable.find('.number_cell')
              number_cell.val input_variable_value

          $('.step_variable').find(':input').prop('disabled', true).addClass('frozen_input')

    # end of function

    get_matrix_params =(matrix_el, param_bug, cell_class) ->

      variable_id = matrix_el.data('variable-id')
      variable_name = matrix_el.data('variable-name')

      param_bug[variable_name] = [];
      value = []
      matrix_el.find(cell_class).each ->
        if value[$(this).data 'row'] == undefined
          value[$(this).data 'row'] = []

        value[$(this).data 'row'][$(this).data 'column'] = parseInt($(this).val())

      param_bug[variable_name]['type'] = 'Matrix'
      param_bug[variable_name]['value'] = value

      return param_bug


    get_vector_params =(vactor_el, param_bug, cell_class) ->

      variable_id = vactor_el.data('variable-id')
      variable_name = vactor_el.data('variable-name')

      param_bug[variable_name] = [];

      vactor_el.find(cell_class).each ->
        if param_bug[variable_name]['type'] == undefined
          param_bug[variable_name]['type'] = 'Vector'

        if param_bug[variable_name]['value'] == undefined
          param_bug[variable_name]['value'] = []
        param_bug[variable_name]['value'][$(this).data 'column'] = parseInt($(this).val())

      return param_bug

    # end of function

    get_single_param =(number_el, param_bug, cell_class, is_number) ->

      variable_id = number_el.data('variable-id')
      variable_name = number_el.data('variable-name')

      param_bug[variable_name] = []

      cell_value = number_el.find(cell_class).val()
      if is_number
        cell_value = parseInt(cell_value)
        param_bug[variable_name]['type'] = 'Number'
      else
        param_bug[variable_name]['type'] = 'String'

      param_bug[variable_name]['value'] = cell_value

      return param_bug

    # end of function

    $('input[value="First step"]').addClass('paramsHolder')

    simple_array_equal =(a, b, var_name) ->
      result = (a.length is b.length )
      dom_of_variable = $('.test_body').find(".step_variable[data-variable-name='#{var_name}']")
      for key, value of a
        # i - index
        if !(value is b[key])
          dom_of_variable.find("[data-column='#{key}']").addClass('incorrect_value')
          result = false
        else
          dom_of_variable.find("[data-column='#{key}']").addClass('valid_value')

      return result

#    complex_array_equal =(a, b, var_name) ->
#      result = (a.length is b.length )
#      dom_of_variable = $('.test_body').find(".step_variable[data-variable-name='#{var_name}']")
#      for x_key, x_value of a
#        for y_key, y_value of x_value
          #
#          fuck = 'fuck'
#          if !(y_value[y_key] is b[x_key][y_key])
#            dom_of_variable.find("[data-row='#{x_key}'][data-column='#{y_key}']").addClass('incorrect_value')
#          else
#            dom_of_variable.find("[data-row='#{x_key}'][data-column='#{y_key}']").addClass('valid_value')

    #      a.length is b.length and a.every (row, i) ->
#        row.every (column, j) ->
#          column is b[i][j]

    $('.test_process_wrapper').on 'click', '.button_to', () ->

      if !$(this).hasClass('next_button')
        $(this).addClass('next_button')

      if $('.empty_value').length == 0

        param_bag = {}

        $('.step_variable').each ->
          if $(this).hasClass('matrix_type')
            param_bag = get_matrix_params($(this), param_bag, '.matrix_cell')

          else if $(this).hasClass('vector_type')
            param_bag = get_vector_params($(this), param_bag, '.vector_cell')

          else if $(this).hasClass('number_type')
            param_bag = get_single_param($(this), param_bag, '.number_cell', true)

          else if $(this).hasClass('string_type')
            param_bag = get_single_param($(this), param_bag, '.string_cell', false)

        nxt_step_btn = $(this).find('[data-step]')
        algorithm_id = parseInt(nxt_step_btn.data('algorithm'))
        chosen_next_step_id= parseInt(nxt_step_btn.data('step'))
        is_last_quesion_number = parseInt(nxt_step_btn.data('last'))

        got_problems = false


        if current_question_id != 0 && chosen_next_step_id != -1 
          is_right_next_step = false
          for key, value of array_of_questions_and_steps
            if parseInt(key) == (current_question_id + 1) && value == chosen_next_step_id
              is_right_next_step = true
        else
          is_right_next_step = true

        if current_question_id == last_question_number && chosen_next_step_id == -1
          is_right_next_step = true

        if current_question_id != last_question_number && chosen_next_step_id == -1 || current_question_id == last_question_number && chosen_next_step_id != -1
          is_right_next_step = false

        if gon.algorithm_output_data != undefined && current_question_id != 0 && is_right_next_step

          for key, value of gon.algorithm_output_data
            step_data = JSON.parse(value)
            if step_data['QuestionNumber'] == current_question_id && step_data['StepNumber'] == current_step_id
              for var_name, var_value of step_data['Variables']
                user_var_data = param_bag[var_name]
                all_data = {}
                wrong_data = {}
                if user_var_data['type'] == 'Vector'
                  result = simple_array_equal(user_var_data['value'], var_value, var_name)
                else if user_var_data['type'] == 'Matrix'
#                  result = complex_array_equal(user_var_data['value'], var_value, var_name)
                else
                  result = user_var_data['value'] == var_value
                if !result
                  got_problems = true;

                  #SHITCODING TO STRINGIFY ARRAYS, JS CAN'T STRINGIFY ARRAYS, ONLY HASH
                  wrong_data[var_name] = {}
                  wrong_data[var_name]['type'] = user_var_data['type']
                  wrong_data[var_name]['value'] = JSON.stringify(user_var_data['value'])

                #SHITCODING TO STRINGIFY ARRAYS, JS CAN'T STRINGIFY ARRAYS, ONLY HASH
                all_data[var_name] = {}
                all_data[var_name]['type'] = user_var_data['type']
                all_data[var_name]['value'] = JSON.stringify(user_var_data['value'])

          wrong_json_data = JSON.stringify(wrong_data)
          all_json_data = JSON.stringify(all_data)

          # NEED TO SET WRONG STEP ATTEMPT
          $.ajax({
            'url': '/input_logs/add_log'
            'data': {
              user_id: gon.user_id
              input_value_set_id: gon.input_value_set_id
              algorithm_id: algorithm_id
              question_number: current_question_id
              wrong_data: wrong_json_data
              all_data: all_json_data
              algorithm_output_data_id: gon.algorithm_output_id
              error: got_problems
              timestamp: timestamp
              wrong_step_id: null
              current_step_id: current_step_id
            }
            'type': 'POST'
            'dataType': 'json'
          })
        #
        if !got_problems && is_right_next_step
          if current_question_id == 0
            if gon.algorithm_output_data != undefined
              first_value = JSON.parse gon.algorithm_output_data[0]
              current_question_id = first_value['QuestionNumber']
              next_step_id = current_step_id = first_value['StepNumber']
          else
            is_last_question = true
            # need a function
            for key, value of gon.algorithm_output_data
              step_val = JSON.parse(value)
              if step_val['QuestionNumber'] == (current_question_id + 1) && is_last_question
                current_question_id = step_val['QuestionNumber']
                next_step_id = current_step_id= step_val['StepNumber']
                is_last_question = false

          # may be that logick should be in the test_controller?
          if is_last_question
            alert('Вы успешно завершили тестирование!')

            action_string = '/result/test?timestamp=' + timestamp + '&user_id=' + gon.user_id + '&input_value_set_id=' + gon.input_value_set_id + '&algorithm_id=' + algorithm_id

            $(this).attr('action', action_string)
          else

            $('.step_variable').each ->
              $(this).removeClass('step_variable')

            action_string = '/step/test?algorithm_id=' + algorithm_id + '&step_id=' + next_step_id + '&current_question_id=' + current_question_id + '&user_id=' + gon.user_id
            $(this).attr('action', action_string)
        else

          if (got_problems)
            alert('Вы выбрали неправильный ответ, попробуйте снова.')

            $('').insertAfter('.step_variable')
            # we must show error message and do nothing after
            nxt_step_btn.prop 'disabled', true

          if (!is_right_next_step)
            $.ajax({
              'url': '/input_logs/add_log'
              'data': {
                user_id: gon.user_id
                input_value_set_id: gon.input_value_set_id
                algorithm_id: algorithm_id
                question_number: current_question_id
                wrong_data: []
                all_data: []
                algorithm_output_data_id: gon.algorithm_output_id
                error: !is_right_next_step
                timestamp: timestamp
                wrong_step_id: chosen_next_step_id
                current_step_id: current_step_id
              }
              'type': 'POST'
              'dataType': 'json'
            })

            alert('Вы выбрали неправильный ответ, попробуйте снова.')

            nxt_step_btn.prop 'disabled', true

      else

        alert('Похоже что-то пошло не так')

        $nxt_step_btn.prop 'disabled', true

    # end of function

  # TODO: Fix DRY!
  $(document).on 'input', '.input_cell', () ->
    $('.test_body').find('[data-step]').prop 'disabled', false
  # end of function

  $('.step_checkbox').bind 'click', () ->
    description = $(this).parent().parent().find('.description')
    if $(this).is( ":checked" )

      description.show('slow')
    else
      description.hide('slow')
