#= require jquery
## require jquery_ujs
#= require magic/ext/rails-ujs
## require jquery-ui

## require i18n
## require i18n/translations

#= require jquery.fileupload

#= require magic-min
## require magic/render_eco

#= require app/admin
#= require app/forms
#= require app/helpers
#= require app/uploads

#= require_self



# little string helper
# http://www.oct4th.com/2013/03/15/titleize-for-javascript/
String::titleize = ->
  words = @split(' ')
  array = []
  i = 0
  while i < words.length
    array.push words[i].charAt(0).toUpperCase() + words[i].toLowerCase().slice(1)
    ++i
  array.join ' '


if typeof String::trim == 'undefined'
  String::trim = ->
    String(this).replace /^\s+|\s+$/g, ''


$ ->

  $("body").on "click", "#rightAside .close", (e) ->
    e.preventDefault()
    console?.log? "Click rightAside close"
    if $(@).attr("data-unactivate")
      $("#{ $(@).attr("data-unactivate") }.active").removeClass("active")
    if $(@).attr("data-unset-bodydata")
      $("body").attr("data-#{ $(@).attr("data-unset-bodydata") }", null)
    $("body").toggleClass("with_info_aside")
    false


  $('[data-toggle="popover"]').popover({trigger: 'click'})


  # lastY = 0
  # $(window).bind 'touchmove mousewheel', (e) ->
  #   currentY = if e.originalEvent.touches then e.originalEvent.touches[0].pageY else e.pageY
  #   return if Math.abs(currentY - lastY) < 10
  #   if currentY > lastY
  #     $("#fixed_nav").removeClass("fixed")
  #     # console.log 'moving down'
  #   else
  #     if $("body").scrollTop() > 50
  #       $("#fixed_nav").addClass("fixed")
  #     else
  #       $("#fixed_nav").removeClass("fixed")
  #     # console.log 'moving up'
  #   lastY = currentY
  #   return


  $("body").on "click", "#feedbackModaltoggle", (e) ->
    $("#feedbackModal").modal({show: true})


  $("body").on "click", ".app-logo .toggl", (e) ->
    e.preventDefault()
    $("body").toggleClass("with_open_aside")
    false


  $("body").on "click", ".main-aside .aside_lnk.toggler, .main-aside .aside_lnk .toggler", (e) ->
    e.preventDefault()
    if $(@).hasClass("aside_lnk")
      $(@).toggleClass("on")
    else
      $(@).closest(".aside_lnk").toggleClass("on")
    false

