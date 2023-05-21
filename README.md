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


> **개발자 문서 사이트**</br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:link: [Solar2D Documentation](https://docs.coronalabs.com/)

> **JSON 간단 설명** [json 파일 입출력으로 세이브로드 구현하기]
  - 로드(스터디에서 사용) (jsonParse)
    - system.pathForFile()로 json파일을 찾음
    - json.decodeFile()로 텍스트를 사용 가능한 data로 바꾼다.
  - 세이브
    - system.pathForFile()로 json파일을 찾음
    - (decode의 반대는 encode) json.encode()로 lua에서 사용 가능했던 data를 텍스트로 바꿈
    - local file, errorString = io.open( path, "w" )로 파일을 쓰기 모드로 열어서 file:write( encode()로 바꾼 텍스트 )
    - io.close( file )로 파일 닫음</br>
:link: [파일 쓰기 관련 개발자 사이트 가이드](https://docs.coronalabs.com/guide/data/readWriteFiles/index.html#writing-files)

> **json관련 공유**
> **세이브 부분**

json.encode()사용했을 시 attempt to index global 'json' (a nil value)오류가 뜬다면 : 

local json = require(”json”)작성으로 해결

오류들

```LUA
if not file then
		print("File error: " .. errorString)
	else
		file:write(money)
		io.close(file)
	end
  ```
  
  not file에 걸려서  Documents\json/status.json: No such file or directory이 출력

해결하고 싶어서 pathForFile()에 json/을 지워봄 > 오류는 생기지 않지만 저장도 되지 않는다.

```LUA
file:write(money)
io.close(file)
```
if문 없애고 이렇게 적었을 시에는 > attempt to index local 'file' (a nil value) 오류

```LUA
local path = system.pathForFile("json/status.json")--, system.DocumentsDirectory)
```
main이 다시 열렸고 json파일에 데이터가 저장되었다. >한번만 저장되고 그 다음부터는 저장이 되지않음
jsonSave()함수로 인해 발생하는 것과 비슷한 결과..

파일오류를 고치기 위해서 pathForFile()에 경로를 C:/~~ 자세히 적었더니 아래 줄에서 오류 발생
```LUA
local file, errorString = io.open(path, "w")
```
bad argument #1 to 'open' (string expected, got nil) 오류

추측 :아마 경로로 인해 nil으로 나오는 것 같다

