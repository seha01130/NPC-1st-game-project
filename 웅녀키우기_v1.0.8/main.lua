-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

-- include Corona's "widget" library
local widget = require "widget"

local json = require "json"

-- json parsing
function jsonParse( src ) --json파싱 함수 작성
	local filename = system.pathForFile( src )

	local data, pos, msg = json.decodeFile( filename )

	if (data) then
		return data
	else
		print("WARNING: " .. pos, msg)
		return nil
	end
end

--json 세이브
function jsonSave( src, data )
	local filename = system.pathForFile( src )

	local text, pos, msg = json.encode( data )

	local file, errorString = io.open( filename, "w" )

	if not file then
    	print( "File error: " .. errorString )
	else
	    file:write( text )
	    io.close( file )
	end
end



local composer = require "composer"

-- json에서 정보 읽기

local Data = jsonParse("json/status.json")
if(Data) then
	print(Data.IQ_json)
	print(Data.stamina_json)
	print(Data.art_json)
	print(Data.living_json)
	print(Data.nyang_json)
end

--sound flag 전역변수
soundVolume = 1
---soundTable----  --지수님 main.lua 라인45~55 갖고옴
soundTable = {
	brushfur_BGM = audio.loadSound("sound/brushFurBGM.mp3"),
	brushfur_soundEffect= audio.loadSound("sound/brushSound.mp3"),
	training_BGM = audio.loadSound("sound/trainingBGM.mp3"),
	trainingSound_1 = audio.loadSound("sound/trainingSound_1.mp3"),
	trainingSound_2 = audio.loadSound("sound/trainingSound_2.mp3"),
	trainingSound_3 = audio.loadSound("sound/trainingSound_3.mp3"),
	trainingSound_4 = audio.loadSound("sound/trainingSound_4.mp3"),
	minigameChoiceBGM = audio.loadSound("sound/minigameChoiceBGM.mp3")
}

--소리크기
loudness = 10

--지능 체력 예술 살림 숫자 전역변수 --json에서 로드
IQNum = Data.IQ_json
staminaNum = Data.stamina_json
artNum = Data.art_json
livingNum = Data.living_json

--재화 냥 전역변수 --json에서 로드
nyang = Data.nyang_json

--성장도 전역변수
growth = (IQNum+staminaNum+artNum+livingNum)*12.5


-- event listeners for tab buttons:
local function onFirstView( event )
	composer.gotoScene( "startScreen" )
end

local function onSecondView( event )
	composer.gotoScene( "view2" )
end

onFirstView()	-- invoke first tab button's onPress event manually