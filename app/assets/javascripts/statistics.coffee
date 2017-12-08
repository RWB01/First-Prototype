# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "turbolinks:load", ->

  $(document).ready ->

    $('.discipline_select').bind 'change', () ->
      discipline_id = $(this).val()
      $.ajax({
        'url': '/disciplines/get_themes_by_discipline_id'
        'data': {
          id: discipline_id
        }
        'type': 'GET'
        'dataType': 'json'
      }).done((data) ->
        select = $('.theme_select')
        for theme in data
          select.append($("<option></option>").attr("value", theme['id']).text(theme['title']))
      );

    $('.theme_select').bind 'change', () ->
      theme_id = $(this).val()
      $.ajax({
        'url': '/themes/get_algorithms_by_theme_id'
        'data': {
          id: theme_id
        }
        'type': 'GET'
        'dataType': 'json'
      }).done((data) ->
        select = $('.algorithm_select')
        for algorithm in data
          select.append($("<option></option>").attr("value", algorithm['id']).text(algorithm['title']))
      );

    $('.algorithm_select').bind 'change', () ->
      algprithm_id = $(this).val()
      #
      $.ajax({
        'url': '/statistics/algorithm_statistic'
        'data': {
          algorithm_id: algprithm_id
        }
        'type': 'GET'
        'dataType': 'json'
      }).done((data) ->
        #
        fuck = 'fuck'
      );

