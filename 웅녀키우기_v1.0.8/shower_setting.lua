-----------------------------------------------------------------------------------------
--
-- setting.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local currentSound

function scene:create( event )
	local sceneGroup = self.view
	physics.start()

	local settingBackground = display.newImage("image/shower_game/미니게임-옵션창.png", display.contentWidth*0.5, display.contentHeight*0.5)

	local anotherGame = display.newImage("image/shower_game/다른미니게임선택.png", display.contentWidth*0.57, display.contentHeight*0.51)

	local replay = display.newImage("image/shower_game/다시하기.png", display.contentWidth*0.4, display.contentHeight*0.5)

    local close = display.newImage("image/shower_game/닫기.png", display.contentWidth*0.69, display.contentHeight*0.35)


	local waterFlag = composer.getVariable("waterFlag")
	local soap = composer.getVariable("soap")
	local water = composer.getVariable("water")
	local fan = composer.getVariable("fan")
	
	local buttonSoap = composer.getVariable("buttonSoap")
	local buttonWater = composer.getVariable("buttonWater")
	local buttonFan = composer.getVariable("buttonFan")

	local timeAttack = composer.getVariable("timeAttack")
	local timeAttackBubbleAlpha = composer.getVariable("timeAttackBubbleAlpha")
	local timeAttackWaterAlpha = composer.getVariable("timeAttackWaterAlpha")
	local timeAttackWaterDelete = composer.getVariable("timeAttackWaterDelete")

	local bear = composer.getVariable("bear")
	local bearBubble = composer.getVariable("bearBubble")
	local bearWater = composer.getVariable("bearWater")
	local bearFinal = composer.getVariable("bearFinal")
	
	local timeAttackSoap = composer.getVariable("timeAttackSoap")
	local timeAttackWater = composer.getVariable("timeAttackWater")
	local timeAttackFan = composer.getVariable("timeAttackFan")

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
	local function buttonVisible (event)
		buttonSoap.isVisible = true
		buttonWater.isVisible = true
		buttonFan.isVisible = true
	end

	local function bearVisible (event)
		bear.isVisible = true
		bearBubble.isVisible = true
		bearWater.isVisible = true
		bearFinal.isVisible = true
	end

    function close:tap( event )
		local game_mode = composer.getVariable("game_mode")
		if (game_mode == 0) then
			soap:addEventListener("touch", drag)
			water:addEventListener("touch", drag)
			fan:addEventListener("touch", drag)
			timer.resume(timeAttackSoap)
		elseif (game_mode == 1) then
			if (waterFlag == 0) then 
				water:addEventListener("touch", drag)
			end
			fan:addEventListener("touch", drag)
			timer.resume(timeAttackWater)
		elseif (game_mode == 2) then
			fan:addEventListener("touch", drag)
			timer.resume(timeAttackFan)
		end
		buttonVisible()
        bearVisible()

        timer.resume(timeAttack)
        composer.hideOverlay('shower_setting')
    end
    close:addEventListener("tap", close)

	function replay:tap( event )
		local game_mode = composer.getVariable("game_mode")
		composer.removeScene('shower_game')
		timeAttack = '0'
		timer.cancel(timeAttack)
		
		physics.stop()
		buttonVisible()
        composer.hideOverlay('shower_setting')
		timer.resume(timeAttack)
		audio.stop()

		composer.gotoScene("shower_preview")
    end
    replay:addEventListener("tap", replay)

	function anotherGame:tap ( event )
		audio.stop()
		composer.gotoScene("minigame_choice")
	end
	anotherGame:addEventListener("tap", anotherGame)

	sceneGroup:insert(settingBackground)
    sceneGroup:insert(close)
	sceneGroup:insert(replay)
	sceneGroup:insert(anotherGame)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then
	elseif phase == "did" then

	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then

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