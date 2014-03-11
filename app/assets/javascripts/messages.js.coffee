# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  setInterval(->
    $.get("/messages", {no_layout: true}, (data)->
      $(".mainbar .col-md-12").replaceWith(data))
  ,5000)