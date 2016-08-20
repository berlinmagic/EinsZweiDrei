## Form helper and functions

loadFormFuntions = ->
  ##
  ##

$ ->
  
  # loadFormFuntions()

  # reset bootstrap modals when closed (needed for remote content)
  $('body').on 'hidden.bs.modal', '.modal', ->
    console.log "modal - hidden"
    return $(this).removeData 'bs.modal'

  # $('body').on 'shown.bs.modal', '.modal', ->
  #   # updateLocationFormAllGoogleFields()
  #   setTimeout ->
  #     loadFormFuntions()
  #   , 200
  #   false

  
  $('body').on 'click', 'form .remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('.form_fiels_box').hide()
    event.preventDefault()


  $('body').on 'click', 'form .add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    tag = $(this).get(0).nodeName.toLowerCase()
    console?.log? regexp
    # if (tag == 'A') or (tag == 'a')
    #   that = tag
    # else
    #   that = tag.closest("a")
    if $(this).data("target") && $(this).data("target") != ""
      # $(this).parent().find(".#{$(this).data("target")}").append( $(this).data('fields').replace(regexp, time) )
      $(this).closest("form").find(".#{$(this).data("target")}").append( $(this).data('fields').replace(regexp, time) )
    else if $(this).hasClass("intable")
      $(this).parent().find("table").append( $(this).data('fields').replace(regexp, time) )
    else
      $(this).before( $(this).data('fields').replace(regexp, time) )
    # updateLocationFormAllGoogleFields()
    event.preventDefault()


  