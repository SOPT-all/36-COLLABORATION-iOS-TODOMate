# 합동세미나 앱8팀 투두메이트 iOS
<br>

## 🍎 Developers

| [성현주 (Lead)](https://github.com/https://github.com/hye0njuoo) | [이나연](https://github.com/y-eonee) | [이수용](https://github.com/pedro0527) | 
| --- | --- | --- | 
| <p align="center"><img src="https://github.com/hye0njuoo.png" width="260"/></p> |  <p align="center"> <img src="https://github.com/y-eonee.png" width="270"/></p>  | <p align="center"><img src="https://github.com/pedro0527.png" width="370"/></p> | 
| <p align="center"> 투두 리스트 UI, 투두 상세 조회 api, 메인 태스크 생성 api, 서브 태스크 생성 api </p> | <p align="center"> 캘린더 컴포넌트 UI, Base Service 세팅, 서브 태스크 완료 api</p> | <p align="center">키보드 툴바 UI, 메인 태스크 완료 api         </p> | 

<br>

## Git Convention
### Prefix
- `feat`: 새로운 기능을 구현 시 사용
- `design`: UI 디자인 변경 시 사용
- `docs` : README, 템플릿 등 프로젝트 내 문서 수정 시 사용
- `add` : 사진 등 에셋이나 라이브러리 추가 시 사용
- `del` : 파일이나 코드 삭제 시 사용
- `fix`: 버그나 오류 해결 시 사용
- `refactor` : 코드 리팩토링 시 사용
- `hotfix`: 급하게 치명적인 버그 수정 시 사용
- `chore` : 별로 중요한 수정이 아닐 시 사용
</aside>

<br>


### Branch Naming Rule
- 브랜치의 경우 이슈 번호를 붙여 작성합니다.
- 타입/#이슈번호 - 구현할 기능
- feat/#2 - loginVC

<br>

### Git Flow
- develop 브랜치는 생성하지 않고 이슈 번호에 맞는 브랜치를 만들어서 작업한 후, main 브랜치로 PR 후 머지합니다.
- PR 작성자 이외의 다른 팀원들이 코드 리뷰를 진행하고, 문제가 없을 경우에 approve 합니다.
- 충돌이 생기게 되는 경우 리드 및 팀원에게 공유합니다.
- 모든 작업 전에는 pull을 받습니다.

<br>

## Code Convention
- Swift Lint에서 설정한 규칙과, 킥오프 때 정한 코드 컨벤션을 따릅니다.
- PR 작성 시 Swift Lint의 검사를 받고, 통과 후 merge합니다.
  

## 시연영상
| 날짜 변경 |
| ------ |
| <video src ="https://github.com/user-attachments/assets/da5e0700-3667-4cd0-abe7-0a17e3af0892" /> |

| 메인 태스크 생성 | 서브 태스크 생성 |
| -------------| --------------|
| <video src="https://github.com/user-attachments/assets/75cf25bb-17c8-47ed-9e0b-b3b05c96980f" /> | <video src ="https://github.com/user-attachments/assets/7d658582-752c-4854-a174-7c4537f5cd21" />|

| 메인, 서브 태스크 완료 상태 패치 |
| ------ |
| <video src ="https://github.com/user-attachments/assets/d07ff764-7c37-40fc-bd49-dc9b53024799" /> |
