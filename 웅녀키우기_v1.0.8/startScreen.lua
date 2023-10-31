-----------------------------------------------------------------------------------------
--
-- startScreen.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	print("Here is startScreen")
	local sceneGroup = self.view

	local minigameChoiceBGM = audio.loadSound("sound/minigameChoiceBGM.mp3")
	audio.play(minigameChoiceBGM, {loops = -1})

	local background = display.newImageRect("image/startImages/메인일러 최종.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local startBar = display.newImage("image/startImages/시작버튼.png")
	startBar:scale(0.33, 0.33)
	startBar.x, startBar.y = display.contentWidth/2, display.contentHeight*0.87

	function tapstartBar( event )
		local startClickBGM = audio.loadSound("sound/StartSound.wav")
		audio.play(startClickBGM, {onComplete=bombExplode})
		timer.performWithDelay(1000, function()
			audio.pause(minigameChoiceBGM)
			composer.gotoScene("mainScreen")
		end)
	end
	startBar:addEventListener("tap", tapstartBar)

	--레이어 정리
	
	sceneGroup:insert( background )
	sceneGroup:insert( startBar )
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
		composer.removeScene('startScreen')
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)''
		
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