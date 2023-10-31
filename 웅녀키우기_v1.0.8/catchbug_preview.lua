-- -----------------------------------------------------------------------------------------
-- --
-- -- catchbug_preview.lua
-- --
-- -----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local previewTimeAttack

function scene:create( event )
	local sceneGroup = self.view
	
	print("catchbug_preview")

	if(soundVolume == 1) then
		audio.pause(mainScreenMusic)
	end


	-- 배경
	local previewbackground = display.newImageRect( "image/catchbug/background.png", display.contentWidth, display.contentHeight )
	previewbackground.x, previewbackground.y = display.contentWidth/2, display.contentHeight/2

	local leaf = display.newImage("image/catchbug/leaf.png",display.contentHeight,display.contentHeight)
	leaf.x, leaf.y = display.contentWidth/2, display.contentHeight/2
	

	local startCountGroup = display.newGroup()
	local startCountImage = {}
	for i = 1, 3 do
		startCountImage[i] = display.newImage(startCountGroup, "image/brushfur_game/카운트_"..i..".png")
		startCountImage[i].x, startCountImage[i].y = display.contentWidth / 2, display.contentHeight / 2
		startCountImage[i].alpha = 0
	end
	startCountImage[3].alpha = 1

 	local i = 3
	local function counter( event )
		if i == 3 then
			startCountImage[3].alpha = 0
			startCountImage[2].alpha = 1
		elseif i == 2 then
			startCountImage[2].alpha = 0
			startCountImage[1].alpha = 1
		else
			startCountImage[1].alpha = 0
		end
		i = i -1
 	end
 	timer.performWithDelay(1000,counter, 3)
 	timer.performWithDelay(3000, function()
 		composer.gotoScene('catchbug_game')
 	end)
	
	local explainText = display.newImage("image/catchbug/벌레잡기설명.png")
	explainText.x, explainText.y = display.contentCenterX, display.contentCenterY + 130
 	explainText.alpha = 1

 	sceneGroup:insert(previewbackground)
 	sceneGroup:insert(leaf)
 	sceneGroup:insert(startCountGroup)
 	sceneGroup:insert(explainText)

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
		composer.removeScene('catchbug_preview')

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