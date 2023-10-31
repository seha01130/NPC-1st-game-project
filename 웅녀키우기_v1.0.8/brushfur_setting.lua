-----------------------------------------------------------------------------------------
--
-- brushfur_setting.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
--flag setting만 껐다 킴 => false / 메인화면, 다시시작 true
local flag = false

function scene:create( event )
	--setting Text option
	local sceneGroup = self.view
	
	local text = composer.getVariable("text")
	local explainTextOption = 
	{
		text = text,
		x = display.contentWidth/2, 
		y = display.contentHeight*0.4,
		fontSize = 50,
		align = "center"
	}
	local timeAttack = composer.getVariable("timeAttack")
	
	--세팅 창
 	local settingWindow = display.newImage("image/brushfur_game/미니게임-옵션창.png")
 	settingWindow.x, settingWindow.y = 490 + settingWindow.contentWidth / 2, 272 + settingWindow.contentHeight / 2
 	
 	--다시시작 버튼
 	local retry = display.newImage("image/brushfur_game/다시하기.png")
 	retry.x, retry.y = 648 + retry.contentWidth / 2, 400 + retry.contentHeight / 2
 	function retry:tap( event )
 		flag = true
 		composer.setVariable("timerFlag", true)
 		composer.gotoScene('brushfur_game')
 	end
 	retry:addEventListener("tap", retry)

 -- 	--볼륨 크기 조절
 -- 	local volumeUpDownGroup = display.newGroup()
 -- 	local volumeUpDown = {}
 -- 	volumeUpDown[1] = display.newRect(700,550,100,100)
 -- 	volumeUpDown[2] = display.newRect(1300,550,100,100)

 -- 	volumeUpDownGroup:insert(volumeUpDown[1])
 -- 	volumeUpDownGroup:insert(volumeUpDown[2])

 -- 	local volumeLevel = display.newText(soundVolumeLevel, 1000, 550)
 -- 	volumeLevel.size = 100
 -- 	volumeLevel:setFillColor(0)

 -- 	local function volumeUp ( event )
 -- 		if volumeLevel.text ~= '10' then
 -- 			volumeLevel.text = volumeLevel.text + 1
 -- 			soundVolumeLevel = soundVolumeLevel + 1
 -- 			audio.setVolume(soundVolumeLevel * 0.1)
 -- 			print(soundVolumeLevel)
 -- 		end
 -- 	end

 -- 	local function volumeDown ( event )
 -- 		if volumeLevel.text ~= '1' then
 -- 			volumeLevel.text = volumeLevel.text - 1
 -- 			soundVolumeLevel = soundVolumeLevel - 1
 -- 			audio.setVolume(soundVolumeLevel * 0.1)
 -- 		end
 -- 	end

 -- 	volumeUpDown[1]:addEventListener("tap", volumeDown)
 -- 	volumeUpDown[2]:addEventListener("tap", volumeUp)

 -- 	--볼륨 버튼 onoff
 -- 	local volumeGroup = display.newGroup()
 -- 	local volume = {}
 -- 	volume[1] = display.newRect(700,700,100,100)
 -- 	volume[1]:setFillColor(1,1,0)
 -- 	volume[2] = display.newRect(700,700,100,100)
 -- 	volume[2]:setFillColor(0,1,1)

 -- 	for i = 1, 2 do
 -- 		volumeGroup:insert(volume[i])
 -- 		volume[i].alpha = 0
	-- end

 -- 	if soundVolume == 1 then
 -- 		volume[1].alpha = 1
 -- 	else
 -- 		volume[2].alpha = 1
 -- 	end

 -- 	local function tapVolume( event )
 -- 		if soundVolume == 1 then
 -- 			audio.setVolume(0)
 -- 			volume[1].alpha = 0
 -- 			volume[2].alpha = 1
 -- 			soundVolume = 0
 -- 		else
 -- 			audio.setVolume(soundVolumeLevel * 0.1)
 -- 			volume[1].alpha = 1
 -- 			volume[2].alpha = 0
 -- 			soundVolume = 1
 -- 		end
 -- 	end

 -- 	volumeGroup:addEventListener("tap", tapVolume)

 	--메인화면으로 버튼
 	local main = display.newImage("image/brushfur_game/다른미니게임선택.png")
 	main.x, main.y = 954 + main.contentWidth / 2, 401 + main.contentHeight / 2
 	function main:tap( event )
 		flag = true
 		composer.setVariable("timerFlag", false)
 		composer.gotoScene('minigame_choice')
 	end
 	main:addEventListener("tap", main)

 	--닫기 버튼
 	local close = display.newImage("image/brushfur_game/닫기.png")
 	close.x, close.y = 1300 + close.contentWidth / 2, 331 + close.contentHeight / 2
 	------touchFur 함수 불러오기
 	local touchFur = composer.getVariable("touchFur")
 	local twistFur = composer.getVariable("twistFur")
 	function close:tap( event )
 		timer.resume(timeAttack)
 		local fur = composer.getVariable("fur")
 		timer.resume(fur)
 		composer.hideOverlay('setting')
 		if twistFur ~= nil then
	 		for i = 1, #twistFur do
	 			print(i, "엔딩")
	 			twistFur[i]:addEventListener("touch", touchFur)
	 		end
	 	end
 	end

 	close:addEventListener("tap", close)

 	--그룹
 	sceneGroup:insert(settingWindow)
 	sceneGroup:insert(close)
 	sceneGroup:insert(main)
 	sceneGroup:insert(retry)
 	-- sceneGroup:insert(volumeGroup)
 	-- sceneGroup:insert(volumeUpDownGroup)
 	-- sceneGroup:insert(volumeLevel)
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
		if flag == true then
			--composer.removeScene('minigame_brushfur')
			local fileName = composer.getVariable("fileName")
			composer.removeScene(fileName)
			composer.removeScene('brushfur_ending')
			audio.pause()
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