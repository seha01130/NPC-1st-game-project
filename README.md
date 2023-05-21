## [중앙동아리 NPC LUA game project] :bear: 웅녀키우기
![메인일러 최종](https://user-images.githubusercontent.com/102642679/222091269-74f0e388-5d32-4f02-9b27-de0d5479c165.png)

:link: [Google Playstore](https://play.google.com/store/apps/details?id=ddwu.npc.woong) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
:video_camera: [게임 시연영상](https://youtu.be/PoZm6OoTf3Q)
------

> **What I did** </br>
- 4개의 minigame 중 farming 파트 작업
- startScreen 작업
- mainScreen 작업
- setting & 도움말 작업
- audio sound & json 작업
------
**:link: [개발자 문서 사이트](https://docs.coronalabs.com/)**</br>

> **메인 게임 기능 정리**
- game start 버튼이 들어간 진입화면 ⇒ 메인 화면 진입
- 메인화면 → 미니게임 선택하는 화면 진입/옵션/도움말/성장도(전체/각분야별)/수련
- 설정 → 배경음 ON/OFF, 볼륨조정
- 수련 설정 → 홈으로가기, 도움말, 수련선택
- 수련 중 화면 → 일러스트(Sprite Animation)띄우고 15-20초 기다리기 (진행바 채워지기)
- 수련완료시 수련완료! 팝업→ 바로 홈화면으로 넘어가도록 구현
- 미니게임 선택 화면 → 메인 화면 돌아가기/미니게임 이미지/미니게임 설명 버튼 → 설명 팝업창
- 미니게임 설정창 → 다시하기/미니게임선택창으로 나가기
- 엔딩화면 → 수련일러스트+문구→엔딩일러스트+웅녀다시키우기 버튼(reset)
- 수련 → 8번 가면 엔딩/수련금액 1회당 1000냥
- 재화 저장은 json 파일 입출력 활용


> **JSON 간단 설명** [json 파일 입출력으로 세이브로드 구현하기]
  - 로드(스터디에서 사용) (jsonParse)
    - system.pathForFile()로 json파일을 찾음
    - json.decodeFile()로 텍스트를 사용 가능한 data로 바꾼다.
  - 세이브
    - system.pathForFile()로 json파일을 찾음
    - (decode의 반대는 encode) json.encode()로 lua에서 사용 가능했던 data를 텍스트로 바꿈
    - local file, errorString = io.open( path, "w" )로 파일을 쓰기 모드로 열어서 file:write( encode()로 바꾼 텍스트 )
    - io.close( file )로 파일 닫음 </br>
:link: [파일 쓰기 관련 개발자 사이트 가이드](https://docs.coronalabs.com/guide/data/readWriteFiles/index.html#writing-files)

> **json 세이브 기능 정리** </br>
main.lua에 함수 작성
```LUA
local json = require "json"

function jsonParse( src )
	local filename = system.pathForFile( src )
	
	local data, pos, msg = json.decodeFile( filename )

	if data then
		return data
	else
		print("WARNING: " .. pos, msg)
		return nil
	end
end

function jsonSave( src, data )
	local filename = system.pathForFile( src )

	local text, pos, msg = json.encode( data )

	local file, errorString = io.open( filename, "w" )

	if not file then
		print("File error: " .. errorString )
	else
		file:write( text )
		io.close( file )
	end
end
```
데이터 값을 저장해야하는 lua파일에 데이터를 불러오기, 데이터 값 바뀐 것 적용
```LUA
local Data = jsonParse("json/status.json")
	Data.nyang_json = Data.nyang_json + ending_score
	if (Data) then
		print(Data.IQ_json)
		print(Data.stamina_json)
		print(Data.art_json)
		print(Data.living_json)
		print(Data.nyang_json)
	end

	jsonSave("json/status.json", Data)
```
</br>
Q. 만약 자꾸 프로젝트가 다시 시작되는 오류가 발생한다면? </br>
A. solar2D 시뮬레이터가 파일이 변경되면 바로 다시 실행하기 때문이다. </br></br>

**해결책** </br>
시뮬레이터에서 file > Preferences >Never 선택 </br>
❗❗이 설정을 하기 전에는 편집프로그램에서 저장을 누르면 프로젝드가 다시 실행되었겠지만, </br>
설정을 바꿨으므로 프로젝트를 재시작하기 위해서 ctrl + r을 사용해야 한다.

