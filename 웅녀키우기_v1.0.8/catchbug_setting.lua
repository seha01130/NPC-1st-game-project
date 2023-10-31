-----------------------------------------------------------------------------------------
--
-- setting.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local flag = false

function scene:create( event )
	local sceneGroup = self.view
	
	local pawSound = audio.loadSound("sound/catchbug_pawSoundEffect.wav")

 	local background = display.newImage("image/catchbug/미니게임-옵션창.png")
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2

 	local replay = display.newImage("image/catchbug/다시하기.png", 263,272)
 	replay.x, replay.y = display.contentWidth*0.405, display.contentHeight*0.496

 	local otherBtn = display.newImage("image/catchbug/다른미니게임선택.png", 293,297)
 	otherBtn.x, otherBtn.y = display.contentWidth*0.573, display.contentHeight*0.508

 	local closeBtn = display.newImage("image/catchbug/닫기.png", 68,69)
 	closeBtn.x, closeBtn.y = display.contentWidth*0.694, display.contentHeight*0.338

 	function closeBtn:tap( event )
 		audio.play(pawSound)

 		local timeAttack = composer.getVariable("timeAttack")
 		timer.resume(timeAttack)
 		local mainbackground = composer.getVariable("mainbackground")
 		local tapAndPaw = composer.getVariable("tapAndPaw")
 		mainbackground:addEventListener("tap",tapAndPaw)
 		composer.hideOverlay('catchbug_setting')
 	end
 	closeBtn:addEventListener("tap", closeBtn)

 	function replay:tap( event )
 		audio.play(pawSound)
 		composer.hideOverlay('catchbug_setting')
 		timeAttack = '0'
 		composer.removeScene('catchbug_preview')
 		flag = true
 		composer.setVariable("timeFlag", true)
 		composer.gotoScene('catchbug_preview')

 	end
 	replay:addEventListener("tap",replay)

 	--다른 미니게임선택
 	function otherBtn:tap( event )
 		
 		composer.hideOverlay('catchbug_setting')
 		timeAttack = '0'
 		composer.removeScene('catchbug_preview')
 		flag = true
 		composer.setVariable("timeFlag", true)
 		composer.gotoScene('minigame_choice')
 		
 	end
 	otherBtn:addEventListener("tap",otherBtn)


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