-----------------------------------------------------------------------------------------
--
-- mainScreen.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	print("Here is mainScreen")
	print("soundVolume : "..soundVolume)
	local sceneGroup = self.view

	--클릭할때 딸깍 소리
	local startClickBGM = audio.loadSound("sound/clickSound.wav")

	--데이터 파싱
	local Data = jsonParse("json/status.json")
	if(Data) then
		print(Data.IQ_json)
		print(Data.stamina_json)
		print(Data.art_json)
		print(Data.living_json)
		print(Data.nyang_json)
	end

	--지능 체력 예술 살림 숫자 전역변수 --json에서 로드
	IQNum = Data.IQ_json
	staminaNum = Data.stamina_json
	artNum = Data.art_json
	livingNum = Data.living_json

	--재화 냥 전역변수 --json에서 로드
	nyang = Data.nyang_json

	--성장도 전역변수
	growth = (IQNum+staminaNum+artNum+livingNum)*12.5


	--음악
	mainScreenMusic= audio.loadSound( "sound/MainSound.mp3")
	if soundVolume == 1 then
		audio.play(mainScreenMusic, {loops = -1})
		audio.setVolume(loudness * 0.1)
	end
	
	--배경화면
	local background = display.newImageRect("image/screenImages/배경.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	--엔딩 가는 함수
	function endingTap( event )
    	composer.gotoScene("ending1")
    end

	--웅녀 배치
    local woongGroup = display.newGroup()
    local woong = {}
    local woongX, woongY = display.contentWidth*0.35, display.contentHeight*0.65
    woong[1] = display.newImage("image/screenImages/메인웅녀 1.png")
    woong[2] = display.newImage("image/screenImages/메인웅녀 2.png")
    woong[3] = display.newImage("image/screenImages/메인웅녀 3.png")

    for i = 1, 3 do
        woong[i].x, woong[i].y = woongX, woongY
        woong[i]:scale(0.5, 0.5)
        woongGroup:insert(woong[i])
    end
    print(growth)
    if (growth < 50) then
        woong[1].alpha = 1
        woong[2].alpha = 0
        woong[3].alpha = 0
    elseif (growth >= 50 and growth < 100) then
        woong[1].alpha = 0
        woong[2].alpha = 1
        woong[3].alpha = 0
    elseif (growth >= 100) then
        woong[1].alpha = 0
        woong[2].alpha = 0
        woong[3].alpha = 1
        woong[3]:addEventListener("tap",endingTap)	--해당부분
    end
	

	--설정
	local setting = display.newImage("image/screenImages/설정.png")
	setting.x, setting.y = display.contentWidth*0.071, display.contentHeight*0.087

 	--수련하기 도움말
	local help = display.newImage("image/screenImages/도움말.png")
	help.x, help.y = display.contentWidth*0.07, display.contentHeight*0.244


	--성장도
	local growthBox = display.newImage("image/screenImages/성장도 ui.png")
	growthBox.x, growthBox.y = display.contentWidth*0.771, display.contentHeight*0.142
	
	local growthOptions = 
	{
	    text = growth,     
	    x = display.contentWidth*0.83,
	    y = display.contentHeight*0.147,
	    font = "font/Maplestory Bold.ttf",   
	    fontSize = 75
	}

 
	local growthText = display.newText( growthOptions )
	growthText:setFillColor(0.33, 0.19, 0.2)


	--냥
	local nyangBox = display.newImage("image/screenImages/재화 ui.png")
	nyangBox.x, nyangBox.y = display.contentWidth*0.638, display.contentHeight*0.279

	local nyangOptions = 
	{
	    text = nyang,     
	    x = display.contentWidth*0.655,
	    y = display.contentHeight*0.279,
	    font = "font/Maplestory Bold.ttf",   
	    fontSize = 32
	}
 
	local nyangText = display.newText( nyangOptions )
	nyangText:setFillColor(0.33, 0.19, 0.2)

	--지능 체력 예술 살림
	local IQ = display.newImage("image/screenImages/지능ui.png")
	IQ.x, IQ.y = display.contentWidth*0.855, display.contentHeight*0.274

	local stamina = display.newImage("image/screenImages/체력ui.png")
	stamina.x, stamina.y = IQ.x, display.contentHeight*0.377

	local art = display.newImage("image/screenImages/예술ui.png")
	art.x, art.y = IQ.x, display.contentHeight*0.468

	local living = display.newImage("image/screenImages/살림ui.png")
	living.x, living.y = IQ.x, display.contentHeight*0.575

	--지능 게이지바
	local IQBarGroup = display.newGroup()
 	local IQBar = {}
	for i = 1, IQNum do
		IQBar[i] = display.newImage("image/screenImages/게이지바.png")
		IQBar[i].x, IQBar[i].y = display.contentWidth*0.865 + (i-1)*display.contentWidth*0.011, display.contentHeight*0.279
		IQBarGroup:insert(IQBar[i])
	end
	-- 체력 게이지바
	local staminaBarGroup = display.newGroup()
 	local staminaBar = {}
	for i = 1, staminaNum do
		staminaBar[i] = display.newImage("image/screenImages/게이지바.png")
		staminaBar[i].x, staminaBar[i].y = display.contentWidth*0.865 + (i-1)*display.contentWidth*0.011, display.contentHeight*0.372
		staminaBarGroup:insert(staminaBar[i])
	end
	--예술 게이지바
	local artBarGroup = display.newGroup()
 	local artBar = {}
	for i = 1, artNum do
		artBar[i] = display.newImage("image/screenImages/게이지바.png")
		artBar[i].x, artBar[i].y = display.contentWidth*0.865 + (i-1)*display.contentWidth*0.011, display.contentHeight*0.467
		artBarGroup:insert(artBar[i])
	end
	--살림 게이지바
	local livingBarGroup = display.newGroup()
 	local livingBar = {}
	for i = 1, livingNum do
		livingBar[i] = display.newImage("image/screenImages/게이지바.png")
		livingBar[i].x, livingBar[i].y = display.contentWidth*0.865 + (i-1)*display.contentWidth*0.011, display.contentHeight*0.562
		livingBarGroup:insert(livingBar[i])
	end

	--수련하기
	local training = display.newImage("image/screenImages/수련하기.png")
	training.x, training.y = display.contentWidth*0.737, display.contentHeight*0.8

	--미니게임
	local miniGames = display.newImage("image/screenImages/미니게임.png")
	miniGames.x, miniGames.y = display.contentWidth*0.888, display.contentHeight*0.809

   ---------------------EventListener--------------------------




	--도움말버튼 뒷배경 탭이벤트 삭제를 위한 함수
 	function removeEvent (event)
		help:removeEventListener("tap", tapHelp)
		setting:removeEventListener("tap", setting)
		training:removeEventListener("tap", tapTraining)
		miniGames:removeEventListener("tap", tapMiniGames)
		for i = 1, 3 do
        	woong[i]:removeEventListener("tap", woongTap)
    	end
	end

	function setting:tap( event )
		removeEvent()
		audio.play(startClickBGM)
 		composer.showOverlay('mainScreen_setting')
 		if soundVolume == 0 then --이거 써줘야 다시 설정 눌렀을때 다시 음악 재생되는거 방지
 			audio.setVolume(0)
		end
 	end
 	--setting:addEventListener("tap", setting)

	--수련하기 도움말 tap
	function tapHelp( event )
		audio.play(startClickBGM)
		local help1 = display.newImage("image/screenImages/도움말1.png")
		help1.x, help1.y = display.contentWidth/2, display.contentHeight/2

		--뒤에 tapEvent들 클릭 안되게!!!!!!
		removeEvent()

		------미니게임 도움말 나타남---------
		function toTheNextHelp( event )
			audio.play(startClickBGM)
			help1.alpha = 0--수련하기 도움말 투명도 0

			local help2 = display.newImage("image/screenImages/도움말2.png")
			help2.x, help2.y = display.contentWidth/2, display.contentHeight/2

				------엔딩보는법 도움말 나타남---------
				function toTheNextHelp( event )
				audio.play(startClickBGM)
				help2.alpha = 0--미니게임 도움말 투명도 0

				local help3 = display.newImage("image/screenImages/도움말3.png")
				help3.x, help3.y = display.contentWidth/2, display.contentHeight/2
				

				--엑스버튼
				local out = display.newImage("image/screenImages/닫기.png")
				out.x, out.y = display.contentWidth*0.95, display.contentHeight*0.08

				---------도움말의 엑스 버튼 클릭----------------------------------------
				function tapOut( event )
					audio.play(startClickBGM)
					addEvent()  --다시 이벤트들 추가!!!
					display.remove(help1)
					display.remove(help2)
					display.remove(help3)
					display.remove(out)
				end
				out:addEventListener("tap", tapOut)
				-----------------------------------------------------------------------
			end
			help2:addEventListener("tap", toTheNextHelp)
			-------------------------------------------------------------------------
		end
		help1:addEventListener("tap", toTheNextHelp)
		-------------------------------------------------------------------------
	end
	--help:addEventListener("tap", tapHelp)

	--수련하기 tap event
	function tapTraining( event )
		audio.play(startClickBGM)
		composer.gotoScene("training_choice")
	end
	--training:addEventListener("tap", tapTraining)

	--미니게임 tap event
	function tapMiniGames( event )
		audio.play(startClickBGM)
		composer.gotoScene("minigame_choice")
	end
	--miniGames:addEventListener("tap", tapMiniGames)

	--웅녀 tap
	function woongTap (event)
        for i = 1, 3 do
            transition.scaleTo( woong[i], {xScale = 0.57, yScale = 0.57, time = 100})
        	transition.scaleTo( woong[i], {delay = 100, xScale = 0.5, yScale = 0.5, time = 200})
        end
    end

    -- for i = 1, 3 do
    --     woong[i]:addEventListener("tap", woongTap)
    -- end


	function addEvent (event)
		help:addEventListener("tap", tapHelp)
		setting:addEventListener("tap", setting)
		training:addEventListener("tap", tapTraining)
		miniGames:addEventListener("tap", tapMiniGames)
		for i = 1, 3 do
        	woong[i]:addEventListener("tap", woongTap)
   		end
	end
	addEvent()


	--레이어 정리
	sceneGroup:insert( background )
	sceneGroup:insert( woongGroup )
	sceneGroup:insert( setting )
	sceneGroup:insert( help )
	sceneGroup:insert( growthBox )
	sceneGroup:insert( growthText )
	sceneGroup:insert( nyangBox )
	sceneGroup:insert( nyangText )
	sceneGroup:insert( IQ )
	sceneGroup:insert( stamina )
	sceneGroup:insert( art )
	sceneGroup:insert( living )
	sceneGroup:insert( training )
	sceneGroup:insert( miniGames )
	sceneGroup:insert( IQBarGroup )
	sceneGroup:insert( staminaBarGroup )
	sceneGroup:insert( artBarGroup )
	sceneGroup:insert( livingBarGroup )
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
		-- e.g. stop timers, stop animation, unload sounds, etc.)''
		composer.removeScene('mainScreen')
		if soundVolume == 1 then
			audio.pause()
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