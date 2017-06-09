# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->

  $('input[value="First step"]').addClass('paramsHolder')
# need to correct class for all cells
  $('.matrix_cell').bind 'input', () ->
    min = $(this).data 'min-value'
    max = $(this).data 'max-value'

    if ($(this).val() < min || $(this).val() > max)
      if $(this).val() != ''
        $(this).css('background-color', 'red')
    else
      $(this).css('background-color', '')

  $('.button_to').bind 'click', () ->
    list = []
    $('.matrix_cell').each ->
      if list[$(this).data 'row'] == undefined
        list[$(this).data 'row'] = [];
      list[$(this).data 'row'][$(this).data 'column'] = $(this).val()

    json_list = JSON.stringify list

    params_holder = $('.paramsHolder')

    next_step_id = params_holder.data('step') + 1

    action_string = '/step/test?algorithm_id=' + params_holder.data('algorithm') + '&step_id=' + next_step_id + '&matrix=' + json_list

    $(this).attr('action', action_string)

    params_holder.data('step', next_step_id)
