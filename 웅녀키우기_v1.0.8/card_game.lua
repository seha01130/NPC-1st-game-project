local composer = require( "composer" )
local scene = composer.newScene()

local gameMode 

local totalTimer
local backTimer
function scene:create( event )
	local sceneGroup = self.view

	--sound
	local correct = audio.loadSound('sound/MP_맑은 미션 성공(jingle).mp3')
	local wrong = audio.loadSound('sound/MP_맑은 실패 불안 (jingle).mp3')
	
	local textOption = {
		text = "",
		font = "font/Maplestory Bold.ttf",
	}

	--배치
	local background = display.newImage("image/card_game/Color Fill 1.png")
	background.x, background.y = display.contentCenterX, display.contentCenterY

	local timerbar = display.newImage("image/card_game/타이머 바.png")
	timerbar.x, timerbar.y = display.contentWidth*0.2, display.contentHeight*0.07

	local scorebar = display.newImage("image/card_game/점수판.png")
	scorebar.x, scorebar.y = display.contentWidth*0.48, display.contentHeight*0.07

	local stop = display.newImage("image/card_game/일시정지버튼.png")
	stop.x, stop.y = display.contentWidth*0.95, display.contentHeight*0.07

	--카드 부여(랜덤으로!!!!!!!!)
	local cardGroup = display.newGroup()
	local card = {}

	for i = 1, 12 do
		card[i] = display.newImage(cardGroup, "image/card_game/카드(" .. i .. ").png")
		card[i].src = "image/card_game/카드("..i..").png"
		card[i].name = i
	end

	for i = 13, 24 do
		card[i] = display.newImage(cardGroup, "image/card_game/카드(" .. i-12 .. ").png")
		card[i].src = "image/card_game/카드(" .. i-12 .. ").png"
		card[i].name = i
	end

	--카드 배치
	local random = {}--table
	local flag = {}
	local rd
	
	function randomCard ()
		for i = 1, 12 do
			flag[i] = 0
		end
		
		for i = 1, 12 do
			rd = math.random(12)
			while (flag[rd] ~= 0) do
			rd = math.random(12)
			end
			random[i] = rd
			flag[rd] = 1
		end
	end

	function randomCard2 ()
		for i = 13, 24 do
			flag[i] = 0
		end
		
		for i = 13, 24 do
			rd = math.random(13,24)
			while (flag[rd] ~= 0) do
			rd = math.random(13,24)
			end
			random[i] = rd
			flag[rd] = 1
		end
	end

	randomCard()
	for i = 1, 12 do
		for i = 1, 8 do
			card[random[i]].x, card[random[i]].y = display.contentWidth*(0.08 + (i-1)*0.12), display.contentHeight*0.28
			card[i + 24] = display.newImage(cardGroup, "image/card_game/카드_뒷면.png")
			card[i + 24].x, card[i + 24].y = display.contentWidth*(0.08 + (i-1)*0.12), display.contentHeight*0.28
		end
		for i = 9, 12 do
			card[random[i]].x, card[random[i]].y = display.contentWidth*(0.08 + (i-9)*0.12), display.contentHeight*0.57
			card[i + 24] = display.newImage(cardGroup, "image/card_game/카드_뒷면.png")
			card[i + 24].x, card[i + 24].y = display.contentWidth*(0.08 + (i-9)*0.12), display.contentHeight*0.57
		end
	end

	randomCard2()
	for i = 13, 24 do
		for i = 13, 16 do
			card[random[i]].x, card[random[i]].y = display.contentWidth*(0.08 + (i-9)*0.12), display.contentHeight*0.57
			card[i + 24] = display.newImage(cardGroup, "image/card_game/카드_뒷면.png")
			card[i + 24].x, card[i + 24].y = display.contentWidth*(0.08 + (i-9)*0.12), display.contentHeight*0.57
		end
		for i = 17, 24 do
			card[random[i]].x, card[random[i]].y = display.contentWidth*(0.08 + (i-17)*0.12), display.contentHeight*0.86
			card[i + 24] = display.newImage(cardGroup, "image/card_game/카드_뒷면.png")
			card[i + 24].x, card[i + 24].y = display.contentWidth*(0.08 + (i-17)*0.12), display.contentHeight*0.86
		end
	end

	local score = display.newText(textOption)
	score.text = 0
	score.x, score.y = display.contentWidth*0.48, display.contentHeight*0.07
	score.size = 80
	score:setFillColor(0, 0, 0)

	--카드 뒤집기
	local count = 0
	local x 
	local y 

	local function BackCard ( event )
		event.target:toBack()
	end
	
	local function tapCard( event )
		event.target:toFront()	

		if(count % 2 == 0) then
			x = event.target
			y = event.target
			count = count + 1  -- 뒤집을때마다 count+1
			x:toFront()
		elseif (count % 2 ~= 0 and x.name ~= event.target.name) then
			y = event.target
			y:toFront()
			count = count + 1  -- 뒤집을때마다 count+1
		end

		print(x.src)
		print(y.src)
		print(count)

		if(x.src == y.src and x ~= y) then
			if(x.src == 'image/card_game/카드(3).png') then
				score.text = score.text + 60
				audio.play(correct)
			else
				score.text = score.text + 40
				audio.play(correct)
			end
			x:toFront()
			y:toFront()
			--점수 중복 삭제
			x:removeEventListener("tap", tapCard)
			y:removeEventListener("tap", tapCard)

		elseif(x.src ~= y.src and x ~= nil and y ~= nil and count % 2 == 0) then
			local BackTime = display.newText("1", display.contentWidth*0.6, display.contentHeight*0.07)
			BackTime.size = 50
			BackTime.alpha = 0

			audio.play(wrong)

			for i = 1, 24 do
				card[i]:removeEventListener("tap",tapCard)
			end
			for i = 25, 48 do
				card[i]:removeEventListener("tap",BackCard)
			end

			local function Btimer (event)
				BackTime.text = BackTime.text - 1

				if(BackTime.text == '0') then
					x:toBack()
					y:toBack()

					for i = 1, 24 do
						card[i]:addEventListener("tap",tapCard)
					end
					for i = 25, 48 do
						card[i]:addEventListener("tap",BackCard)
					end
				end
			end

			backTimer = timer.performWithDelay(300, Btimer, 1)
			print("다르다")
		end

		composer.setVariable("score", score.text)
	end

	for i = 1, 24 do
		card[i]:addEventListener("tap", tapCard)
	end
	for i = 25, 48 do
		card[i]:addEventListener("tap", BackCard)
	end
	
	--전체 시간 타이머
	--local totalTime = display.newText("60", display.contentWidth*0.2, display.contentHeight*0.07)
	local totalTime = display.newText(textOption)
	totalTime.text = 60
	totalTime.x, totalTime.y = display.contentWidth*0.2, display.contentHeight*0.07
	totalTime.size = 80
	totalTime:setFillColor(0, 0, 0)

	function Ttimer (event)
		totalTime.text = totalTime.text - 1

		if(totalTime.text == '-1' or score.text == "500") then
			totalTime.text = '끝'

			composer.gotoScene("card_ending")
		end
	end

	totalTimer = timer.performWithDelay(1000, Ttimer,61)

	--일시정지 버튼 누르기
	local function stopTime (event)
		for i = 1, 24 do
			card[i]:removeEventListener("tap",tapCard)
		end
		for i = 25, 48 do
			card[i]:removeEventListener("tap",BackCard)
		end

		timer.pause(totalTimer)
		composer.setVariable("totalTimer", totalTimer)

		composer.showOverlay('card_setting')
	end

	stop:addEventListener("tap", stopTime)

	--함수 정리
	composer.setVariable("card", card)
	composer.setVariable("tapCard",tapCard)
	composer.setVariable("BackCard",BackCard)

	--레이어 정리
	sceneGroup:insert(background)
	sceneGroup:insert(cardGroup)
	sceneGroup:insert(scorebar)
	sceneGroup:insert(score)
	sceneGroup:insert(timerbar)
	sceneGroup:insert(totalTime)
	sceneGroup:insert(stop)
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

		composer.removeScene('card_game')
		timer.cancel( totalTimer )
		--timer.cancel( backTimer )
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
