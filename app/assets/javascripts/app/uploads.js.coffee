checkForUploadFields = ->
  if $("#avatar_or_logo_form").length > 0 
    console.log "avatar_form exists"
    $("#avatar_or_logo_form").fileupload
      dataType: "script"
      type: "PATCH"
      add: (e, data) ->
        console.log "add", data
        file = undefined
        types = undefined
        # types = /(\.|\/)(gif|jpe?g|png|tif?f)$/i;
        file = data.files[0]
        data.tmpl = $('<div class="upload upload_progress" data-name="' + file["name"] + '"><div class="preview"><span class="fade"></span></div>' + file["name"] + '<div class="progress"><div class="bar" style="width: 0%"></div></div></div>HuHI')
        # $("#form_uploads").append data.tmpl
        $("#avatar_upload_progress").append data.tmpl
        data.submit()

      progress: (e, data) ->
        console.log "progress", data
        progress = undefined
        if data.tmpl
          progress = parseInt(data.loaded / data.total * 100, 10)
          console.log "progress", progress
          data.tmpl.find(".bar").css "width", progress + "%"


  if $(".document_form").length > 0
    $(".document_form").each ->
      that = $(@).attr("id")
      $("##{that}").fileupload
        dataType: "script"
        dropZone: $("##{that}")
        add: (e, data) ->
          console.log "add", data
          file = undefined
          types = undefined
          # types = /(\.|\/)(gif|jpe?g|png|tif?f)$/i;
          file = data.files[0]
          data.tmpl = $('<div class="upload upload_progress" data-name="' + file["name"] + '"><div class="preview"><span class="fade"></span></div>' + file["name"] + '<div class="progress"><div class="bar" style="width: 0%"></div></div></div>')
          # $("#form_uploads").append data.tmpl
          $("##{that}").append data.tmpl
          data.submit()

        progress: (e, data) ->
          console.log "progress", data
          progress = undefined
          if data.tmpl
            progress = parseInt(data.loaded / data.total * 100, 10)
            console.log "progress", progress
            data.tmpl.find(".bar").css "width", progress + "%"

$ ->
  
  # File-Uploads
  checkForUploadFields()