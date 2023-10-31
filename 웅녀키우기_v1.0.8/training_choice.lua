-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	--jsonParse
	local Data = jsonParse("json/status.json")

	--퍼센테이지 출력
	print(IQNum,staminaNum,artNum,livingNum)
	print(Data.nyang_json)
	--수련 BGM
	if ( soundVolume == 1 ) then
		training_BGM = audio.loadSound("sound/trainingBGM.mp3")
		audio.play(training_BGM, {loops=-1})
	end
	--수련 배경이미지 넣기
	local bg = display.newImage("image/training/수련_배경.webp")
	bg.x, bg.y = display.contentWidth / 2, display.contentHeight / 2
	local trainingGroup = display.newGroup()
	local training = {}
	local width = 40

	--warning text
	local warning = display.newImage("image/training/냥이부족합니다.webp")
	warning.x, warning.y = display.contentCenterX, display.contentCenterY
	warning.alpha = 0

	local warning2= display.newImage("image/training/이미100%.webp")
	warning2.x, warning2.y = display.contentCenterX, display.contentCenterY
	warning2.alpha = 0

	--함수구현
	local warningCount = 0
	local function warningCounter ( event )
		warningCount = warningCount + 1
		print(warningCount)
		if ( warningCount == 1 ) then
			warning.alpha = 0
			warning2.alpha = 0
			warningCount = 0
		end
	end
	
	local sum = Data.IQ_json+Data.stamina_json+Data.art_json+Data.living_json

	local function goTraining ( event )
		--냥 감소
		if (Data.nyang_json >= 1000) then
			Data.nyang_json = Data.nyang_json - 1000
			print("돈", Data.nyang_json)
			--jsonSave
			jsonSave("json/status.json", Data)
			composer.setVariable("trainingContent", event.target.name)
			composer.gotoScene("training")
		elseif (sum >= 8) then
			warning2.alpha = 1
			timeAttack = timer.performWithDelay(1000, warningCounter, 1)
		else
			warning.alpha = 1
			timeAttack = timer.performWithDelay(1000, warningCounter, 1)
		end
	end	

	--수련 배경이미지 + 이벤트리스너
	for i = 1, 4 do
		training[i] = display.newImage("image/training/선택_"..i..".webp")
		training[i].x, training[i].y = width + training[i].contentWidth / 2, 236 + training[i].contentHeight / 2
		training[i].name = i
		trainingGroup:insert(training[i])
		training[i]:addEventListener("tap", goTraining)
		width = width + 58 + training[i].contentWidth
	end	

	--돌아가기 버튼
	local function goMain ( event )
		audio.pause()
		composer.gotoScene("mainScreen")
	end

	local backButton = display.newImage("image/training/수련_돌아가기.webp")
	backButton.x, backButton.y = 95 + backButton.contentWidth / 2, 59 + backButton.contentHeight / 2
	backButton:addEventListener("tap", goMain)
	
	--그룹
	sceneGroup:insert(bg)
	sceneGroup:insert(trainingGroup)
	sceneGroup:insert(backButton)
	sceneGroup:insert(warning)

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
		composer.removeScene('training_choice')
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