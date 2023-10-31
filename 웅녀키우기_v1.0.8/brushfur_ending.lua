-----------------------------------------------------------------------------------------
--
-- ending.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

------------------------------------------------------------
local json = require "json"	
------------------------------------------------------------

function scene:create( event )
	local sceneGroup = self.view
	
	--jsonParse
	local Data = jsonParse("json/status.json")

	local result = display.newImage("image/brushfur_game/결과창.png")
	result.x, result.y = display.contentWidth/2, display.contentHeight/2
 	
 	--점수 냥 변환
 	local score = composer.getVariable("score")
 	score = tonumber(score)
	local money
	
	if ( score == 0 ) then
		money = 0
	elseif ( score <= 100 ) then
		money = 50
	elseif ( score <= 300 ) then
		money = 100
	elseif ( score <= 500 ) then
		money = 150
	elseif ( score <= 700 ) then
		money = 200
	elseif( score <= 1000 ) then
		money = 250
	elseif ( score <= 1200 ) then
		money = 300
	elseif( score <= 1400 ) then
		money = 350
	elseif( score <= 1600 ) then
		money = 400
	elseif ( score <= 1800 ) then
		money = 450
	else
		money = 500
	end

	--텍스트 삽입
	local textOption = {
 		text = "",
 		font = "font/Maplestory Bold.ttf",
	}
	local scoreText = display.newText( textOption )
	scoreText.text = tostring(score)
	scoreText.size = 113
	scoreText:setFillColor(0.33, 0.19, 0.2)
	scoreText.x, scoreText.y = 600, 615
	local moneyText = display.newText( textOption )
	moneyText.text = tostring(money)
	moneyText.size = 113
	moneyText:setFillColor(0.33, 0.19, 0.2)
	moneyText.x, moneyText.y = 1225, 615

	--jsonSave
	Data.nyang_json = Data.nyang_json + money
	jsonSave("json/status.json", Data)
	
	--다시하기 메인으로 버튼
 	local retryButton = display.newImage("image/brushfur_game/결과_다시하기.png")
 	retryButton.x, retryButton.y = 1342 + retryButton.contentWidth / 2, 318 + retryButton.contentHeight / 2
 	local mainButton = display.newImage("image/brushfur_game/결과_메인으로.png")
 	mainButton.x, mainButton.y = 1479 + mainButton.contentWidth / 2, 318 + mainButton.contentHeight / 2
	
	local function goMain ( event )
		composer.gotoScene('mainScreen')
	end

	local function retry ( event )
		composer.gotoScene('brushfur_game')
	end
 	mainButton:addEventListener("tap", goMain)
 	retryButton:addEventListener("tap", retry)

 	--그룹
 	sceneGroup:insert(result)
 	sceneGroup:insert(retryButton)
 	sceneGroup:insert(mainButton)
 	sceneGroup:insert(scoreText)
 	sceneGroup:insert(moneyText)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.

	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		if ( soundVolume == 1 ) then
			audio.pause()
		end
		composer.removeScene('brushfur_ending')
	elseif phase == "did" then
		-- Called when the scene is now off screen

	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene