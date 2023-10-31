-----------------------------------------------------------------------------------------
--
-- ending.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local ending_score
local ending_money

function scene:create( event )
	local sceneGroup = self.view

	local textOption = {
		text = "",
		font = "font/Maplestory Bold.ttf",
	}

    local background = display.newImageRect("image/shower_game/미니게임 결과 ui - 웅녀씻기기.png", display.contentWidth, display.contentHeight)
    background.x, background.y = display.contentWidth/2, display.contentHeight/2

	ending_score = composer.getVariable("ending_score")
	
    local endingText = display.newText(textOption)
	endingText.text = (ending_score)
	endingText.x, endingText.y = display.contentWidth*0.32, display.contentHeight*0.57
    endingText.size = 150
    endingText:setFillColor(0.33, 0.19, 0.2)
    endingText.alpha = 1
	
	if (ending_score % 2 == 1) then
		ending_money = (ending_score-1) / 2
	else
		ending_money = ending_score / 2
	end
	local moneyText = display.newText(textOption)
	moneyText.text = (ending_money)
	moneyText.x, moneyText.y = display.contentWidth*0.63, display.contentHeight*0.57
	moneyText.size = 150
	moneyText:setFillColor(0.33, 0.19, 0.2)
	
	local goToMain = display.newImage("image/shower_game/메인으로.png")
	goToMain.x, goToMain.y = display.contentWidth*0.8, display.contentHeight*0.35

	local replay = display.newImage("image/shower_game/다시하기 (1).png")
	replay.x, replay.y = display.contentWidth*0.72, display.contentHeight*0.35

	local Data = jsonParse("json/status.json")
	Data.nyang_json = Data.nyang_json + ending_money
	if (Data) then
		print(Data.IQ_json)
		print(Data.stamina_json)
		print(Data.art_json)
		print(Data.living_json)
		print(Data.nyang_json)
	end
	jsonSave("json/status.json", Data)

	function replay:tap( event )
		composer.gotoScene("shower_preview")
	end
	replay:addEventListener("tap", replay)
    function goToMain:tap( event )
        composer.gotoScene('mainScreen')
    end
    goToMain:addEventListener("tap", goToMain)

    sceneGroup:insert(background)
	sceneGroup:insert(endingText)
	sceneGroup:insert(moneyText)
	sceneGroup:insert(replay)
	sceneGroup:insert(goToMain)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
        audio.stop()
	elseif phase == "did" then


	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		composer.removeScene("shower_ending")

	elseif phase == "did" then
		

	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
