-----------------------------------------------------------------------------------------
--
-- farming_ending.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )
	local sceneGroup = self.view
	
	local score = composer.getVariable("score")
	score = tonumber(score)
	local money
	
	if (score <= 0) then
		money = 0
	else
		money = score/40
	end

	--데이터 파싱
	local Data = jsonParse("json/status.json")
	Data.nyang_json = Data.nyang_json + money
	if(Data) then
		print(Data.IQ_json)
		print(Data.stamina_json)
		print(Data.art_json)
		print(Data.living_json)
		print(Data.nyang_json)
	end
	jsonSave("json/status.json", Data)

	--ending 창 ui
	local endingResult = display.newImage("image/farmingImages/엔딩결과.png")
	endingResult.x, endingResult.y = display.contentWidth/2, display.contentHeight/2

	--텍스트 삽입
	local textOption = {
 		text = "",
 		font = "font/Maplestory Bold.ttf",
	}
	local scoreText = display.newText( textOption )
	scoreText.text = tostring(score)
	scoreText.size = 113
	scoreText:setFillColor(0.33, 0.19, 0.2)
	scoreText.x, scoreText.y = 580, 615
	local moneyText = display.newText( textOption )
	moneyText.text = tostring(money)
	moneyText.size = 113
	moneyText:setFillColor(0.33, 0.19, 0.2)
	moneyText.x, moneyText.y = 1225, 615


	--다시하기 메인으로 버튼
 	local retryButton = display.newImage("image/farmingImages/엔딩창다시하기.png")
 	retryButton.x, retryButton.y = 1342 + retryButton.contentWidth / 2, 318 + retryButton.contentHeight / 2
 	local mainButton = display.newImage("image/farmingImages/메인으로.png")
 	mainButton.x, mainButton.y = 1479 + mainButton.contentWidth / 2, 318 + mainButton.contentHeight / 2
	
	local function goMain ( event )
		--게임선택화면으로 가면 멈췄던 메인화면음악 다시 플레이되게
		if (soundVolume == 1)then
			audio.play(mainScreenMusic, {onComplete=bombExplode, loops = -1})
		end

 		composer.removeScene('farming_preview')
		composer.gotoScene('mainScreen')
	end

	local function retry ( event )
		composer.removeScene('farming_preview')
		composer.gotoScene('farming_preview')
	end
 	mainButton:addEventListener("tap", goMain)
 	retryButton:addEventListener("tap", retry)


 	--레이어 정리
 	sceneGroup:insert(endingResult)
 	sceneGroup:insert(retryButton)
 	sceneGroup:insert(mainButton)
	sceneGroup:insert(moneyText)
	sceneGroup:insert(scoreText)
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

		--여기서도 이걸 써줘야 다시하기 눌러서 다시 플레이했을 때 올바른 ending화면이 보임
		--안써주면 처음 성공 - > 실패 일때도 성공 -> 성공 이렇게 나타남
		composer.removeScene('farming_ending')
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
