resetAllWizardFilters = ->
  if $(".wizard_type_selects").length > 0
    $(".wizard_type_selects").each ->
      $(@).find(".btn.active").removeClass("active")
      $(@).find(".btn.all").addClass("active")
  
  if $(".wizard_type_select_dropdown").length > 0
    $(".wizard_type_select_dropdown").each ->
      if $(@).hasClass("icn_slct")
        $(@).find(".dropdown-toggle").html( $(@).find("a.all .icn").html() )
      else
        $(@).find(".dropdown-toggle").html( $(@).find("a.all").html() )

  if $(".select_wizard_table_stuff").length > 0
    $(".select_wizard_table_stuff").each ->
      jQuery(@).val("ALL")


tableFilter = {}
tableQuery  = null

checkTable = ->
  count   = 0
  console?.log? "checkTable", tableFilter, tableQuery
  $(".wizard_table_body > *").each ->
    data    = jQuery(@).data()
    checker = []
    if tableQuery && tableQuery != ""
      checkQ = false
      for key,value of data
        checkQ = true if "#{value}".toLowerCase().indexOf(tableQuery) isnt -1
      checker.push checkQ
    for filterKey,filterValue of tableFilter
      check = if (data[ filterKey ] == filterValue) || ("#{data[ filterKey ]}" == "#{filterValue}") then true else false
      checker.push check
    if checker.indexOf( false ) is -1
      count += 1
      jQuery(@).show()
    else
      jQuery(@).hide()



$ ->
  
  if $("#search_wizard_table").length > 0
    $("body").on "keyup", "#search_wizard_table", ->
      # resetAllWizardFilters()
      stuff = jQuery(@).val().toLowerCase()
      count = 0
      if stuff != ""
        tableQuery = stuff
        checkTable()
      else
        tableQuery = null
        checkTable()


  if $(".wizard_type_selects").length > 0
    $("body").on "click", ".wizard_type_selects .btn", ->
      nav  = $(@).closest(".wizard_type_selects")
      type = nav.data().select
      # resetAllWizardFilters()
      nav.find(".btn.active").removeClass("active")
      jQuery(@).addClass("active")
      that = jQuery(@).data()[type]
      if that == "all"
        delete tableFilter[type] if tableFilter[type]
        checkTable()
      else
        tableFilter[type] = that
        checkTable()


  if $(".wizard_type_select_dropdown").length > 0
    $("body").on "click", ".wizard_type_select_dropdown a", (e) ->
      e.preventDefault()
      nav  = $(@).closest(".wizard_type_select_dropdown")
      btn  = nav.find(".btn")
      type = nav.data().select
      # resetAllWizardFilters()
      nav.find("a.active").removeClass("active")
      jQuery(@).addClass("active")
      that = jQuery(@).attr("data-value")
      if nav.hasClass("icn_slct")
        nav.find(".dropdown-toggle").html( jQuery(@).find(".icn").html() )
      else
        nav.find(".dropdown-toggle").html( jQuery(@).html() )
      if that == "all"
        btn.removeClass("btn-warning")
        delete tableFilter[type]
        checkTable()
      else
        btn.addClass("btn-warning")
        tableFilter[type] = that
        checkTable()


  if $(".select_wizard_table_stuff").length > 0
    $("body").on "change", ".select_wizard_table_stuff", ->
      type = $(@).data().select
      that = jQuery(@).val()
      # resetAllWizardFilters()
      # jQuery(@).val(that)
      if that == "ALL"
        $(@).removeClass("warning-color")
        delete tableFilter[type] if tableFilter[type]
        checkTable()
      else
        $(@).addClass("warning-color")
        tableFilter[type] = that
        checkTable()


