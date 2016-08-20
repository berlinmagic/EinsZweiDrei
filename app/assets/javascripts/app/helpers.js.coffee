@setFlashMSG = ( msg, type = "notice" ) ->
  if jQuery(".application_notice").length == 0
    $("body").prepend( $("<div class='application_notice'></div>") )
  $(".application_notice").removeClass("visible")
  jQuery(".application_notice").html( renderView("flash_msgs", {type: type, msg: msg}) )
  checkAppNotifications()


checkAppNotifications = ->
  clearTimeout( noticeShowTimer ) if noticeShowTimer
  clearTimeout( noticeHideTimer ) if noticeHideTimer
  if jQuery(".application_notice div").length > 0
    # noticeTimer = setTimeout(->
    #   $(".application_notice div").slideUp();
    # , 3500)
    noticeShowTimer = setTimeout(->
      $(".application_notice").addClass("visible")
    , 50)
    noticeHideTimer = setTimeout(->
      $(".application_notice").removeClass("visible")
    , 5500)


$ ->
  
  checkAppNotifications()
  
  
  $("body").on "click", ".close_important_notice", (e) ->
    e.preventDefault()
    $("body").removeClass("with_important_notice")
    $(".important_notice").replaceWith(" ")

