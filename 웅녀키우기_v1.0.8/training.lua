-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local timeAttack

function scene:create( event )
	local sceneGroup = self.view

	local trainingSound_1 = audio.loadSound("sound/trainingSound_1.mp3")
	local trainingSound_2 = audio.loadSound("sound/trainingSound_2.mp3")
	local trainingSound_3 = audio.loadSound("sound/trainingSound_3.mp3")
	local trainingSound_4 = audio.loadSound("sound/trainingSound_4.mp3")

	local background = display.newImage("image/training/수련배경.webp")
	background.x, background.y = display.contentWidth / 2, display.contentHeight / 2
	local imageFlag = composer.getVariable("trainingContent")
	print(imageFlag)
	
	--제이슨 Data Parse
	local Data = jsonParse("json/status.json")	
	
	--성장도 증가
	if imageFlag == 1 then
		Data.art_json = Data.art_json + 1
	elseif imageFlag == 2 then
		Data.IQ_json = Data.IQ_json + 1
	elseif imageFlag == 3 then
		Data.living_json = Data.living_json + 1
	else
		Data.stamina_json = Data.stamina_json + 1
	end
	
	--jsonSave
	jsonSave("json/status.json", Data)

	--수련 사운드 넣기
	if ( soundVolume == 1 ) then
		if imageFlag == 1 then
			audio.play(trainingSound_1, {loops=-1})
		elseif imageFlag == 2 then
			audio.play(trainingSound_2, {loops=-1})
		elseif imageFlag == 3 then
			audio.play(trainingSound_3)
		else
			audio.play(trainingSound_4, {loops=-1})
		end
	end
	--수련 이미지 넣기
	local trainingSheet = graphics.newImageSheet("image/training/수련스프라이트_"..imageFlag..".webp", {width = 7212 / 4, height = 789, numFrames = 4})
	local sequenceData = {
		name = "trainingImage",
		sheet = trainingSheet,
		time = 1500,
		start = 1,
		count = 4,
		loopCount = 0,
		loopDirection = "forward"
	}
	local trainingImage = display.newSprite(trainingSheet, sequenceData)
	trainingImage.x, trainingImage.y = display.contentWidth / 2, 450
	trainingImage:play()

	--상태 바 이미지 넣기
	local gaugebar1 = display.newImage("image/training/수련_상태바_1.webp")
	gaugebar1.x, gaugebar1.y = 58 + gaugebar1.contentWidth / 2, 862 + gaugebar1.contentHeight / 2
	local gaugebar2 = display.newImage("image/training/수련_상태바_2.webp")
	gaugebar2.x, gaugebar2.y = gaugebar1.x, gaugebar1.y

	local gaugeGroup = display.newGroup()
	local gauge = {}
	local width = 171
	for i = 1, 23 do
		gauge[i] = display.newImage("image/training/수련_게이지바.webp")
		gauge[i].x, gauge[i].y = width + gauge[i].contentWidth / 2, 901 + gauge[i].contentHeight / 2
		gauge[i].alpha = 0
		gaugeGroup:insert(gauge[i])
		width = width + 40 + gauge[i].contentWidth / 2
	end

	--게이지 채우기, 수련 완료
	local finishCount = 0
	local function finishCounter ( event )
		finishCount = finishCount + 1
		print(finishCount)
		if ( finishCount == 2 ) then
			composer.gotoScene('training_choice')
		end
	end

	local count = 0
	local idx = 1
	local function counter ( event )
		count = count + 1
		gauge[idx].alpha = 1
		idx = idx + 1
		if ( count == 23 ) then
			--수련완료 이미지
			local finish = display.newImage("image/training/수련완료.webp")
			finish.x, finish.y = display.contentCenterX, display.contentCenterY - 50
			sceneGroup:insert(finish)
			timeAttack = timer.performWithDelay(1000, finishCounter, 2)
		end
	end
	
	--게이지 차게
	timeAttack = timer.performWithDelay(500, counter, 23)
	
	--정리
	sceneGroup:insert(background)
	sceneGroup:insert(trainingImage)
	sceneGroup:insert(gaugebar2)
	sceneGroup:insert(gaugeGroup)
	sceneGroup:insert(gaugebar1)
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
		if soundVolume == 1 then
			audio.pause()
		end
		timer.cancel( timeAttack )
		composer.removeScene('training')
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