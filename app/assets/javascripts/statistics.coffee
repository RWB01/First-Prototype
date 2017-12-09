# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "turbolinks:load", ->

  $(document).ready ->

    algorithm_id = 0

    $('.get_stats').hide()

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
      algorithm_id = $(this).val()

      $('.get_stats').find('input[name=algorithm_id]').val(algorithm_id)

      $('.get_stats').show()

      $.ajax({
        'url': '/statistics/algorithm_statistic'
        'data': {
          algorithm_id: algorithm_id
        }
        'type': 'GET'
        'dataType': 'json'
      }).done((data) ->

        ff = data['algorithm_difficulty']
        $('.general_difficulty').text(ff)

        MG.data_graphic({
          title: "Сложность шагов алгоритма",
          data: data['questions_difficulty'],
          width: 600,
          height: 320,
          right: 10,
          target: '.difficulty_graphic',
          x_accessor: 'question',
          y_accessor: 'value'
        })

        MG.data_graphic({
          title: "Уровень подготовленности студентов",
          data: data['preparedness_level'],
          width: 600,
          height: 320,
          right: 10,
          target: '.preparedness_graphic',
          x_accessor: 'number',
          y_accessor: 'value'
        })
      );

