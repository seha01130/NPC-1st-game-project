-----------------------------------------------------------------------------------------
--
-- mainScreen_setting.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local settingScreen = display.newImage("image/settingImages/메인화면-설정옵션창.png")
	settingScreen.x, settingScreen.y = display.contentWidth/2, display.contentHeight/2

	--엑스버튼
	local out = display.newImage("image/settingImages/닫기.png")
	out.x, out.y = display.contentWidth*0.812, display.contentHeight*0.308

	local startClickBGM = audio.loadSound("sound/clickSound.wav")
	function out:tap( event )
		audio.play(startClickBGM)
		addEvent()
 		composer.hideOverlay('mainScreen_setting')
 	end
 	out:addEventListener("tap", out)

	--배경음악 on off
	local volumeGroup = display.newGroup()
 	local volume = {}
 	volume[1] = display.newImage("image/settingImages/on-활성화.png")
	volume[1].x, volume[1].y = display.contentWidth*0.501, display.contentHeight*0.476
 	volume[2] = display.newImage("image/settingImages/on.png")
	volume[2].x, volume[2].y = display.contentWidth*0.501, display.contentHeight*0.476
	--off 활성화 / off 비활성화
	volume[3] = display.newImage("image/settingImages/off-활성화.png")
	volume[3].x, volume[3].y = display.contentWidth*0.655, display.contentHeight*0.474
	volume[4] = display.newImage("image/settingImages/off.png")
	volume[4].x, volume[4].y = display.contentWidth*0.655, display.contentHeight*0.474

 	for i = 1, 4 do
 		volumeGroup:insert(volume[i])
 		volume[i].alpha = 0
	end

 	if soundVolume == 1 then				--on
 		volume[1].alpha = 1
 		volume[4].alpha = 1
 		audio.setVolume(loudness * 0.1)
 	else 									--off
 		volume[2].alpha = 1
 		volume[3].alpha = 1
 		audio.setVolume(0)
 	end

 	local function tapVolume2( event )
 		audio.setVolume(loudness * 0.1)
 		volume[1].alpha = 1
 		volume[2].alpha = 0
 		volume[3].alpha = 0
 		volume[4].alpha = 1
 		soundVolume = 1
 		print("soundVolume : "..soundVolume)
 	end
 	volume[2]:addEventListener("tap", tapVolume2)

 	local function tapVolume4( event )
 		audio.setVolume(0)
 		volume[1].alpha = 0
 		volume[2].alpha = 1
 		volume[3].alpha = 1
 		volume[4].alpha = 0
 		soundVolume = 0
 		print("soundVolume : "..soundVolume)
 	end
 	volume[4]:addEventListener("tap", tapVolume4)

	--음악크기 up down 버튼
	local soundUp = display.newImage("image/settingImages/up.png")
	soundUp.x, soundUp.y = display.contentWidth*0.705, display.contentHeight*0.6
	local soundDown = display.newImage("image/settingImages/down.png")
	soundDown.x, soundDown.y = display.contentWidth*0.451, display.contentHeight*0.6

	--음악크기 설정
	local soundGroup = display.newGroup()
 	local sound = {}
 	sound[0] = display.newImage("image/settingImages/0.png")
	sound[0].x, sound[0].y = display.contentWidth*0.578, display.contentHeight*0.6
	sound[0].alpha = 0
	soundGroup:insert(sound[0])
 	for i=1,9 do
 		local num = i * 10
 		sound[i] = display.newImage("image/settingImages/"..num..".png")
		sound[i].x, sound[i].y = display.contentWidth*0.578, display.contentHeight*0.599
		sound[i].alpha = 0
		soundGroup:insert(sound[i])
 	end
 	sound[10] = display.newImage("image/settingImages/100.png")
	sound[10].x, sound[10].y = display.contentWidth*0.578, display.contentHeight*0.6
	sound[10].alpha = 0
	soundGroup:insert(sound[10])


-- 크레딧 
	local creditButton = display.newImage("image/settingImages/음악 아이콘.png")
    creditButton.x, creditButton.y = 1421+creditButton.contentWidth/2, 296+creditButton.contentHeight/2


    local creditImage = display.newImage("image/settingImages/음악출처 창.png")
    creditImage.x, creditImage.y = 13+display.contentWidth/2, display.contentHeight/2

    creditImage.alpha = 0

    function creditButton:tap( event )
        creditImage.alpha = 1
    end
    creditButton:addEventListener("tap", creditButton)

    function creditImage:tap( event )
        creditImage.alpha = 0
    end
    creditImage:addEventListener("tap", creditImage)

	--해당 음악크기 숫자만 보이게
	-- local loud = loudness * 10
	-- print(loud)
	for i = 0, 10 do
		if i == loudness then
			print(i)
			sound[i].alpha = 1
		end
	end

	--소리 on
	audio.setVolume(loudness * 0.1)
	print("loudness : "..loudness)

 	local function tapSoundUp( event )
 		volume[1].alpha = 1
 		volume[2].alpha = 0
 		volume[3].alpha = 0
 		volume[4].alpha = 1
 		soundVolume = 1

 		if loudness ~= 10 then
 			sound[loudness].alpha = 0
 			loudness = loudness + 1
 			audio.setVolume(loudness * 0.1)
 			sound[loudness].alpha = 1
 		end
 	end
 	soundUp:addEventListener("tap", tapSoundUp)

 	local function tapSoundDown( event )
 		volume[1].alpha = 1
 		volume[2].alpha = 0
 		volume[3].alpha = 0
 		volume[4].alpha = 1
 		soundVolume = 1

 		if loudness ~= 0 then
 			sound[loudness].alpha = 0
 			loudness = loudness - 1
 			audio.setVolume(loudness * 0.1)
 			sound[loudness].alpha = 1
 		end
 	end
 	soundDown:addEventListener("tap", tapSoundDown)


	--레이어 정리
	sceneGroup:insert( settingScreen )
	sceneGroup:insert( out )
	sceneGroup:insert( volumeGroup )
	sceneGroup:insert( soundUp )
	sceneGroup:insert( soundDown )
	sceneGroup:insert( soundGroup )
	sceneGroup:insert(creditButton)
	sceneGroup:insert( creditImage )
	
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
		-- composer.removeScene()               -----------이거맞나요???????
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