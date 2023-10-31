-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local timeAttack
local timeAttackFlag = false
function scene:create( event )
	local sceneGroup = self.view

	--사운드 출력
	if ( soundVolume == 1 ) then
		local minigameChoiceBGM = audio.loadSound("sound/minigameChoiceBGM.mp3")
		audio.play(minigameChoiceBGM, {loops = -1})
	end
	--클릭할때 딸깍 소리
	local startClickBGM = audio.loadSound("sound/clickSound.wav")

	--배경, 버튼
	local bg = display.newImage("image/minigame_choice/배경.png")
	bg.x, bg.y = display.contentCenterX, display.contentCenterY
	local back = display.newImage("image/minigame_choice/뒤로가기.png")
	back.x, back.y = 49 + back.contentWidth / 2, 36 + back.contentHeight / 2
	local minigameButtonGroup = display.newGroup()
	local minigameButton = {}
	local minigameHeight = 154
	for i = 1, 5 do
		minigameButton[i] = display.newImage("image/minigame_choice/버튼_"..i..".png")
		minigameButton[i].x, minigameButton[i].y = 27 + minigameButton[i].contentWidth / 2, minigameHeight + minigameButton[i].contentHeight / 2
		minigameButton[i].name = i
		minigameButtonGroup:insert(minigameButton[i])
		minigameHeight = minigameHeight + minigameButton[i].contentHeight - 20
	end
	local setting = display.newImage("image/minigame_choice/설정.png")
	setting.x, setting.y = 1784 + setting.contentWidth / 2, 28 + setting.contentHeight / 2
	
	local start = display.newImage("image/minigame_choice/시작.png")
	start.x, start.y = 1527 + start.contentWidth / 2, 800 + start.contentHeight / 2
	local next = display.newImage("image/minigame_choice/다음.png")
	next.x, next.y = 1398 + next.contentWidth / 2, 354 + next.contentHeight / 2
	
	--텍스트
	local titleTexts = {}
	titleTexts[1] = "수확하기"
	titleTexts[2] = "카드뒤집기"
	titleTexts[3] = "털빗기"
	titleTexts[4] = "웅녀씻기기"
	titleTexts[5] = "벌레잡기"
	local explainTexts = {}
	explainTexts[1] = "마늘과 쑥을 바구니에 담으세요!"
	explainTexts[2] = "카드를 뒤집어 짝을 찾아주세요!"
	explainTexts[3] = "엉킨 털을 클릭하여 털을 빗어주세요!"
	explainTexts[4] = "더러워진 웅녀를 쑥비누로 씻겨주세요!"
	explainTexts[5] = "쑥에서 튀어나오는 벌레들을 잡아주세요!"

	local textOption = {
 		text = "",
 		font = "font/Maplestory Bold.ttf",
	}
	local minigameTitle = display.newText(textOption)
	minigameTitle.text = titleTexts[1]
	minigameTitle.x, minigameTitle.y = display.contentCenterX, 925
	minigameTitle.size = 81
	minigameTitle:setFillColor(0.32, 0.19, 0.06)
	local explainText = display.newText(textOption)
	explainText.text = explainTexts[1]
	explainText.x, explainText.y = display.contentCenterX, 1005
	explainText.size = 47
	explainText:setFillColor(0)

	--돌아가는 메뉴
	local circle = display.newImage("image/minigame_choice/원.png")
	circle.x, circle.y = display.contentCenterX, 1460
	local bearGroup = display.newGroup()
	local bears = {}
	for i = 1, 5 do
		bears[i] = display.newImage("image/minigame_choice/곰_"..i..".png")
		bears[i].x, bears[i].y = display.contentCenterX, 125 + bears[i].contentHeight
		bears[i].anchorY = 1
		if (i ~= 1) then
			bears[i]:rotate(-90)
		end
		bearGroup:insert(bears[i])
	end
	local nowChoice = 1
	local function rotateBear ( event )
		audio.play(startClickBGM)
		--잠깐 이벤트 리스너 없애버렸다가 생기게 하기(1초)
		stopEvent()
		--곰돌이 나가고 곰돌이 드루와
		transition.to(bears[nowChoice], { rotation=270, time=500, delta=true })
		nowChoice = nowChoice + 1
		if (nowChoice > 5) then
			nowChoice = nowChoice - 5
		end
		print(nowChoice)
		transition.to(bears[nowChoice], { rotation=90, time=200, delta=true })
		transition.to(circle, { rotation=90, time=200, delta=true })
		---text변경--
		minigameTitle.text = titleTexts[nowChoice]
		explainText.text = explainTexts[nowChoice]
	end
	local function choiceBear ( event )
		--잠깐 이벤트 리스너 없애버렸다가 생기게 하기(1초)
		stopEvent()
		--기존 곰돌이 나가고 선택한 곰돌이 드루와
		if (event.target.name ~= nowChoice) then
			audio.play(startClickBGM)
			transition.to(bears[nowChoice], { rotation=270, time=500, delta=true })
			transition.to(bears[event.target.name], { rotation=90, time=200, delta=true })
			nowChoice = event.target.name
			transition.to(circle, { rotation=90, time=200, delta=true })
			---text변경--
			minigameTitle.text = titleTexts[nowChoice]
			explainText.text = explainTexts[nowChoice]
		end
	end

	--이벤트 추가
	next:addEventListener("tap", rotateBear)
	for i = 1, 5 do
		minigameButton[i]:addEventListener("tap", choiceBear)
	end
	local function goMain ( event )
		composer.gotoScene('mainScreen')
	end
	back:addEventListener("tap", goMain)

	local function goMinigame ( event )
		if nowChoice == 1 then
			composer.gotoScene('farming_preview')
		elseif nowChoice == 2 then
			composer.gotoScene('card_start')
		elseif nowChoice == 3 then
			composer.gotoScene('brushfur_game')
		elseif nowChoice == 4 then
			composer.gotoScene('shower_preview')
		else
			composer.gotoScene('catchbug_preview')
		end
	end

	start:addEventListener("tap", goMinigame)
	
	---------------------------------아직 추가 안함--------------------
	--설정 및 도움말
	function setting:tap( event )
		audio.play(startClickBGM)
 		composer.showOverlay('mainScreen_setting')
 		if soundVolume == 0 then --이거 써줘야 다시 설정 눌렀을때 다시 음악 재생되는거 방지
 			audio.setVolume(0)
		end
 	end
 	setting:addEventListener("tap", setting)
	------------------------------------------------------------------


	--stop start 이벤트리스너 (돌아갈 때 오류 없도록)
	local function startEvent ( event )
		next:addEventListener("tap", rotateBear)
		for i = 1, 5 do
			minigameButton[i]:addEventListener("tap", choiceBear)
		end
	end

	local count = 0
	local function counter ( event )
		count = count + 1
		if ( count == 1 ) then
			count = 0
			startEvent()
		end
	end

	function stopEvent ( event )
		next:removeEventListener("tap", rotateBear)
		for i = 1, 5 do
			minigameButton[i]:removeEventListener("tap", choiceBear)
		end	
		timeAttackFlag = true
		timeAttack = timer.performWithDelay(500, counter, 1)
	end
	--그룹
	sceneGroup:insert(bg)
	sceneGroup:insert(back)
	sceneGroup:insert(setting)
	--
	sceneGroup:insert(circle)
	sceneGroup:insert(bearGroup)
	sceneGroup:insert(minigameTitle)
	sceneGroup:insert(explainText)
	--
	sceneGroup:insert(next)
	sceneGroup:insert(minigameButtonGroup)
	sceneGroup:insert(start)
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
		if ( timeAttackFlag == true ) then
			timer.cancel(timeAttack)
		end
		if soundVolume == 1 then
			audio.pause()
		end
		composer.removeScene('minigame_choice')
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