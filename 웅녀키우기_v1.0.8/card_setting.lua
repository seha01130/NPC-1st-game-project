-----------------------------------------------------------------------------------------
--
-- setting.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newImage("image/card_game/옵션창.png")
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local replay = display.newImage("image/card_game/다시하기.png", 263,272)
	replay.x, replay.y = display.contentWidth*0.405, display.contentHeight*0.496

	local otherBtn = display.newImage("image/card_game/다른미니게임선택.png", 293,297)
	otherBtn.x, otherBtn.y = display.contentWidth*0.573, display.contentHeight*0.508

	local closeBtn = display.newImage("image/card_game/닫기.png", 68,69)
	closeBtn.x, closeBtn.y = display.contentWidth*0.694, display.contentHeight*0.338

	--불러오기
	local card = composer.getVariable("card")
	local tapCard = composer.getVariable("tapCard")
	local BackCard = composer.getVariable("BackCard")

	--닫기 버튼
	function closeBtn:tap( event )
		local totalTime = composer.getVariable("totalTimer")
		timer.resume(totalTime)
		composer.hideOverlay('card_setting')

		for i = 1, 24 do
			card[i]:addEventListener("tap",tapCard)
		end
		for i = 25, 48 do
			card[i]:addEventListener("tap",BackCard)
		end
	end
	closeBtn:addEventListener("tap", closeBtn)

	--다시하기 버튼
	function replay:tap( event )
		composer.hideOverlay(card_setting)
		composer.gotoScene('card_start')
	end
	replay:addEventListener("tap",replay)

	--다른 게임 선택
	function other (event)
		composer.hideOverlay(card_setting)
		composer.gotoScene('minigame_choice')
	end
	otherBtn:addEventListener("tap",other)

	sceneGroup:insert(background)
	sceneGroup:insert(replay)
	sceneGroup:insert(otherBtn)
	sceneGroup:insert(closeBtn)
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