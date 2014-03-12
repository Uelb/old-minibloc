# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.make-switch input').change ->
    checked = $(this).prop 'checked'
    id = $(this).attr "name"
    if checked
      url = "phones/" + id + "/use"
    else
      url = "phones/" + id + "/unuse"
    $.post url