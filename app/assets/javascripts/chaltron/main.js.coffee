$ ->
  # Flash
  if (flash = $('.flash-container div.alert')).length > 0
    flash.click -> $(@).fadeOut()
    setTimeout (-> flash.fadeOut()), 5000

$(document).on 'turbolinks:load', ->
  $('.dropdown-toggle').dropdown()
