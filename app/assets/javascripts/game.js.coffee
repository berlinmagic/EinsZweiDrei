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
actionz           = ["question", "blink", "stop", "answer", "over"]

selectTime        = 1000 * 12
intervalTime      = 120
intervalStep      = 20
intervalStepEvery = 1000
showTime          = 1000 * 3
stepType          = "none"
rightAnswer       = random()
blinkType         = "change"

gameOn            = false
currentTime       = 0
currentAction     = "question"
currentQuestion   = {text: "Eins, Zwei oder Drei", answer1: "Eins", answer2: "Zwei", answer3: "Drei", result: random() }
gameQuestions     = [].push currentQuestion
currentIndex      = 0
interval          = null
timeout           = null
bgColor           = 0



getColor = (clr) ->
  if clr < 0
    2
  else
    if clr > 2 then 0 else clr

changeColors = ->
  if blinkType == "highlight"
    bgColor = getColor( bgColor + 1 )
    $("#blink_table td").attr("class", "")
    $("#field-#{ getColor( bgColor ) + 1 }").addClass("active")
    $("#field-#{ getColor( bgColor + 1 ) + 1 }").addClass("highlight")
  else
    bgColor = getColor( bgColor - 1 )
    $("table.fullpage").find("td").each ->
      $(@).attr( "class", "#{colorz[bgColor]}#{stylez[random()-1]}" )
      bgColor = getColor( bgColor + 1 )
  


activateField = (field) ->
  # $("#field-#{field}").removeClass("stoped")
  $("table.fullpage").find("td").each ->
    console?.log? "Field: #{ $(@).attr("id") } == #{field} ?"
    unless $(@).attr("id") == "field-#{ field }"
      $(@).attr("class", "stoped")
    else
      if blinkType == "highlight"
        $(@).attr("class", "right")


colorInterval = ( timer ) ->
  interval = setInterval ->
    changeColors()
  , timer


showAnswer = ->
  clearInterval interval  if interval
  clearTimeout timeout    if timeout
  currentAction = "stop"
  $("table td").attr("class","")
  activateField( rightAnswer )
  setTimeout ->
    currentAction = "answer"
    # showTable("answer")
  , showTime


stopBlink = ->
  clearInterval interval  if interval
  clearTimeout timeout    if timeout
  currentAction = "stop"
  $("table td").attr("class","")
  setTimeout ->
    showAnswer()
  , showTime


doBlink = ( upstep = 0 ) ->
  intervalTime = upstep + intervalTime
  currentAction = "blink"
  showTable("blink")
  clearInterval interval  if interval
  clearTimeout timeout    if timeout
  if currentTime < selectTime
    colorInterval( intervalTime )
    timeout = setTimeout ->
      currentTime = currentTime + intervalStepEvery
      if stepType == "faster"
        doBlink(intervalStep * -1)
      else if stepType == "slower"
        doBlink(intervalStep)
      else
        doBlink()
    , intervalStepEvery
  else
    stopBlink()


answerText = (nmbr) ->
  txt = "<small>#{nmbr}:</small> #{currentQuestion["answer#{nmbr}"]}"
  if currentQuestion.result == nmbr
    txt = "<strong>#{txt}</strong>"
  txt


fillQuestion = ( question ) ->
  $("#q_question").html( "<h3>Frage #{currentIndex + 1}:</h3><h1>#{ currentQuestion.text }</h1>" )
  $("#q_answer1").html( "<small>1:</small> #{currentQuestion.answer1}" )
  $("#q_answer2").html( "<small>2:</small> #{currentQuestion.answer2}" )
  $("#q_answer3").html( "<small>3:</small> #{currentQuestion.answer3}" )
  $("#b_question").text( currentQuestion.text )
  
  $("#field-1 span.answer").text( currentQuestion.answer1 )
  $("#field-2 span.answer").text( currentQuestion.answer2 )
  $("#field-3 span.answer").text( currentQuestion.answer3 )
  
  
  $("#a_question").text( currentQuestion.text )
  $("#a_answer1").html( answerText(1) )
  $("#a_answer2").html( answerText(2) )
  $("#a_answer3").html( answerText(3) )


showTable = (table) ->
  $("table").each ->
    $(@).addClass("hidden")
  $("##{ table }_table").removeClass("hidden")


startGame = ->
  gameOn = true
  if gameQuestions.length > 0 && gameQuestions[currentIndex]
    currentQuestion = gameQuestions[currentIndex]
    rightAnswer     = currentQuestion.result
    fillQuestion( currentQuestion )
    showTable("question")
  else
    gameOn        = false
    currentTime  = 0
    currentIndex = 0
    showTable("over")

nextQuestion = ->
  currentIndex += 1
  currentAction = "question"
  currentTime   = 0
  startGame()

stopGame = ->
  window.location = "/"

stepFor = ->
  if currentAction == "question"
    doBlink()
  else if currentAction == "blink"
    stopBlink()
  else if currentAction == "stop"
    showAnswer()
  else if currentAction == "answer"
    nextQuestion()

stepBack = ->
  if currentIndex == 0 && currentAction == "question"
    stopGame()
  else if currentAction == "blink"
    currentAction = "question"
    


$ ->
  
  data = $("#settings").data()
  
  console?.log? data
  
  selectTime        = parseInt data.selecttime
  intervalTime      = parseInt data.intervaltime
  intervalStep      = parseInt data.intervalstep
  intervalStepEvery = parseInt data.intervalstepevery
  showTime          = parseInt data.showtime
  stepType          = data.steptype
  blinkType         = data.blinktype
  gameQuestions     = data.questions
  
  console?.log? gameQuestions
  
  
  # => setTimeout ->
  # =>   startGame()
  # => , 2000
  
  
  # catch keypress
  $(document).on 'keyup', (e) ->
    key = e.keyCode
    # Stop .. key: Escape
    if key == 27
      console?.log? "pressed Stop", key
      stopGame()
    # Forward .. key: space, right, down, page-down, num-6, num-2, enter
    else if [32, 39, 40, 34, 102, 98, 13].indexOf( key ) != -1
      console?.log? "pressed forward", key
      if gameOn
        stepFor()
      else
        startGame()
    # Back .. key: backspace, left, up, page-up, num-4, num-8
    else if [8, 37, 38, 33, 100, 104].indexOf( key ) != -1
      console?.log? "pressed backward", key
      stepBack()
    false
  
  # catch mobile action
  $(document).on 'touchstart, click', (e) ->
    console?.log? "mobile forward", key
    if gameOn
      stepFor()
    else
      startGame()
  
  
  
  
