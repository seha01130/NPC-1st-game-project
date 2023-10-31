local composer = require( "composer" )
local scene = composer.newScene()
local game_mode = 0
local timeAttack
local timeAttackBubbleAlpha
local timeAttackWaterAlpha
local timeAttackWaterDelete
local water
function scene:create( event )
	local sceneGroup = self.view
	physics.start()
	
	game_mode = 0

	local textOption = {
		text = "",
		font = "font/Maplestory Bold.ttf",
	}
	
	local background = display.newImageRect("image/shower_game/shower_background.png", display.contentWidth, display.contentHeight )
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local bear = display.newImage("image/shower_game/bear1.png") 
	bearX, bearY = display.contentWidth * 0.492, display.contentHeight * 0.495
	bear.x, bear.y = bearX, bearY
	bear.name = "bear"
	local bear_outline = graphics.newOutline(5, "image/shower_game/bear1.png")

	if (game_mode == 0) then
		physics.addBody(bear, "dynamic", {outline = bear_outline})
	end
		local bearBubble = display.newImage("image/shower_game/bear2.png") 
	bearBubble.x, bearBubble.y = bearX, bearY
	bearBubble.name = "bear"
	local bearBubble_outline = graphics.newOutline(5, "image/shower_game/bear2.png")
	bearBubble.alpha = 0

	local bearWater = display.newImage("image/shower_game/bear3.png") 
	bearWater.x, bearWater.y = bearX, bearY
	bearWater.name = "bear"
	local bearWater_outline = graphics.newOutline(5, "image/shower_game/bear3.png")
	bearWater.alpha = 0

	local bearFinal = display.newImage("image/shower_game/bear4.png") 
	bearFinal.x, bearFinal.y = bearX, bearY
	bearFinal.name = "bear"
	local bearFinal_outline = graphics.newOutline(5, "image/shower_game/bear4.png")
	bearFinal.alpha = 0


	local ground = display.newImageRect("image/shower_game/gaugeUnit.png", display.contentWidth*0.3, display.contentHeight * 0.1)
	ground.x, ground.y =  display.contentWidth*0.25, display.contentHeight * 0.8425
	physics.addBody(ground, "static")
	ground.alpha = 0

	local ground2 = display.newImageRect("image/shower_game/gaugeUnit.png", display.contentWidth*0.5, display.contentHeight * 0.2)
	ground2.x, ground2.y =  display.contentWidth*0.7, display.contentHeight * 0.995
	physics.addBody(ground2, "static")
	ground2.alpha = 0

	local ground2 = display.newImageRect("image/shower_game/gaugeUnit.png", display.contentWidth*0.2, display.contentHeight * 0.5)
	ground2.x, ground2.y =  display.contentWidth*0.66, display.contentHeight * 0.99
	physics.addBody(ground2, "static")
	ground2.alpha = 0

	local ground3 = display.newImageRect("image/shower_game/gaugeUnit.png", display.contentWidth*0.1, display.contentHeight * 0.5)
	ground3.x, ground3.y =  display.contentWidth*0.15, display.contentHeight * 0.7
	physics.addBody(ground3, "static")
	ground3.alpha = 0

	local buttonSoap = display.newImage("image/shower_game/buttonSoap.png")
	soapX, soapY = display.contentWidth * 0.65, display.contentHeight *0.65
	buttonSoap.x, buttonSoap.y = soapX, soapY

	local buttonWater = display.newImage("image/shower_game/buttonWater.png")
	waterX, waterY = display.contentWidth * 0.78, display.contentHeight *0.65
	buttonWater.x, buttonWater.y = waterX, waterY
	
	local buttonFan = display.newImage("image/shower_game/buttonFan.png")
	fanX, fanY = display.contentWidth * 0.91, display.contentHeight *0.65
	buttonFan.x, buttonFan.y = fanX, fanY
	
	local buttonSoapM = display.newImage("image/shower_game/buttonSoapM.png")
	buttonSoapM.x, buttonSoapM.y = soapX, soapY
	buttonSoapM.alpha = 0

	local buttonWaterM = display.newImage("image/shower_game/buttonWaterM.png")
	buttonWaterM.x, buttonWaterM.y = waterX, waterY
	buttonWaterM.alpha = 0

	local buttonFanM = display.newImage("image/shower_game/buttonFanM.png")
	buttonFanM.x, buttonFanM.y = fanX, fanY
	buttonFanM.alpha = 0

	local soap = display.newImage("image/shower_game/selectSoap.png")
	soap.x, soap.y = soapX, soapY
	local soap_outline = graphics.newOutline(5, "image/shower_game/selectSoap.png")
	physics.addBody(soap, "kinematic", {outline = soap_outline, isSensor = true, density = 60, friction = 20})
	soap.alpha = 0

	water = display.newImage("image/shower_game/selectWater.png")
	water.x, water.y = waterX, waterY
	local water_outline = graphics.newOutline(100, "image/shower_game/selectWater.png")
	physics.addBody(water, "kinematic", { isSensor = true, density = 50 })
	water.alpha = 0

	local fan = display.newImage("image/shower_game/selectFan.png")
	fan.x, fan.y = fanX, fanY
	local fan_outline = graphics.newOutline(5, "image/shower_game/selectFan.png")
	physics.addBody(fan, "kinematic", {outline = fan_outline, isSensor = true, density = 100})
	fan.alpha = 0

	local gaugeBar = display.newImage("image/shower_game/gaugeBar.png")
	gaugeBar.x, gaugeBar.y = display.contentWidth * 0.05, display.contentHeight *0.5
	gaugeBar.alpha = 0
	local setting = display.newImageRect("image/shower_game/미니게임 일시정지.png", 100, 100)
	setting.x, setting.y = display.contentWidth * 0.948, display.contentHeight * 0.1

	local gaugeSoap = display.newImageRect("image/shower_game/buttonSoapM.png", 150, 150)
	gaugeSoap.x, gaugeSoap.y = display.contentWidth * 0.05, display.contentHeight * 0.155
	gaugeSoap.alpha = 0

	local gaugeFan = display.newImageRect("image/shower_game/buttonFanM.png", 150, 150)
	gaugeFan.x, gaugeFan.y = display.contentWidth * 0.05, display.contentHeight * 0.155
	gaugeFan.alpha = 0

	local gaugeUnit = {}
	for i = 1, 20 do
		gaugeUnit[i] = display.newImage("image/shower_game/gaugeUnit.png")
		gaugeUnit[i].x, gaugeUnit[i].y = display.contentWidth * 0.05, display.contentHeight * 0.79 - 30*i
		gaugeUnit[i].alpha = 0
	end
	
	local scoreBoard = display.newImage("image/shower_game/미니게임 스코어 ui.png")
	scoreBoard.x, scoreBoard.y = display.contentWidth * 0.85, display.contentHeight * 0.885

	local timeBoard = display.newImage("image/shower_game/미니게임 타이머 ui.png")
	timeBoard.x, timeBoard.y = display.contentWidth * 0.63, display.contentHeight * 0.87

	local alert = {}
	alert[1] = display.newText(textOption)
	alert[1].text = "비누 버튼을 눌러 비누칠을 해주세요"
	alert[1].x, alert[1].y = display.contentWidth/2, display.contentHeight*0.4

	alert[2] = display.newText(textOption)
	alert[2].text = "대야 버튼을 눌러 물로 헹궈주세요"
	alert[2].x, alert[2].y = display.contentWidth/2, display.contentHeight*0.4

	alert[3] = display.newText(textOption)
	alert[3].text = "부채 버튼을 눌러 부채칠을 해주세요"
	alert[3].x, alert[3].y = display.contentWidth/2, display.contentHeight*0.4
	
	for i = 1, 3 do
		alert[i].size = 70
		alert[i].alpha = 0
		alert[i]:setFillColor(0.3, 0.2, 0.1)
	end

	--사운드
	local bgm = audio.loadSound("sound/shower_game/adaytoremember.mp3")
	local backgroundMusic = audio.play(bgm)

	sceneGroup:insert(background)
	sceneGroup:insert(bear)
	sceneGroup:insert(bearFinal)
	sceneGroup:insert(bearWater)
	sceneGroup:insert(bearBubble)
	sceneGroup:insert(gaugeBar)
	sceneGroup:insert(scoreBoard)
	sceneGroup:insert(timeBoard)
	sceneGroup:insert(buttonSoap)
	sceneGroup:insert(buttonWater)
	sceneGroup:insert(buttonFan)
	sceneGroup:insert(buttonSoapM)
	sceneGroup:insert(buttonWaterM)
	sceneGroup:insert(buttonFanM)
	sceneGroup:insert(setting)
	sceneGroup:insert(soap)
	sceneGroup:insert(water)
	sceneGroup:insert(fan)
	sceneGroup:insert(gaugeSoap)
	sceneGroup:insert(gaugeFan)
	for i = 1, 20 do
		sceneGroup:insert(gaugeUnit[i])
	end

	local function btnSoap_alpha(event)
		if (buttonSoapM.alpha == 0) then
			timer.performWithDelay(100, function()
				buttonSoapM.alpha = buttonSoapM.alpha + 0.2
			end, 10)
		end
		if (buttonSoapM.alpha >= 1) then
			timer.performWithDelay(100, function()
				buttonSoapM.alpha = buttonSoapM.alpha - 0.2
			end, 10)
		end
	end
	local timeAttackSoap
	timeAttackSoap = timer.performWithDelay(1000, btnSoap_alpha, -1)

	local function btnWater_alpha(event)
		if (buttonWaterM.alpha == 0) then
			timer.performWithDelay(100, function()
				buttonWaterM.alpha = buttonWaterM.alpha + 0.2
			end, 10)
		end
		if (buttonWaterM.alpha >= 1) then
			timer.performWithDelay(100, function()
				buttonWaterM.alpha = buttonWaterM.alpha - 0.2
			end, 10)
		end
	end
	local timeAttackWater

	local function btnFan_alpha(event)
		if (buttonFanM.alpha == 0) then
			timer.performWithDelay(100, function()
				buttonFanM.alpha = buttonFanM.alpha + 0.2
			end, 10)
		end
		if (buttonFanM.alpha >= 1) then
			timer.performWithDelay(100, function()
				buttonFanM.alpha = buttonFanM.alpha - 0.2
			end, 10)
		end
	end
	local timeAttackFan
	
	local function btn_tap_soap (event)
		if (game_mode == 0) then
			soap.alpha = 1
			gaugeBar.alpha = 1
			gaugeSoap.alpha = 1
			timer.cancel(timeAttackSoap)
			buttonSoapM.alpha = 1

		elseif (game_mode == 1) then
			alert[2].alpha = 1
			timer.performWithDelay(1000, function()
				alert[2].alpha = 0
			end)
		elseif (game_mode == 2) then
			alert[3].alpha = 1
			timer.performWithDelay(1000, function()
				alert[3].alpha = 0
			end)
		end
	end
	buttonSoap:addEventListener("tap", btn_tap_soap)

	local function btn_tap_water (event)
		if (game_mode == 1) then
			water.alpha = 1
			timer.cancel(timeAttackWater)
			buttonWaterM.alpha = 1
		elseif (game_mode == 0) then
			alert[1].alpha = 1
			timer.performWithDelay(1000, function()
				alert[1].alpha = 0
			end)
		elseif (game_mode == 2) then
			alert[3].alpha = 1
			timer.performWithDelay(1000, function()
				alert[3].alpha = 0
			end)
		end
	end
	buttonWater:addEventListener("tap", btn_tap_water)

	local function btn_tap_fan (event)
		if (game_mode == 2)	then
			fan.alpha = 1
			gaugeBar.alpha = 1
			gaugeFan.alpha = 1
			timer.cancel(timeAttackFan)
			buttonFanM.alpha = 1
		elseif (game_mode == 0) then
			alert[1].alpha = 1
			timer.performWithDelay(1000, function()
				alert[1].alpha = 0
			end)
		elseif (game_mode == 1) then
			alert[2].alpha = 1
			timer.performWithDelay(1000, function()
				alert[2].alpha = 0
			end)
		end
	end
	buttonFan:addEventListener("tap", btn_tap_fan)

	local function drag( event )
		if( event.phase == "began" ) then
			display.getCurrentStage():setFocus( event.target )
			event.target.isFocus = true
		elseif( event.phase == "moved" ) then
			if ( event.target.isFocus ) then
				event.target.x = event.xStart + event.xDelta
				event.target.y = event.yStart + event.yDelta
			end
		elseif ( event.phase == "ended" or event.phase == "cancelled") then
			if ( event.target.isFocus ) then
				display.getCurrentStage():setFocus( nil )
				event.target.isFocus = false
			else
				display.getCurrentStage():setFocus( nil )
				event.target.isFocus = false
			end
		end
	end

	function addEvent (event)
		soap:addEventListener("touch", drag)
		water:addEventListener("touch", drag)
		fan:addEventListener("touch", drag)
	end
	addEvent()

	function removeEvent (event)
		soap:removeEventListener("touch", drag)
		water:removeEventListener("touch", drag)
		fan:removeEventListener("touch", drag)
	end
	
	local score = display.newText(textOption)
	score.text = 0
	score.x, score.y = display.contentWidth*0.85, display.contentHeight*0.89
	score.size = 100
	score:setFillColor(0.3, 0.2, 0.1)
	score.alpha = 0.8
	sceneGroup:insert(score)

	--타이머 변수
	local time = display.newText(textOption)
	time.text = 30
	time.x, time.y = display.contentWidth*0.63, display.contentHeight*0.89
	time.size = 100
	time:setFillColor(0.3, 0.2, 0.1)
	time.alpha = 0.8
	sceneGroup:insert(time)

	local function counter(event)
		time.text = time.text - 1
		if (time.text == '-1') then
			composer.setVariable("ending_score", tonumber(score.text))
			timer.performWithDelay(1, function()
				physics.stop()
			end)
			composer.gotoScene("shower_ending")
		end
	end
	timeAttack = timer.performWithDelay(1000, counter, 31)

	local function tap (event)
		timer.pause(timeAttack)

		composer.setVariable("timeAttack", timeAttack)
		composer.setVariable("soap", soap)
		composer.setVariable("water", water)
		composer.setVariable("fan", fan)
		composer.setVariable("buttonSoap", buttonSoap)
		composer.setVariable("buttonWater", buttonWater)
		composer.setVariable("buttonFan", buttonFan)
		composer.setVariable("game_mode", game_mode)
		
		composer.setVariable("bear", bear)
		bear.isVisible = false
		composer.setVariable("bearBubble", bearBubble)
		bearBubble.isVisible = false
		composer.setVariable("bearWater", bearWater)
		bearWater.isVisible = false
		composer.setVariable("bearFinal", bearFinal)
		bearFinal.isVisible = false
		
		buttonSoap.isVisible = false
		buttonWater.isVisible = false
		buttonFan.isVisible = false

		composer.setVariable("waterFlag", waterFlag)
		composer.setVariable("timeAttackBubbleAlpha", timeAttackBubbleAlpha)
		composer.setVariable("timeAttackWaterAlpha", timeAttackWaterAlpha)
		composer.setVariable("timeAttackWaterDelete", timeAttackWaterDelete)
		composer.setVariable("timeAttackSoap", timeAttackSoap)
		composer.setVariable("timeAttackWater", timeAttackWater)
		composer.setVariable("timeAttackFan", timeAttackFan)
		physics.pause()
		composer.showOverlay("shower_setting")
		if (game_mode == 0) then
			removeEvent()
		elseif (game_mode == 1 and waterFlag == 1) then
			water:removeEventListener("touch", drag)
			fan:removeEventListener("touch", drag)
		elseif (game_mode == 2) then

			fan:removeEventListener("touch", drag)
		end
	end
	setting:addEventListener("tap", tap)

	local count = 0
	local i = 1
	function bear_Soap (self, event)
		if(event.phase == "ended") then
			if (event.other.name == "bear") then
				count = count + 1
				if (count % 3 == 0) then
					score.text = score.text + 1
				end
				if (tonumber(score.text) >= 50) then
					bearBubble.alpha = bearBubble.alpha + 0.01
					bear.alpha = bear.alpha - 0.005
					if (tonumber(score.text) >= 80) then
						bear.alpha = bear.alpha - 0.1
					end
				end
				bearBubble.alpha = bearBubble.alpha + 0.005
				if (count % 15  == 0) then
					gaugeUnit[i].alpha = 1
					i = i + 1
				end
				if (tonumber(score.text) >= 100) then
					display.remove(event.target)
					game_mode = 1
					timeAttackWater = timer.performWithDelay(1000, btnWater_alpha, -1)
					buttonSoapM.alpha = 0
					timer.performWithDelay(300, function()
						for j = 1, 20 do
							gaugeUnit[j].alpha = 0
						end
						gaugeBar.alpha = 0
						i = 1
						gaugeSoap.alpha = 0
					end)
					
				end
			end	
		end
	end
	soap.collision = bear_Soap
	soap:addEventListener("collision")

	local waterFlag = 0
	function bear_Water (self, event)
		if(event.phase == "ended" and waterFlag == 0 and game_mode == 1) then
			if (event.other.name == "bear") then
				display.remove(event.target)
				local water2 = display.newImage("image/shower_game/selectWater.png")
				sceneGroup:insert(water2)
				water2.x, water2.y = display.contentWidth*0.35, display.contentHeight*0.2
				score.text = score.text + 100
				waterFlag = 1
				fan:removeEventListener("touch", drag)

				bearWater.alpha = 0.2
				timeAttackBubbleAlpha = timer.performWithDelay(5, function()
					bearBubble.alpha = bearBubble.alpha - 0.005

				end, 300)
				timeAttackWaterAlpha = timer.performWithDelay(5, function()
					bearWater.alpha = bearWater.alpha + 0.07
				end, 14)
				
				timeAttackWaterDelete = timer.performWithDelay(2000, function()
					display.remove(water2)
					game_mode = 2
					timeAttackFan = timer.performWithDelay(1000, btnFan_alpha, -1)
					fan:addEventListener("touch", drag)
					buttonWaterM.alpha = 0
				end)
			end
		end
	end
	water.collision = bear_Water
	water:addEventListener("collision")

	local countFan = 0
	function bear_Fan (self, event)
		if(event.phase == "ended" and game_mode == 2) then
			if (event.other.name == "bear") then
				countFan = countFan + 1
				if (countFan % 3 == 0) then
					score.text = score.text + 1
				end
				if (tonumber(score.text) >= 250) then
					bearFinal.alpha = bearFinal.alpha + 0.05
					bearWater.alpha = bearWater.alpha - 0.005
					if (tonumber(score.text) >= 280) then
						bearFinal.alpha = bearFinal.alpha + 0.1
						bearWater.alpha = bearWater.alpha - 0.2
					end
				end
				if(countFan % 15 == 0) then
					gaugeUnit[i].alpha = 1
					i = i + 1
				end
			end
			if (tonumber(score.text) >= 300) then
				display.remove(bearWater)
				game_mode = 3
				buttonFanM.alpha = 0
				timer.performWithDelay(2000, function()
					for j = 1, 20 do
						gaugeUnit[j]:removeSelf()
					end
					gaugeBar.alpha = 0
					physics.stop()
					timer.cancel(timeAttack)
					composer.setVariable("ending_score", tonumber(score.text))
					composer.gotoScene("shower_ending")
				end)
			end
		end
	end
	fan.collision = bear_Fan
	fan:addEventListener("collision")
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then
		game_mode = 0
	elseif phase == "did" then
	end	
	physics.start()
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		composer.removeScene('shower_game')
		game_mode = 0
	elseif phase == "did" then

	end

end

function scene:destroy( event )
	local sceneGroup = self.view
	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-----------------------------------------------------------------------------------------

return scene