#= require jquery

shuffle = (source) ->
  # Arrays with < 2 elements do not shuffle well. Instead make it a noop.
  return source unless source.length >= 2
  # From the end of the list to the beginning, pick element `index`.
  for index in [source.length-1..1]
    # Choose random element `randomIndex` to the front of `index` to swap with.
    randomIndex = Math.floor Math.random() * (index + 1)
    # Swap `randomIndex` with `index`, using destructured assignment
    [source[index], source[randomIndex]] = [source[randomIndex], source[index]]
  source

random = ->
   Math.floor(Math.random() * (3 - 1 + 1)) + 1


colorz            = ["r", "g", "b"]
stylez            = ["l", "s", "d"]

selectTime        = 1000 * 12
intervalTime      = 120
intervalStep      = 20
intervalStepEvery = 1000
currentTime       = 0
showTime          = 1000 * 3


colors = ["blau", "gelb", "lila"]
interval  = null
timeout   = null
bgColor = 0
fgColor = 0



getColor = (clr) ->
  if clr < 0
    2
  else
    if clr > 2 then 0 else clr

changeColors = ->
  # colors = shuffle( ["blau", "gelb", "lila"] )
  bgColor = getColor( bgColor - 1 )
  # fgColor = getColor( fgColor + 1 )
  $("table.fullpage").find("td").each ->
    # $(@).attr( "class", colors[bgColor] )
    $(@).attr( "class", "#{colorz[bgColor]}#{stylez[random()-1]}" )
    # $(@).find("span").attr( "class", colors[fgColor] )
    bgColor = getColor( bgColor + 1 )
    # fgColor = getColor( fgColor - 1 )


activateField = (field) ->
  # $("#field-#{field}").removeClass("stoped")
  $("table.fullpage").find("td").each ->
    console.log "Field: #{ $(@).attr("id") } == #{field} ?"
    unless $(@).attr("id") == "field-#{ field }"
      $(@).attr("class", "stoped")


colorInterval = ( timer ) ->
  interval = setInterval ->
    changeColors()
  , timer

fireAction = ( upstep = 0 ) ->
  intervalTime = upstep + intervalTime
  console.log "Step-Time: ", intervalTime
  clearInterval interval  if interval
  clearTimeout timeout    if timeout
  if currentTime < selectTime
    colorInterval( intervalTime )
    timeout = setTimeout ->
      currentTime = currentTime + intervalStepEvery
      fireAction(intervalStep)
    , intervalStepEvery
  else
    # $("table td").addClass("stoped")
    $("table td").attr("class","")
    setTimeout ->
      activateField( random() )
    , showTime


$ ->
  i = 3
  a = -3
  console.log "test", --i, --a
  
  fireAction()
  
  # colorInterval( 100 )
  # 
  # setTimeout ->
  #   clearInterval interval
  #   colorInterval( 200 )
  #   setTimeout ->
  #     clearInterval interval
  #     colorInterval( 300 )
  #     setTimeout ->
  #       clearInterval interval
  #       $("table td").addClass("stoped")
  #       setTimeout ->
  #         activateField( random() )
  #       , 1500
  #     , 3000
  #   , 3000
  # , 3000
  
  
  
  # setTimeout ->
  #   clearInterval interval
  #   setTimeout ->
  #     activateField( random() )
  #   , 1500
  # , 3000
  
  
  # setTimeout ->
  #   clearInterval interval
  # , 5000
  
