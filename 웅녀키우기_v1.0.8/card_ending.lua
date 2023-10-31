-----------------------------------------------------------------------------------------
--
-- card_ending.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )
	local sceneGroup = self.view

	local textOption = {
		text = "",
		font = "font/Maplestory Bold.ttf",
	}

	local score = composer.getVariable("score")
	local money
	
	local scoreText = display.newText(textOption)
	scoreText.text = (score)
	scoreText.x, scoreText.y = display.contentWidth*0.32, display.contentHeight*0.57
    scoreText.size = 150
    scoreText:setFillColor(0.33, 0.19, 0.2)
    scoreText.alpha = 1

	if (score == 0) then
		money = 0
	else
		money = score
	end

	local moneyText = display.newText(textOption)
	moneyText.text = (money)
	moneyText.x, moneyText.y = display.contentWidth*0.63, display.contentHeight*0.57
	moneyText.size = 150
	moneyText:setFillColor(0.33, 0.19, 0.2)

	local Data = jsonParse("json/status.json")
	Data.nyang_json = Data.nyang_json + money
	if(Data) then
		print(Data.IQ_json)
		print(Data.stamina_json)
		print(Data.art_json)
		print(Data.living_json)
		print(Data.nyang_json)
	end
	jsonSave("json/status.json", Data)

 	local final = display.newImage("image/card_game/미니게임 결과 ui - 카드뒤집기.png",display.contentWidth/2, display.contentHeight/2)

	local replay = display.newImage("image/card_game/다시하기 (1).png")
	replay.x, replay.y = 1342 + replay.contentWidth / 2, 318 + replay.contentHeight / 2
	local home = display.newImage("image/card_game/메인으로.png")
	home.x, home.y = 1479 + home.contentWidth / 2, 318 + home.contentHeight / 2

 	function replay:tap( event )
 		composer.gotoScene('card_start')
 	end
 	replay:addEventListener("tap", replay)

	 local function main ( event )
		composer.gotoScene('mainScreen')
	end
	home:addEventListener("tap", main)

	sceneGroup:insert(final)
	sceneGroup:insert(home)
	sceneGroup:insert(replay)

	sceneGroup:insert(moneyText)
	sceneGroup:insert(scoreText)
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
		composer.removeScene('card_ending')
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
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
