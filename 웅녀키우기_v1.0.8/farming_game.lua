-----------------------------------------------------------------------------------------
--
-- farming_game.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local timeAttack
local timerFlag = false
local backgroundMusic

function scene:create( event )
	local sceneGroup = self.view

	
	if (soundVolume == 1) then
		backgroundMusic = audio.loadSound( "sound/farmingSound.mp3" )
		audio.play(backgroundMusic, {onComplete=bombExplode, loops = -1})
	end
	local correct = audio.loadSound("sound/correctSound.wav")
	local wrong = audio.loadSound("sound/wrongSound.mp3")
	--local uproot = audio.loadSound("sound/uprootSound.wav")

	local background = display.newImageRect( "image/farmingImages/background.png", display.contentWidth, display.contentHeight )
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local basket = display.newImage("image/farmingImages/basket.png")
	basket.alpha = 1
	basket.x, basket.y = display.contentWidth*0.7165, display.contentHeight*0.7336
	
	local cropGroup = display.newGroup()
	local crop = {}

	local dirtGroup = display.newGroup()
	local dirt = {}

	
	local frontGround = display.newImageRect( "image/farmingImages/frontGround.png", display.contentWidth, display.contentHeight )
	frontGround.x, frontGround.y = display.contentWidth/2, display.contentHeight/2

	----------- 작물 위치 배치 ----------------
	------위 밭
	local rd = math.random(6)
	crop[1] = display.newImage(cropGroup, "image/farmingImages/crop"..rd..".png")
	crop[1].src = "image/farmingImages/crop"..rd..".png"
	crop[1]:scale(0.3,0.3)
	crop[1].x, crop[1].y = display.contentWidth*0.141, display.contentHeight*0.32

	rd = math.random(6)
	crop[2] = display.newImage(cropGroup, "image/farmingImages/crop"..rd..".png")
	crop[2].src = "image/farmingImages/crop"..rd..".png"
	crop[2]:scale(0.3,0.3)
	crop[2].x, crop[2].y = display.contentWidth*0.352, display.contentHeight*0.31

	rd = math.random(6)
	crop[3] = display.newImage(cropGroup, "image/farmingImages/crop"..rd..".png")
	crop[3].src = "image/farmingImages/crop"..rd..".png"
	crop[3]:scale(0.3,0.3)
	crop[3].x, crop[3].y = display.contentWidth*0.535, display.contentHeight*0.31

	-------아래 밭
	rd = math.random(6)
	crop[4] = display.newImage(cropGroup, "image/farmingImages/crop"..rd..".png")
	crop[4].src = "image/farmingImages/crop"..rd..".png"
	crop[4]:scale(0.3,0.3)
	crop[4].x, crop[4].y = display.contentWidth*0.185, display.contentHeight*0.55

	rd = math.random(6)
	crop[5] = display.newImage(cropGroup, "image/farmingImages/crop"..rd..".png")
	crop[5].src = "image/farmingImages/crop"..rd..".png"
	crop[5]:scale(0.3,0.3)
	crop[5].x, crop[5].y = display.contentWidth*0.39, display.contentHeight*0.55

	rd = math.random(6)
	crop[6] = display.newImage(cropGroup, "image/farmingImages/crop"..rd..".png")
	crop[6].src = "image/farmingImages/crop"..rd..".png"
	crop[6]:scale(0.3,0.3)
	crop[6].x, crop[6].y = display.contentWidth*0.575, display.contentHeight*0.545

	local scoreBox = display.newImage("image/farmingImages/스코어 ui.png")
	scoreBox:scale(0.18, 0.18)
	scoreBox.x, scoreBox.y = display.contentWidth*0.35, display.contentHeight*0.87

	local scoreOptions = 
	{
	    text = 0,     
	    x = scoreBox.x,
	    y = scoreBox.y + display.contentHeight*0.01,
	    font = "font/Maplestory Bold.ttf",   
	    fontSize = 70
	}
 
	local score = display.newText( scoreOptions )
	score:setFillColor(0.33, 0.19, 0.2)

	local timeBox = display.newImage("image/farmingImages/타이머 ui.png")
	timeBox:scale(0.15, 0.15)
	timeBox.x, timeBox.y = display.contentWidth*0.06, display.contentHeight*0.13

	local timeOptions = 
	{
	    text = 20,     
	    x = timeBox.x,
	    y = timeBox.y + display.contentHeight*0.015,
	    font = "font/Maplestory Bold.ttf",   
	    fontSize = 70
	}
 
	local time = display.newText( timeOptions )
	time:setFillColor(0.33, 0.19, 0.2)

	local countGroup = display.newGroup()
	local count = {}

	sceneGroup:insert( background )
	sceneGroup:insert( basket )

	sceneGroup:insert( cropGroup )
	sceneGroup:insert( frontGround )
	
	sceneGroup:insert( dirtGroup )
	sceneGroup:insert( countGroup )
	sceneGroup:insert( scoreBox )
	sceneGroup:insert( score )
	sceneGroup:insert( timeBox )
	sceneGroup:insert( time )

	-----drag 함수-------
	local function dragCrop( event )

 		if( event.phase == "began" ) then
 			display.getCurrentStage():setFocus( event.target )
 			event.target.isFocus = true
 			-- 드래그 시작할 때

 			event.target:toFront()
	

 			-- 따라서 드래그 처음 시작할때 x y값을 따로 변수에 넣어준다음에 그걸 사용. 그럼 오차 없어짐
 			event.target.initX = event.target.x --처음x값event.target.x이 event.target.initX에 저장됨
 			event.target.initY = event.target.y

 		elseif( event.phase == "moved" ) then

 			if ( event.target.isFocus ) then
 				-- 드래그 중일 때

 				event.target:toFront()
 				
 				--선택한 작물이 흙더미들 앞에 있도록.
 				for i=1,6 do
 					if (event.target == crop[i]) then
 						sceneGroup:insert( frontGround )
 						sceneGroup:insert( crop[i] )
 					end
 				end

 --frontGroundGroup.isVisible = false

 				event.target.x = event.xStart + event.xDelta
 				event.target.y = event.yStart + event.yDelta
 			end

 		elseif ( event.phase == "ended" or event.phase == "cancelled") then

 			if ( event.target.isFocus ) then --추가
	 			display.getCurrentStage():setFocus( nil )
	 			event.target.isFocus = false

	 			-- 드래그 끝났을 때
	 			if ( event.target.x > basket.x - 230 and event.target.x < basket.x + 270
	 				and event.target.y > basket.y - 130 and event.target.y < basket.y + 230) then
--frontGroundGroup.isVisible = true

					--끝나면 다시 흙더미들을 작물들 앞에 위치시키기
 					sceneGroup:insert( cropGroup )
 					sceneGroup:insert( frontGround )

	 				for i = 1, 6 do
		 				if (event.target == crop[i]) then
		 					display.remove(dirt[i])
		 					count[i] = 0 --드래그가 끝날때 event.target과 crop[i]가 같으면
		 					--그 crop의 count를 다시 0으로 돌려주기
		 				end
		 			end

	 				if (event.target.src == "image/farmingImages/crop1.png" or event.target.src == "image/farmingImages/crop4.png") then
	 					score.text = score.text + 1000
	 					audio.play(correct, {onComplete=bombExplode})
	 				else
	 					score.text = score.text - 400
	 					audio.play(wrong, {onComplete=bombExplode})
	 				end

	 				rd = math.random(6)
	 				for i = 1, 6 do
		 				if (event.target == crop[i]) then

		 					display.remove( event.target )

							crop[i] = display.newImage(cropGroup, "image/farmingImages/crop"..rd..".png")
							crop[i].src = "image/farmingImages/crop"..rd..".png"
							crop[i]:scale(0.35,0.35)
							crop[i].x, crop[i].y = event.target.initX, event.target.initY + 55

							for i = 1, 6 do
						 		--count[i] = 0 여기서는 이거 하면 어떤걸 드래그하던 계속 모든 작물의
						 		--count가 0으로 초기화됨 따라서 여기서는 이전의 count를 갖고있어야 함
								function tapCrop( event )
					 				sceneGroup:insert( frontGround )
					 				sceneGroup:insert( crop[i] )

									if (count[i] < 1) then
										event.target.y = event.target.y - 55
										dirt[i] = display.newImage(dirtGroup,"image/farmingImages/dirt.png")
										dirt[i]:scale(0.7,0.7)
										dirt[i].x, dirt[i].y = event.target.x, event.target.y + 20
										--audio.play(uproot, {onComplete=bombExplode})
										count[i] = count[i] + 1
									end
									if (count[i] == 1) then
							 			crop[i]:addEventListener("touch", dragCrop)
							 		end
								end
								crop[i]:addEventListener("tap", tapCrop)

						 	end

						end
					end

	 			else
	 				event.target.x = event.target.initX --event.xStart이걸 넣으면 오차가 생김
	 				event.target.y = event.target.initY
	 			end
	 		else
	 			display.getCurrentStage():setFocus( nil )
 				event.target.isFocus = false
 			end
 		end
 	end

 	-----tap 후에야 drag 가능----
 	
 	for i = 1, 6 do
 		count[i] = 0 --맨 처음에만 count를 다 0으로

		function tapCrop( event )
			if (event.target == crop[i]) then
				sceneGroup:insert( frontGround )
				sceneGroup:insert( crop[i] )
			end
			
			if (count[i] < 1) then
				event.target.y = event.target.y - 55
				dirt[i] = display.newImage(dirtGroup,"image/farmingImages/dirt.png")
				dirt[i]:scale(0.7,0.7)
				dirt[i].x, dirt[i].y = event.target.x, event.target.y + 20
				--audio.play(uproot, {onComplete=bombExplode})
				count[i] = count[i] + 1
			end
			if (count[i] == 1) then
	 			crop[i]:addEventListener("touch", dragCrop)
	 		end
		end

		crop[i]:addEventListener("tap", tapCrop)
 	end

	---------호랑이 누르면 작물 종류들 갱신--------

	tiger = display.newImage("image/farmingImages/호랑이버튼.png")
	tiger:scale(0.5,0.5)
	tiger.x, tiger.y = display.contentWidth*0.06, display.contentHeight*0.89

	sceneGroup:insert( tiger )

	function tapTiger( event )
			for i = 1, 6 do
				display.remove(crop[i])
			end
			for i = 1, 6 do
				display.remove(dirt[i])
			end

			rd = math.random(6)
			crop[1] = display.newImage(cropGroup, "image/farmingImages/crop"..rd..".png")
			crop[1].src = "image/farmingImages/crop"..rd..".png"
			crop[1]:scale(0.3,0.3)
			crop[1].x, crop[1].y = display.contentWidth*0.15, display.contentHeight*0.32

			rd = math.random(6)
			crop[2] = display.newImage(cropGroup, "image/farmingImages/crop"..rd..".png")
			crop[2].src = "image/farmingImages/crop"..rd..".png"
			crop[2]:scale(0.3,0.3)
			crop[2].x, crop[2].y = display.contentWidth*0.352, display.contentHeight*0.31

			rd = math.random(6)
			crop[3] = display.newImage(cropGroup, "image/farmingImages/crop"..rd..".png")
			crop[3].src = "image/farmingImages/crop"..rd..".png"
			crop[3]:scale(0.3,0.3)
			crop[3].x, crop[3].y = display.contentWidth*0.535, display.contentHeight*0.31

			-------아래 밭
			rd = math.random(6)
			crop[4] = display.newImage(cropGroup, "image/farmingImages/crop"..rd..".png")
			crop[4].src = "image/farmingImages/crop"..rd..".png"
			crop[4]:scale(0.3,0.3)
			crop[4].x, crop[4].y = display.contentWidth*0.185, display.contentHeight*0.55

			rd = math.random(6)
			crop[5] = display.newImage(cropGroup, "image/farmingImages/crop"..rd..".png")
			crop[5].src = "image/farmingImages/crop"..rd..".png"
			crop[5]:scale(0.3,0.3)
			crop[5].x, crop[5].y = display.contentWidth*0.39, display.contentHeight*0.55

			rd = math.random(6)
			crop[6] = display.newImage(cropGroup, "image/farmingImages/crop"..rd..".png")
			crop[6].src = "image/farmingImages/crop"..rd..".png"
			crop[6]:scale(0.3,0.3)
			crop[6].x, crop[6].y = display.contentWidth*0.575, display.contentHeight*0.545

			for i = 1, 6 do
 				count[i] = 0
				function tapCrop( event )
					if (event.target == crop[i]) then
					 	sceneGroup:insert( frontGround )
					 	sceneGroup:insert( crop[i] )
					end
					 				
					if (count[i] < 1) then
						event.target.y = event.target.y - 55
						dirt[i] = display.newImage(dirtGroup,"image/farmingImages/dirt.png")
						dirt[i]:scale(0.7,0.7)
						dirt[i].x, dirt[i].y = event.target.x, event.target.y + 20
						--audio.play(uproot, {onComplete=bombExplode})
						count[i] = count[i] + 1
					end
					if (count[i] == 1) then
	 					crop[i]:addEventListener("touch", dragCrop)
	 				end
				end
				crop[i]:addEventListener("tap", tapCrop)
 			end
	end
	tiger:addEventListener("tap", tapTiger)


	function removeEvent (event)
		tiger:removeEventListener("tap", tapTiger)
	end


	-------------timer----------------

	local function counter( event )
 		time.text = time.text - 1

 		if (time.text == '10') then
 			time:setFillColor(1, 0, 0)
 		end

 		if (time.text == '0') then
 			
 			time.alpha = 0

 			--화면에 보이는 모든 것 투명도 50%
 			background.alpha = 0.5
			basket.alpha = 0.5
			cropGroup.alpha = 0.5
			countGroup.alpha = 0.5
			score.alpha = 0.5
			tiger.alpha = 0.5
			timeBox.alpha = 0.5
			scoreBox.alpha = 0.5
			tiger:removeEventListener("tap", tapTiger)
 			for i = 1, 6 do
 				display.remove( crop[i] )
 				display.remove(dirt[i])
 			end
 			
 			composer.setVariable("score", score.text)
 			composer.setVariable("timeAttack", timeAttack)
 			composer.gotoScene('farming_ending')
 		end
 	end

 	timeAttack = timer.performWithDelay(1000, counter, 20)


 	------ setting 화면---------

 	local setting = display.newImage("image/farmingImages/setting.png")
	setting:scale(0.16,0.16)
	setting.x, setting.y = display.contentWidth*0.96, display.contentHeight*0.07

 	function setting:tap( event )
 		timer.pause(timeAttack)
 		composer.setVariable("timeAttack", timeAttack)
 		composer.setVariable("cropGroup", cropGroup)
 		--composer.setVariable("fileName", "farming_preview")
 		removeEvent()
 		cropGroup.isVisible = false
 		composer.showOverlay('farming_setting')
 	end
 	setting:addEventListener("tap", setting)

 	sceneGroup:insert(setting)

end

---------------------------------------------------------------------

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		display.remove(background2)
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
		composer.removeScene('farming_game') --hide()에서 씬을 삭제해서 다시 돌아올때 새롭게 scene이 생성되도록 한다
		--근데 오류가 날수도! timer는 장면이 전환되어도 계속 돌아가기 때문에, 필요가 없다면
		--timer를 꼭 삭제해 주어야 한다! 특히 무한반복되는 timer의 경우에는 이 상황을 꼭 고려해야!!
		timerFlag = composer.getVariable("timerFlag")
		print(timerFlag)
		if timerFlag == false then
			timer.cancel( timeAttack )
		end
		if soundVolume == 1 then
			audio.pause(backgroundMusic) --ending화면으로 넘어가면서 game화면이 숨겨질 때 오디오가 멈추게 됨
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