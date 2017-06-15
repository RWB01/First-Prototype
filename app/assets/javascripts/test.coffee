# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "turbolinks:load", ->

  $(document).ready ->

    get_matrix_params =(matrix_el, param_bug, cell_class) ->

      variable_id = matrix_el.data('variable-id')

      param_bug[variable_id] = [];

      matrix_el.find(cell_class).each ->
        if param_bug[variable_id][$(this).data 'row'] == undefined
          param_bug[variable_id][$(this).data 'row'] = []

        param_bug[variable_id][$(this).data 'row'][$(this).data 'column'] = $(this).val()

      return param_bug

    # end of function

    get_single_param =(number_el, param_bug, cell_class) ->

      variable_id = number_el.data('variable-id')

      param_bug[variable_id] = number_el.find(cell_class).val()

      return param_bug

    # end of function

    $('input[value="First step"]').addClass('paramsHolder')

  # need to correct class for all cells
    $('.input_cell').bind 'input', () ->
      min = $(this).data 'min-value'
      max = $(this).data 'max-value'

      if ($(this).val() < min || $(this).val() > max)
        if $(this).val() != ''
          $(this).css('background-color', 'red')
      else
        $(this).css('background-color', '')

    # end of function

    $('.button_to').bind 'click', () ->

#      list = []
#      $('.matrix_cell').each ->
#        if list[$(this).data 'row'] == undefined
#          list[$(this).data 'row'] = [];
#        list[$(this).data 'row'][$(this).data 'column'] = $(this).val()
#
#      json_list = JSON.stringify list
#
#      params_holder = $('.paramsHolder')
#
#      next_step_id = params_holder.data('step') + 1
#
#      action_string = '/step/test?algorithm_id=' + params_holder.data('algorithm') + '&step_id=' + next_step_id + '&matrix=' + json_list
#
#      $(this).attr('action', action_string)
#
#      params_holder.data('step', next_step_id)

      param_bag = {}

      $('.step_variable').each ->
        if $(this).hasClass('matrix_type')
          param_bag = get_matrix_params($(this), param_bag, '.matrix_cell')

        else if $(this).hasClass('vector_type')
          param_bag = get_matrix_params($(this), param_bag, '.vector_cell')

        else if $(this).hasClass('number_type')
          param_bag = get_single_param($(this), param_bag, '.number_cell')

        else if $(this).hasClass('string_type')
          param_bag = get_single_param($(this), param_bag, '.string_cell')

      json_param_bug = JSON.stringify(param_bag)

      params_holder = $('.paramsHolder')

      # may be that logick should be in the test_controller?
      next_step_id = params_holder.data('step') + 1

      action_string = '/step/test?algorithm_id=' + params_holder.data('algorithm') + '&step_id=' + next_step_id + '&variables_params=' + json_param_bug

      $(this).attr('action', action_string)

      params_holder.data('step', next_step_id)

    # end of function

    get_json =(param_bug) ->


    #need custom json_parse function




