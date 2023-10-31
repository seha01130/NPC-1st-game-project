-----------------------------------------------------------------------------------------
--
-- catchbug_game.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local timeAttack
local timerFlag = false
local backgroundMusic

function scene:create( event )

	print("catbug_game")
	local sceneGroup = self.view

	local textOption = {
		text = "",
		font = "font/Maplestory Bold.ttf",
	}

	-- sound
	if (soundVolume == 1) then
		backgroundMusic = audio.loadSound( "sound/catchbug_BGM.mp3" )
		audio.play(backgroundMusic, {loops = -1})
	end
	local pawSound = audio.loadSound("sound/catchbug_pawSoundEffect.wav")
	local deadSound = audio.loadSound("sound/catchbug_deadSound.wav")
	local spiderSound = audio.loadSound("sound/catchbug_spiderSound.wav")

	
------display-------------------------------------------------------------------
	local background = display.newImageRect("image/catchbug/background.png",display.contentWidth, display.contentHeight)	
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local leaf = display.newImage("image/catchbug/leaf.png",display.contentHeight,display.contentHeight)
	leaf.x, leaf.y = display.contentWidth/2, display.contentHeight/2

	local scoreBox = display.newImage("image/catchbug/미니게임 스코어 UI.png", 413,169)
	scoreBox.x, scoreBox.y = display.contentWidth*0.85, display.contentHeight*0.87

	local score = display.newText(textOption)
	score.text = "0"
	score.size = 85
	score.x, score.y = scoreBox.x, scoreBox.y + 8
	score:setFillColor(0.33,0.19,0.2)

	local timerImg = display.newImage("image/catchbug/타이머.png",215.61,241.18)
	timerImg.x, timerImg.y = display.contentWidth*0.65, display.contentHeight*0.86

	local time = display.newText(textOption)
	time.text = "30"
	time.size = 85
	time.x, time.y = timerImg.x, timerImg.y + 12
	time:setFillColor(0.33,0.19,0.2)

	local paw = display.newImage("image/catchbug/paw.png")
	paw.alpha = 0

	local paw_2 = display.newImage("image/catchbug/paw_2.png")
	paw_2.alpha = 0

	local setting = display.newImageRect("image/catchbug/일시정지.png",92.96, 92.81)
	setting.x, setting.y = display.contentWidth*0.965, display.contentHeight*0.06

------------- bugs--------------------------------------------
	local bugGroup = display.newGroup()
	local bugs = {}

	for i = 1, 5 do
		bugs[i] = display.newImageRect(bugGroup, "image/catchbug/bug.png",152,173)
		bugs[i].alpha = 0
	end

	local bugLocX = {}
	local bugLocY = {}

	bugLocX[1] = 381 bugLocX[2] = 255 bugLocX[3] = 407 bugLocX[4] = 134 bugLocX[5] = 286 bugLocX[6] = 394 bugLocX[7] = 71 bugLocX[8] = 183 bugLocX[9] = 306 bugLocX[10] = 441 bugLocX[11] = 54 bugLocX[12] = 182 bugLocX[13] = 364 bugLocX[14] = 407 bugLocX[15] = 569 bugLocX[16] = 714 bugLocX[17] = 908 bugLocX[18] = 980 bugLocX[19] = 1100 bugLocX[20] = 1310 bugLocX[21] = 1042 bugLocX[22] = 1215 bugLocX[23] = 642 bugLocX[24] = 1086 bugLocX[25] = 953 bugLocX[26] = 771 bugLocX[27] = 632 bugLocX[28] = 533 bugLocX[29] = 717 bugLocX[30] = 911 bugLocX[31] = 1065 bugLocX[32] = 1164 bugLocX[33] = 1342 bugLocX[34] = 1460 bugLocX[35] = 1502 bugLocX[36] = 1318 bugLocX[37] = 1138 bugLocX[38] = 963 bugLocX[39] = 819 bugLocX[40] = 623 bugLocX[41] = 717 bugLocX[42] = 852 bugLocX[43] = 1008 bugLocX[44] = 1154 bugLocX[45] = 1264 bugLocX[46] = 1354 bugLocX[47] = 1415 bugLocX[48] = 1470 bugLocX[49] = 1306 bugLocX[50] = 1288 bugLocX[51] = 1148 bugLocX[52] = 1122 bugLocX[53] = 856 bugLocX[54] = 1349 bugLocX[55] = 1479 bugLocX[56] = 1496
	bugLocY[1] = 396 bugLocY[2] = 490 bugLocY[3] = 494 bugLocY[4] = 609 bugLocY[5] = 639 bugLocY[6] = 642 bugLocY[7] = 758 bugLocY[8] = 760 bugLocY[9] = 764 bugLocY[10] = 752 bugLocY[11] = 891 bugLocY[12] = 889 bugLocY[13] = 879 bugLocY[14] = 975 bugLocY[15] = 1000 bugLocY[16] = 1008 bugLocY[17] = 1005 bugLocY[18] = 999 bugLocY[19] = 560 bugLocY[20] = 420 bugLocY[21] = 335 bugLocY[22] = 740 bugLocY[23] = 612 bugLocY[24] = 847 bugLocY[25] = 851 bugLocY[26] = 859 bugLocY[27] = 863 bugLocY[28] = 768 bugLocY[29] = 749 bugLocY[30] = 743 bugLocY[31] = 746 bugLocY[32] = 733 bugLocY[33] = 721 bugLocY[34] = 713 bugLocY[35] = 594 bugLocY[36] = 598 bugLocY[37] = 601 bugLocY[38] = 607 bugLocY[39] = 627 bugLocY[40] = 621 bugLocY[41] = 484 bugLocY[42] = 476 bugLocY[43] = 472 bugLocY[44] = 501 bugLocY[45] = 479 bugLocY[46] = 530 bugLocY[47] = 461 bugLocY[48] = 370 bugLocY[49] = 366 bugLocY[50] = 271 bugLocY[51] = 368 bugLocY[52] = 274 bugLocY[53] = 358 bugLocY[54] = 232 bugLocY[55] = 110 bugLocY[56] = 257


---------spider--------------------------------------------------
	local spiderGroup = display.newGroup()
	local spider = {}
	for i = 1, 3 do 
		spider[i] = display.newImage(spiderGroup, "image/catchbug/spider2.png")
		spider[i].alpha = 0
	end
	spider[1].x, spider[1].y = 66 ,490
	spider[2].x, spider[2].y = 630, 330
	spider[3].x, spider[3].y = 1725, 730

	local spiderDownSheet = graphics.newImageSheet("image/catchbug/움직거밀.png",{width=984/6, height=1080, numFrames=6})
	local spiderDownSequenceData = {
		name = "spiderDown",
		sheet = spiderDownSheet,
		time = 1000,
		-- start = 1,
		-- count = 6,
		frames = {1,2,2,3,3,4,4,5,5,5,5,5,6},
		loopCount = 1,
		loopDirection = "forword"
	}

	local spiderUpSheet = graphics.newImageSheet("image/catchbug/움직거미.png",{width=493/3 ,height = 1080, numFrames =3})
	local spiderUpSequenceData = {
		name = "spiderUp",
		sheet = spiderUpSheet,
		time= 350,
		start =1,
		count = 3,
		loopCount = 1,
		loopDirection = "forword"
	}

	local spiderFlag = 0	
	local spiderNum = 0
	local spiderCount = 0

---------earthworm ------------------------------------------

	local earthwormGroup = display.newGroup()
	local earthworm = {}
	for i = 1, 3 do
		earthworm[i] = display.newImage(earthwormGroup,"image/catchbug/earthworm1_1.png")
		earthworm[i].alpha = 0
	end
	earthworm[1].x, earthworm[1].y= 260, 900
	earthworm[2].x, earthworm[2].y= 820, 950
	earthworm[3].x, earthworm[3].y= 1020, 890

	local deadWorm = display.newImage("image/catchbug/earthworm1_2.png")
	deadWorm.alpha= 0

	local earthwormUpSheet = graphics.newImageSheet("image/catchbug/움직렁일.png",{width=176, height = 1080, numFrames = 7})
	local earthwormUpSequenceData = {
		name="wormUp",
		sheet = earthwormUpSheet,
		time = 1000,
		-- start = 1,
		-- count = 7,
		frames = {1,2,3,3,4,4,5,5,5,6,6,6,6,6,6,7},
		loopCount =1,
		loopDirection ="forword"
	}

	local earthwormDownSheet = graphics.newImageSheet("image/catchbug/움직렁이.png", {width=174, height=1080, numFrames=5})
	local earthwormDownSequenceData = {
		name = "wormDown",
		sheet = earthwormDownSheet,
		time = 500,
		start = 1,
		count = 5,
		loopCount = 1,
		loopDirection = "forword"
	}

	local earthwormCount = 0
	local earthwormNum = 0
	local earthwormFlag = 0


------- paw 기능 : tap시 paw 나타나고 1초 후 사라짐----------------------
	local function pawTimer( event )
		-- body
		-- print("paw showed")
		paw.alpha = 0
		paw_2.alpha = 0
	end	

	local function earthwormTimer( event )
		deadWorm.alpha = 0
	end


	local function tapAndPaw( event )
		-- print("tapped target:"..tostring(event.target) )
		-- print("tapped location: "..tostring(event.x)..","..tostring(event.y))
		paw.x, paw.y = event.x, event.y
		paw_2.x, paw_2.y = event.x, event.y

		audio.play(pawSound)

		-- 설정탭
		if(paw.x > setting.x - 70 and paw.x < setting.x +70 
			and paw.y > setting.y - 70 and paw.y < setting.y +70) then
			paw.alpha = 0
		end
		
		local pawTime = timer.performWithDelay(100,pawTimer)
		
		-- 벌레 탭
		for i = 1, 5 do
			if(bugs[i].alpha == 1 and event.x > bugs[i].x - 70 and event.x < bugs[i].x + 70 and
			 event.y > bugs[i].y - 70 and event.y < bugs[i].y + 70) then
				
				paw_2.alpha = 1 
				score.text = score.text + 100
				bugs[i].alpha = 0

				print("Catch bug: "..i,bugs[i].x,bugs[i].y, bugs[i].alpha)
				return true
			end
		end

		--거미탭(multipleTaps)
		if event.numTaps == 2 then
			if(spiderFlag ~= 0) then
				if(spiderNum == 1 and event.x > spider[1].x - 70 and event.x < spider[1].x + 70 and event.y > spider[1].y - 70 and event.y < spider[1].y + 70) then
					spider[1].alpha = 0
				elseif(spiderNum == 2 and event.x > spider[2].x - 70 and event.x < spider[2].x + 70 and event.y > spider[2].y - 70 and event.y < spider[2].y + 70) then
					spider[2].alpha = 0
				elseif(spiderNum == 3 and event.x > spider[3].x - 70 and event.x < spider[3].x + 70 and event.y > spider[3].y - 70 and event.y < spider[3].y + 70) then
					spider[3].alpha = 0
				end
					paw_2.alpha = 1
					score.text = score.text + 500
					spiderFlag = 0
					spiderCount = 0
					audio.play(spiderSound)
					print("spider Catch!!!!"..spiderCount)
			end

		end

		--지렁이 탭
		if earthwormFlag ~= 0 then
			if (earthwormNum == 1 and event.x > earthworm[1].x-70 and event.x < earthworm[1].x+70 and event.y > 550 and event.y <1000)then
				print("earthworm1 touched,,,")
				audio.play(deadSound)
				earthworm[1].alpha = 0
				deadWorm.x , deadWorm.y = earthworm[1].x, earthworm[1].y
				deadWorm.alpha = 1
				paw.alpha = 1
				score.text = score.text - 500
				earthwormFlag = 0
				earthwormCount = 0
			elseif (earthwormNum == 2 and event.x > earthworm[2].x-70 and event.x < earthworm[2].x+70 and event.y > 600 and event.y <1000)then
				print("earthworm2 touched,,,")
				audio.play(deadSound)
				earthworm[2].alpha = 0
				deadWorm.x , deadWorm.y = earthworm[2].x, earthworm[2].y
				deadWorm.alpha = 1
				paw.alpha = 1
				score.text = score.text - 500
				earthwormFlag = 0
				earthwormCount = 0
			elseif (earthwormNum == 3 and event.x > earthworm[3].x-70 and event.x < earthworm[3].x+70 and event.y > 550 and event.y <1000)then
				print("earthworm3 touched,,,")
				audio.play(deadSound)
				earthworm[3].alpha = 0
				deadWorm.x , deadWorm.y = earthworm[3].x, earthworm[3].y
				deadWorm.alpha = 1
				paw.alpha = 1
				score.text = score.text - 500
				earthwormFlag = 0
				earthwormCount = 0
			end
			
			local deadWormTime = timer.performWithDelay(500,earthwormTimer)
		end

		paw.alpha = 1

		return true
	end 
	
	background:addEventListener("tap",tapAndPaw)

	for i = 1, 5 do
		bugs[i]:addEventListener("tap",tapAndPaw)
	end

	spiderGroup:addEventListener("tap", tapAndPaw)
	earthwormGroup:addEventListener("tap", tapAndPaw)


---------bugs 기능-----------
	local randomLoc ={0,0,0,0,0}
	local tmp
	local function showBug( num )
		local i = 1
	
		while (i <= num) do
			tmp = math.random(1,56) 
			print("i: "..i.." tmp random 수:"..tmp)--.." 중복여부: "..table.indexOf(randomLoc,tmp))
			if(table.indexOf(randomLoc,tmp) == nil) then
				randomLoc[i] = tmp
				bugs[i].x, bugs[i].y = bugLocX[randomLoc[i]], bugLocY[randomLoc[i]]
				bugs[i].alpha = 1
				print("bug i: "..i.."bugLocation: ".. randomLoc[i])
			else
				i = i - 1
			end
			i = i + 1
		end
	end 

------- time ---------------------------------------------------
	local bugTime = 0
	
	local function counter( event )
		bugTime = bugTime+1
		earthwormCount = earthwormCount+1
		spiderCount = spiderCount +1 
		-- print("bugTime: "..bugTime)

		time.text = time.text - 1

		if time.text == '10' then
			time:setFillColor(1,0,0)
		elseif time.text == '-1' then
			composer.setVariable("score",tonumber(score.text))
			composer.gotoScene("catchbug_ending")
		end

		if(bugTime >= math.random(2,3)) then
			for i = 1, 5 do
				bugs[i].alpha = 0
			end
			-- print("bugTime: "..bugTime)
			showBug(math.random(2,4))
			print("")
			bugTime = 0

		end

		if (spiderFlag == 0 and spiderCount >= math.random(8,12)) then
			print("its Spider Time!: "..spiderCount)
			spiderNum = math.random(1,3) 
			local downSpider = display.newSprite(spiderDownSheet, spiderDownSequenceData)
			if spiderNum == 1 then
				downSpider.x , downSpider.y = 80,740
			elseif spiderNum == 2 then
				downSpider.x , downSpider.y = 645,580
			elseif spiderNum == 3 then
				downSpider.x , downSpider.y = 1740,980
			end
			sceneGroup:insert(downSpider)
			downSpider:play()
			spiderFlag = spiderCount
		end
		if (spiderFlag ~= 0 )then
			if(spiderCount == spiderFlag+1) then
				spider[spiderNum].alpha = 1
			elseif (spiderCount == spiderFlag+5) then
				print("not catched spider")
				-- 못잡고 올라가는 코드
				spider[spiderNum].alpha = 0
				local upSpider = display.newSprite(spiderUpSheet, spiderUpSequenceData) 
				if spiderNum == 1 then
					upSpider.x , upSpider.y = 74, 750
				elseif spiderNum == 2 then
					upSpider.x , upSpider.y = 640, 600
				elseif spiderNum == 3 then
					upSpider.x , upSpider.y = 1740, 1000
				end
				sceneGroup:insert(upSpider)
				upSpider:play()
				spiderFlag = 0
				spiderCount = 0
			end
		end



		if(earthwormFlag == 0 and earthwormCount >= math.random(9,13)) then
			
			earthwormNum = math.random(1,3)
			local upWorm = display.newSprite(earthwormUpSheet, earthwormUpSequenceData)
			if earthwormNum == 1 then
				upWorm.x, upWorm.y = 260, 620
			elseif earthwormNum == 2 then
				upWorm.x, upWorm.y =  820, 630
			elseif earthwormNum == 3 then
				upWorm.x, upWorm.y = 1020, 600
			end
			sceneGroup:insert(upWorm)
			upWorm:play()
			earthwormFlag = earthwormCount
			print("worm Time!:"..earthwormCount.."wormnum: "..earthwormNum)
		end
		if(earthwormFlag ~= 0) then
			if(earthwormCount == earthwormFlag+1)then
				print("worm shoed")
				earthworm[earthwormNum].alpha = 1
			elseif (earthwormCount == earthwormFlag+4) then
				print("not catch earthworm")
				earthworm[earthwormNum].alpha = 0
				local downWorm = display.newSprite(earthwormDownSheet, earthwormDownSequenceData)
				if earthwormNum == 1 then
					downWorm.x, downWorm.y = 260, 620
				elseif earthwormNum == 2 then
					downWorm.x, downWorm.y =  820, 630
				elseif earthwormNum == 3 then
					downWorm.x, downWorm.y = 1020, 600
				end
				sceneGroup:insert(downWorm)
				downWorm:play()
				earthwormFlag = 0
				earthwormCount = 0
			end
		end

		if (time.text == '0') then
			time.alpha = 0
		end
	end 

	timeAttack = timer.performWithDelay(1000,counter,34)

---------setting : 일시정지 ----------------------------------
	function setting:tap( event )
		background:removeEventListener("tap", tapAndPaw)
		timer.pause(timeAttack)
		composer.setVariable("timeAttack", timeAttack)
		composer.setVariable("mainbackground", background)
		composer.setVariable("tapAndPaw", tapAndPaw)
		composer.showOverlay('catchbug_setting')
	end
	setting:addEventListener("tap", setting)
------------------------------------------------------------

	--레이어정리
	sceneGroup:insert(background)
	sceneGroup:insert(leaf)
	sceneGroup:insert(scoreBox)
	sceneGroup:insert(score)
	sceneGroup:insert(timerImg)
	sceneGroup:insert(time)
	sceneGroup:insert(paw)
	sceneGroup:insert(paw_2)
	sceneGroup:insert(bugGroup)
	sceneGroup:insert(setting)
	sceneGroup:insert(spiderGroup)
	sceneGroup:insert(earthwormGroup)
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
		composer.removeScene('catchbug_game')
		timerFlag = composer.getVariable("timerFlag")
		print(timerFlag)
		if timerFlag == false then
			timer.cancel(timeAttack)
		end
		if soundVolume == 1 then
			audio.pause(backgroundMusic)
		end
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