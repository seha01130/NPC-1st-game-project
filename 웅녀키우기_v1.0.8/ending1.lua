-----------------------------------------------------------------------------------------
--
-- ending1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	local textOption = {
		text = "",
		font = "font/Maplestory Bold.ttf",
		align = "center"
	}

	local endingBGM = audio.loadSound("sound/endingBGM.mp3")

	if soundVolume == 1 then
		audio.play(endingBGM, {loops = -1})
		audio.setVolume(loudness * 0.1)
	end

----- endingCode & flag setting-------------------	
	local status ={}
	local Data = jsonParse("json/status.json")
	if Data then
		status[1] = Data.IQ_json
		status[2] = Data.stamina_json
		status[3] = Data.art_json
		status[4] = Data.living_json
	end

	local endingCode 
	local flag1, flag2 = 0,0

	if status[1] == 2 and status[2] == 2 and status[3] == 2 and status[4] == 2 then
		endingCode = 44
		flag1 = 1
	else
		for i = 1, 4 do
			if status[i] >= 3 then
				if flag1 == 0 then
					flag1 = i
				elseif flag2 == 0 then
					flag2 = i
				end
			end
		end
		endingCode = flag1*10+flag2
	end

	print("endingCode: "..endingCode)
	print("flag1"..flag1.."flag2"..flag2)

------- 화면 ---------------------------------------------

	local background = display.newRect(display.contentWidth/2, display.contentHeight/2,1920,1080)
	local scriptBar = display.newImage("image/endingImage/스크립트바.webp",display.contentCenterX, display.contentHeight*0.87)
	local btn = display.newImage("image/endingImage/넘김버튼.webp",display.contentWidth*0.95,display.contentHeight*0.87)
	local script = display.newRect(display.contentCenterX + 30, display.contentHeight*0.87,1679,76)


	local again = display.newImage("image/endingImage/처음부터.webp")
	again.x, again.y = 1684 + again.contentWidth / 2, 33 + again.contentHeight/2
	again.alpha = 0

	function tapAgain( event )


	--데이터 파싱 후 스탯들 0으로 초기화
		local statusData = jsonParse("json/status.json")
		statusData.IQ_json = 0
		statusData.stamina_json = 0
		statusData.art_json = 0
		statusData.living_json = 0

		--초기화한 스탯들 세이브
		jsonSave("json/status.json", statusData)
		composer.gotoScene('mainScreen')
	end


	local tmp = 99
	local index = 99

	local EndingData = jsonParse("json/ending.json")
	if EndingData then
		for i = 1, 11 do
			tmp = EndingData[i].endingCode
			if tmp == endingCode then
				index = i
			end
		end
	end

	background.fill = {
		type = "image",
		filename = EndingData[index].image1
	}
	script.fill = {
		type = "image",
		filename = EndingData[index].script1
	}

	local i = 1
	
	function background:tap( event ) 
		i = i+1

		if (i <= EndingData[index].pageNum) then
			if(i == 2) then
				background.fill ={
					type = "image",
					filename = EndingData[index].image2 
				}
				script.fill = {
					type = "image",
					filename = EndingData[index].script2
				}
			elseif (i == 3) then
				background.fill ={
					type = "image",
					filename = EndingData[index].image3 
				}
				script.fill = {
					type = "image",
					filename = EndingData[index].script3
				}
			elseif (i == 4) then
				background.fill ={
					type = "image",
					filename = EndingData[index].image4
				}
				script.fill = {
					type = "image",
					filename = EndingData[index].script4
				}
			elseif (i == 5) then
				background.fill ={
					type = "image",
					filename = EndingData[index].image5
				}
				script.fill = {
					type = "image",
					filename = EndingData[index].script5
				}
			end
		else 
			background.fill = {
				type = "image",
				filename = EndingData[index].Endingimage
			}
			scriptBar.alpha = 0
			script.alpha = 0
			btn.alpha = 0
			if(endingCode == 30 or endingCode == 34 or endingCode == 10) then
				again.y = display.contentHeight*0.88
			end
			again.alpha = 1
			again:addEventListener("tap", tapAgain)
		end
	end
	background:addEventListener("tap",background)




-------- sceneGroup에 넣기----------------------------------
	sceneGroup:insert( background )
	sceneGroup:insert(scriptBar)
	sceneGroup:insert(btn)
	sceneGroup:insert(script)
	sceneGroup:insert(again)

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
		if soundVolume == 1 then
			audio.pause()
		end
		-- composer.removeScene(ending1)
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