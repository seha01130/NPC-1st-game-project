-----------------------------------------------------------------------------------------
--
-- farming_setting.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

--flag setting만 껐다 킴 => false / 메인화면, 다시시작 true
local flag = false

function scene:create( event )
	local sceneGroup = self.view
	
	--설정창 배경
 	local minigameOption = display.newImage("image/farmingImages/미니게임-옵션창.png")
 	minigameOption.x, minigameOption.y = display.contentWidth/2, display.contentHeight/2

 	--엑스창
 	local out = display.newImage("image/farmingImages/닫기.png")
 	out.x, out.y = display.contentWidth*0.694, display.contentHeight*0.338

 	--다시하기
 	local replay = display.newImage("image/farmingImages/다시하기.png")
 	replay.x, replay.y = display.contentWidth*0.405, display.contentHeight*0.496

 	--다른미니게임선택
 	local anotherMiniGames = display.newImage("image/farmingImages/다른미니게임선택.png")
 	anotherMiniGames.x, anotherMiniGames.y = display.contentWidth*0.573, display.contentHeight*0.508

 	sceneGroup:insert(minigameOption)
 	sceneGroup:insert(out)
 	sceneGroup:insert(replay)
 	sceneGroup:insert(anotherMiniGames)

 	------event

 	local timerAttack = composer.getVariable("timeAttack")

 	function out:tap( event )
 		timer.resume(timerAttack)
 		tiger:addEventListener("tap", tapTiger)
 		local cropGroup_setting = composer.getVariable("cropGroup")
 		cropGroup_setting.isVisible = true

 		composer.hideOverlay('farming_setting')
 	end
 	out:addEventListener("tap", out)

 	function replay:tap( event )
 		--timer.resume(timerAttack)
 		composer.hideOverlay('farming_setting')

 		--timerAttack = '0' 이걸 써줘야 
 		--WARNING: timer.resume( timerId ) cannot resume a timerId that is already expired.
 		--이 오류가 안남
 		timerAttack = '0'

 		--timer.cancel(timerAttack)
 		--local fileName = composer.getVariable("fileName") --preview
 		--composer.removeScene(fileName)
		composer.removeScene('farming_preview')
 		--composer.removeScene('farming_game')
 		flag = true
 		composer.setVariable("timerFlag", true)
 		--timer.resume(timerAttack)
 		composer.gotoScene('farming_preview')
 		--리플레이 선택하면 다시 farming_game.lua로 이동해서 다시 플레이 가능
 	end
 	replay:addEventListener("tap", replay)

 	function anotherMiniGames:tap( event )

         composer.hideOverlay('farming_setting')
         timerAttack = '0'
         composer.removeScene('farming_preview')
         flag = true
         composer.setVariable("timeFlag", true)
         composer.gotoScene('minigame_choice')

     end
     anotherMiniGames:addEventListener("tap",anotherMiniGames)

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

 		--local BGM = composer.getVariable("backgroundMusic")
 		--audio.play( BGM, { channel=1, loops=-1, fadein=1000 } )

		if (flag == true) then
			local fileName = composer.getVariable("fileName")
			composer.removeScene(fileName)
			composer.removeScene('farming_ending')
			--audio.stop(1)
			flag = false
		end
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