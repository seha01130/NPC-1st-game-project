local composer = require( "composer" )
local scene = composer.newScene()

local explain

function scene:create( event )
	local sceneGroup = self.view

	local countGroup = display.newGroup()
	countNumber = {}

	for i = 1, 3 do
		countNumber[i] = display.newImage(countGroup,"image/card_game/"..i..".png")
		countNumber[i].x, countNumber[i].y = display.contentWidth/2, display.contentHeight/2
	end

	explain = display.newImage("image/card_game/카드뒤집기_스타트 문구.png")
	explain.x, explain.y = display.contentWidth/2, display.contentHeight*0.6
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
		local i = 3
        countNumber[3].alpha = 1
        countNumber[2].alpha = 0
        countNumber[1].alpha = 0
        local function countDown (event)
            if (i == 3) then
                countNumber[3].alpha = 0
                countNumber[2].alpha = 1
            elseif (i == 2) then
                countNumber[2].alpha = 0
                countNumber[1].alpha = 1
			else
				countNumber[1].alpha = 0
				explain.alpha = 0
            end
            i = i - 1
        end
        timer.performWithDelay(1000, countDown,3)

        timer.performWithDelay(3000, function()
            composer.gotoScene("card_game")
        end)

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

        composer.removeScene('card_start')
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
