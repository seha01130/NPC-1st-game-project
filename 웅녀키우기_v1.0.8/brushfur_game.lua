-----------------------------------------------------------------------------------------
--
-- minigame_brushfur.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local timeAttack
local timerFlag = false

function scene:create( event )
	local sceneGroup = self.view
	--오디오 플레이
	if ( soundVolume == 1 ) then
		audio.play(soundTable["brushfur_BGM"], {loops=-1})
	end
	--이미지 삽입
	local background = display.newImageRect("image/brushfur_game/배경.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	local timerBg = display.newImage("image/brushfur_game/미니게임 타이머.png")
	timerBg.x, timerBg.y = 1220 + timerBg.contentWidth * 0.5, 823 + timerBg.contentHeight / 2
	local scoreBg = display.newImage("image/brushfur_game/미니게임 스코어.png")
	scoreBg.x, scoreBg.y = 1450 + scoreBg.contentWidth / 2, 864 + scoreBg.contentHeight / 2
	local setting = display.newImage("image/brushfur_game/미니게임 일시정지.png")
	setting.x, setting.y = 1800 + setting.contentWidth / 2, 19 + setting.contentHeight / 2
	local startCountGroup = display.newGroup()
	local startCountImage = {}

	for i = 1, 3 do
		startCountImage[i] = display.newImage(startCountGroup, "image/brushfur_game/카운트_"..i..".png")
		startCountImage[i].x, startCountImage[i].y = display.contentWidth / 2, display.contentHeight / 2

		startCountImage[i].alpha = 0
	end
	startCountImage[3].alpha = 1
	--텍스트 삽입
	local textOption = {
 		text = "",
 		font = "font/Maplestory Bold.ttf" 
	}
	--점수 삽입
	local score = display.newText( textOption )
	score.text = "0"
	score.x, score.y = scoreBg.x, scoreBg.y
	score.size = 85
	score:setFillColor(0.33, 0.19, 0.2)

	--털 변수
	local fur

	--브러쉬 스프라이트
	local combSheet = graphics.newImageSheet("image/brushfur_game/빗묶음.png",{width = 2452 / 7, height = 223, numFrames = 7})
	local sequenceData = {
		name = "brushing",
		sheet = combSheet,
		time = 300,
		start = 1,
		count = 7,
		loopCount = 1,
		loopDirection = "forward"
	}
	local brushs = display.newSprite(combSheet, sequenceData)

	--타이머
	local time = display.newText( textOption )
	time.text = "10"
	time.x, time.y = timerBg.x, scoreBg.y + 5
	time.size = 85
	time:setFillColor(0.33, 0.19, 0.2)

	-----엔딩
	local function counter( event )
	 	time.text = time.text - 1
	 	-- 엔딩 창
	 	if( time.text == '0' ) then
	 		setting:removeEventListener("tap", setting)
	 		timer.pause(fur)
	 		timer.cancel(fur)
	 		composer.setVariable("score", score.text)
	 		composer.gotoScene('brushfur_ending')
	 	end
	end

	timeAttack = timer.performWithDelay(1000, counter, 10)

	--털 이미지 클릭
	local function touchFur( event )
		if( event.phase == "began" ) then
			event.target.text = event.target.text + 1
			if(time.text ~= '0')then
				if ( soundVolume == 1 ) then
					audio.play(soundTable["brushfur_soundEffect"])
				end
				if(event.target.text == 3) then
					local x = event.x
					local y = event.y
					local brushing = display.newSprite(combSheet, sequenceData)
					brushing.x, brushing.y = x, y
					brushing:play()
					sceneGroup:insert(brushing)
					event.target.alpha = 0
					score.text = score.text + 100
				end
			end
		end
	end

	--털 이미지 생성
	local idx = 1
	-- brushFur 지역변수
	local furGroup = display.newGroup()
	local twistFur = {}
	local function makeFur( event )
		twistFur[idx] = display.newImage(furGroup, "image/brushfur_game/털뭉치.png")
		twistFur[idx].text = 0
		twistFur[idx].x, twistFur[idx].y = math.random(100, 700)*2, math.random(70, 345)*2
		twistFur[idx]:addEventListener("touch", touchFur)
		sceneGroup:insert(twistFur[idx])
		idx = idx + 1
	end
	fur = timer.performWithDelay(math.random(400, 600), makeFur, 30)

	--설정 창
	local settingReduceSize = setting.contentWidth * 0.9
	local settingImageSize = setting.contentWidth

	function setting:tap( event )
		timer.pause(timeAttack)
 		timer.pause(fur)
 		if twistFur ~= nil then
			for i = 1, #twistFur do
				print(i)
				twistFur[i]:removeEventListener("touch", touchFur)
	 		end
	 	end
	 	composer.setVariable("twistFur", twistFur)
 		composer.setVariable("touchFur", touchFur)
 		composer.setVariable("fileName", "brushfur_game")
 		composer.setVariable("timeAttack", timeAttack)
 		composer.setVariable("fur", fur)
		composer.showOverlay('brushfur_setting')
	end

 	--123 시작 카운트
 	local function stopEvent()
		timer.pause(fur)
		timer.pause(timeAttack)
 	end
 	local function startEvent()
		timer.resume(fur)
		timer.resume(timeAttack)
		setting:addEventListener("tap", setting) 		
 	end

 	local function startCount(n)
 		for i = 1, 3 do
 			startCountImage[i].alpha = 0
 			if (i == n) then
 				startCountImage[i].alpha = 1
 			end
 		end
 	end

 	local sTime = 2
 	local explainText = display.newImage("image/brushfur_game/설명.png")
 	explainText.x, explainText.y = display.contentCenterX, display.contentCenterY + 130
 	explainText.alpha = 1

 	local function sCounter( event )
 		print(sTime)
 		if (sTime == 0) then
 			explainText.alpha = 0
 			startCountImage[1].alpha = 0
 			startEvent()
 			sTime = 0
 		else
 			explainText.alpha = 1
 			startCount(sTime)
 			sTime = sTime - 1
 		end
 	end

 	stopEvent()
 	local startTime = timer.performWithDelay(1000, sCounter, 3)

 	--그룹
	sceneGroup:insert(brushs)
 	sceneGroup:insert(background)
 	sceneGroup:insert(timerBg)
 	sceneGroup:insert(scoreBg)
 	sceneGroup:insert(setting)
 	sceneGroup:insert(time)
 	sceneGroup:insert(score)
 	sceneGroup:insert(explainText)
 	sceneGroup:insert(startCountGroup)
 	sceneGroup:insert(furGroup)
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
		-- composer.removeScene('minigame_brushfur')
		timerFlag = composer.getVariable("timerFlag")
		print(timerFlag)
		if timerFlag == false then
			timer.cancel( timeAttack )
		end
		composer.removeScene('brushfur_game')
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