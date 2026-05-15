# Obsidian 제2의 뇌 설계

날짜: 2026-05-15
상태: 사용자 리뷰용 설계 초안

## 목표

Obsidian을 기반으로, 자료와 생각을 지속적으로 입력받고, 원본을 보존하며, 기존 기억과 비교해 의미 있는 구조로 재배열하고, 링크를 생성하고, 인사이트를 표면으로 끌어올리는 제2의 뇌를 만든다.

이 시스템은 단순한 노트 보관소가 아니다. 개인 지식 컴파일러다.

1. 입력을 보존한다.
2. 지식을 작은 연결 객체로 재작성한다.
3. 인사이트를 한눈에 보이게 한다.
4. 인사이트를 프로젝트, 의사결정, 산출물로 전환한다.
5. 실행 결과를 다시 학습 자산으로 되돌린다.

설계 방향은 Andrej Karpathy의 LLM Wiki 아이디어를 참고한다. 새 자료를 매번 임시 검색하는 데 그치지 않고, raw input을 관리되는 Markdown wiki로 계속 컴파일하는 방식이다.

## 범위

첫 버전에서 정의할 것:

- Obsidian vault 디렉토리 구조
- 핵심 노트 타입과 메타데이터 기준
- Codex와 Claude Code가 사용할 스킬 경계
- raw input에서 인사이트와 실행으로 이어지는 데이터 흐름
- 홈 대시보드와 리뷰 루프 규칙
- 신뢰성, 에러 처리, 검증 기준

첫 버전에서는 완전 자율형 상시 에이전트를 만들지 않는다. 먼저 Codex와 Claude Code가 같은 규칙으로 따를 수 있는 반자동 워크플로를 만든다.

## 핵심 원칙

사용자는 자료나 생각을 정리하지 않고 자유롭게 입력할 수 있어야 한다.

시스템의 책임:

- 애매한 입력을 안전하게 보존한다.
- 필요하면 분류를 미룬다.
- 새 자료를 기존 기억과 비교한다.
- 연결된 객체 노트를 생성하거나 갱신한다.
- 의미 있는 연결만 인사이트로 승격한다.
- 근거와 확신도를 드러낸다.

## 권장 아키텍처

`Compiled Wiki + Execution Layer` 구조를 사용한다.

### 계층

- `10_Capture`: 빠르고 마찰이 적은 입력 입구
- `20_Sources`: 원본 보존 계층
- `30_Objects`: 개념, 주장, 질문, 인사이트, 결정, 사람, 방법론 같은 작은 객체 노트
- `40_Maps`: 토픽 맵, 프로젝트 맵, 연구 맵, 인덱스 노트
- `50_Execution`: 프로젝트, 계획, 결정, 산출물, 회고
- `60_Reviews`: 일간, 주간, 월간, lint, synthesis 리포트
- `00_System`: 템플릿, 스키마, 대시보드, 로그, 운영 규칙
- `90_Archive`: 비활성, 대체됨, 폐기됨, 오래된 자료
- `_assets`: 이미지, 파일, export, thumbnail, 첨부 자료

### 처리 루프

1. `Capture`: raw material이나 자유로운 생각을 받는다.
2. `Ingest`: 출처, 맥락, 메타데이터, 처리 상태를 보존한다.
3. `Compile`: 기존 객체, 맵, 프로젝트, 결정과 비교한다.
4. `Link`: Source, Object, Map, Execution 노트를 연결한다.
5. `Surface`: 새 연결, 긴장, 결정 후보, 다음 행동을 대시보드에 드러낸다.
6. `Review`: 약한 링크, 모순, 오래된 주장, 미해결 질문, 병합 후보를 찾는다.

## Vault 디렉토리 구조

```text
00_System/
  dashboards/
  logs/
  schemas/
  templates/
  lint/

10_Capture/
  inbox/
  quick-notes/
  unprocessed/
  attachments-staging/

20_Sources/
  sessions/
  web/
  videos/
  images/
  documents/
  books/
  papers/

30_Objects/
  concepts/
  people/
  claims/
  questions/
  insights/
  decisions/
  methods/

40_Maps/
  topic-maps/
  project-maps/
  research-maps/
  index-notes/

50_Execution/
  projects/
  plans/
  decisions/
  outputs/
  retrospectives/

60_Reviews/
  daily/
  weekly/
  monthly/
  lint-reports/
  synthesis-reports/

90_Archive/
  inactive/
  superseded/
  deprecated/
  old-outputs/

_assets/
  images/
  files/
  exports/
  thumbnails/
```

## 노트 타입

### Source

원본 자료와 간결한 요약을 저장한다.

필수 내용:

- 원본 또는 원본 위치
- 생성일
- 입력 타입
- 요약
- 필요한 경우 핵심 발췌나 타임스탬프
- 신뢰도 또는 확신도
- 관련 Object, Map, Project, Decision 링크

### Concept

재사용 가능한 개념을 표현한다.

필수 내용:

- 정의
- 관련 개념
- 사례
- 반대 개념 또는 경쟁 개념
- Source 링크
- 관련 Question, Claim, Insight 링크

### Claim

검증 가능하거나 논쟁 가능한 주장을 표현한다.

필수 내용:

- 주장 문장
- 근거
- 반례 또는 불확실성
- 확신도
- Source 링크
- 재검토 날짜

### Question

아직 풀리지 않은 탐구 질문을 표현한다.

필수 내용:

- 질문
- 현재 가설
- 관련 Source와 Concept
- 왜 중요한지
- 다음 탐색 단계

### Insight

의미 있는 새 연결 또는 관점 변화를 표현한다.

필수 내용:

- `trigger`: 무엇이 이 인사이트를 만들었는가
- `new_connection`: 어떤 노트나 개념이 새로 연결되었는가
- `change`: 사용자의 생각이 어떻게 바뀌었는가
- `evidence`: Source 링크와 확신도
- `implication`: 그래서 무엇이 달라지는가
- `next_action`: 행동, 질문, 결정, 프로젝트 후보
- `related_project`: 연결할 실행 계층
- `review_date`: 언제 다시 볼 것인가

### Map

주제, 연구 영역, 프로젝트 지형을 표현한다.

필수 내용:

- 현재 요약
- 핵심 연결 객체
- 중요한 Source
- 열린 질문
- 현재 긴장 또는 논쟁
- 관련 Project와 Decision
- 최신 synthesis

### Project

실행 단위를 표현한다.

필수 내용:

- 목표
- 상태
- 관련 Research Map
- 핵심 Decision
- 다음 행동
- 산출물
- 회고 링크

### Decision

선택과 그 근거를 표현한다.

필수 내용:

- 결정
- 고려한 선택지
- 근거와 Source 링크
- trade-off
- 포기한 대안
- 기대 결과
- 재검토 조건 또는 날짜

## 스킬 경계

네 개의 스킬을 만든다.

### `obsidian-capture`

목적: raw material을 최소 마찰로 받는다.

책임:

- CLI session, 자유로운 생각, 메모, URL, 영상 링크, 이미지, 파일, 웹사이트 자료를 캡처한다.
- 미처리 또는 원본 노트를 `10_Capture`나 `20_Sources`에 저장한다.
- 출처, 시간, 입력 타입, 처리 상태, 원래 맥락을 기록한다.
- 애매한 자료를 억지로 분류하지 않고 보존한다.

하지 않을 것:

- 과도하게 분류하지 않는다.
- raw input을 삭제하거나 덮어쓰지 않는다.

### `obsidian-compile`

목적: raw material을 연결된 기억으로 바꾼다.

책임:

- 캡처된 Source를 기존 Object, Map, Project, Decision과 비교한다.
- Concept, Claim, Question, Insight, Map, Project, Decision 노트를 생성하거나 갱신한다.
- 새 노트 생성보다 기존 노트 갱신을 우선한다.
- 긴 노트는 작은 객체 노트로 분리한다.
- 관련 Topic Map과 Dashboard를 갱신한다.
- 변경 사항을 log에 남긴다.

하지 않을 것:

- 약한 추측을 확신 있는 Claim으로 승격하지 않는다.
- 병합 후보를 확인하지 않고 중복 객체 노트를 만들지 않는다.

### `obsidian-retrieve`

목적: vault에서 질문에 답하고, 좋은 답변을 다시 기억으로 저장한다.

책임:

- 관련 Topic Map에서 시작한다.
- Object 노트와 Source 노트로 내려간다.
- 근거 링크가 있는 답변을 제공한다.
- 불확실성을 표시한다.
- 답변 중 새 가치가 생기면 Insight, Question, Decision, Output 후보를 만든다.

하지 않을 것:

- 관련 vault 노트를 확인하지 않고 기억만으로 답하지 않는다.
- 약한 근거를 숨기지 않는다.

### `obsidian-lint`

목적: 시간이 지나도 기억의 품질을 유지한다.

책임:

- 고아 노트, 중복 개념, 오래된 Claim, 깨진 링크, 약한 근거, 미해결 질문, 오래된 Decision을 찾는다.
- 병합 후보를 제안한다.
- daily, weekly, monthly, lint, synthesis report를 만든다.
- Dashboard에 review task를 드러낸다.

하지 않을 것:

- vault의 큰 영역을 조용히 자동 재작성하지 않는다.
- 모든 문제를 즉시 해결하도록 강제하지 않는다.

## 데이터 흐름

새 항목이 들어왔을 때:

1. `obsidian-capture`가 원본 자료나 생각을 저장한다.
2. Source 또는 Capture 노트가 metadata와 processing status를 가진다.
3. `obsidian-compile`이 해당 항목을 기존 Map, Object, Project, Decision과 비교한다.
4. 적절하면 기존 노트를 갱신한다.
5. 필요할 때만 새 Object 노트를 만든다.
6. 의미 있는 새 연결이 생기면 Insight 후보를 만든다.
7. Topic Map과 Dashboard를 갱신한다.
8. 어떤 변화가 생겼는지 log에 남긴다.
9. 불확실한 자료는 unresolved, hypothesis, question 상태로 유지한다.

## Home Dashboard

홈 대시보드는 정적인 폴더 인덱스가 아니어야 한다.

보여줄 것:

- 지금 읽을 가치가 있는 핵심 Insight
- 최근 입력에서 반복되는 주제
- 새로 연결된 노트
- 활성 Question
- 긴장과 모순
- Decision 후보
- Project 기회
- 다음 행동
- lint가 발견한 review item

Dashboard는 사용자가 다시 들어올 이유를 만들어야 한다. 현재 내 사고의 움직임이 보여야 한다.

## 리뷰 리듬

### Daily Review: 3분

목적:

- 오늘 들어온 것을 본다.
- 새 Insight를 확인한다.
- 내일 볼 질문이나 행동을 하나 고른다.

### Weekly Review: 20분

목적:

- 반복 주제를 확인한다.
- 강한 Insight를 승격한다.
- Insight를 Project나 Decision으로 옮긴다.
- 간단한 lint item을 처리한다.
- 다음 연구 방향을 정한다.

### Monthly Review: 60분

목적:

- 주요 Topic Map을 갱신한다.
- 오래된 Claim과 Decision을 검토한다.
- 믿음이나 우선순위의 변화를 확인한다.
- 다음 달 연구와 실행 초점을 고른다.

## 인사이트 생성 규칙

Insight를 생성하거나 승격할 때:

- 둘 이상의 기존 노트가 새롭게 연결된다.
- 새 근거가 기존 믿음을 바꾸거나 흔든다.
- 반복 패턴이 보인다.
- Question이 실행 가능한 가설로 바뀐다.
- Source가 Project나 Decision의 방향을 바꾼다.
- 중요한 긴장이나 모순이 생긴다.

Insight를 만들지 않을 때:

- 단순 요약에 불과하다.
- 이미 표현된 뻔한 연결이다.
- 근거, 의미 변화, 다음 질문이 없다.

## 신뢰성 규칙

### Source 보존

원본 Source는 덮어쓰지 않는다. 해석, 요약, 링크는 별도 노트나 명확히 구분된 처리 섹션에 저장한다.

### 근거와 확신도

Claim, Insight, Decision은 Source 링크와 confidence level을 포함해야 한다.

권장 confidence 값:

- `low`: 가능성은 있지만 근거가 약함
- `medium`: 하나 이상의 Source가 있지만 깊게 검증되지는 않음
- `high`: 강한 근거 또는 반복 확인이 있음

### 애매함 처리

애매한 자료는 아래 상태로 보존한다.

- `unprocessed`
- `hypothesis`
- `question`
- `needs_classification`
- `needs_evidence`

### 충돌 처리

새 정보가 기존 노트와 충돌할 때:

- 기존 결론을 조용히 덮어쓰지 않는다.
- tension 또는 contradiction 항목을 만든다.
- 양쪽 근거를 모두 링크한다.
- review date를 추가한다.

### Merge-before-create

새 Object 노트를 만들기 전에, compile 과정은 유사한 기존 노트를 찾고 적절하면 update 또는 merge를 우선한다.

## 검증 기준

### Capture 통과 기준

- 원본 내용 또는 위치가 보존되어 있다.
- Source, 시간, 입력 타입, 처리 상태가 있다.
- 아직 분류되지 않아도 나중에 찾을 수 있다.

### Compile 통과 기준

- 항목이 최소 하나의 Source 또는 Capture 노트와 연결되어 있다.
- 가능한 경우 Map과 연결되어 있다.
- 관련 Object, Project, Decision 링크가 추가되어 있다.
- 불확실성이 보존되어 있다.

### Insight 통과 기준

- 무엇이 새로워졌는지 말한다.
- 근거를 링크한다.
- 의미 변화를 설명한다.
- 다음 행동, 질문, 프로젝트, 결정 중 하나를 제안한다.

### Retrieve 통과 기준

- 관련 Map 또는 Object에서 시작한다.
- 지원하는 Source 노트를 인용하거나 링크한다.
- 근거와 추론을 구분한다.
- 새 Insight나 Question이 생기면 기록한다.

### Lint 통과 기준

- 고아 노트를 보고한다.
- 중복 또는 병합 후보를 찾는다.
- 오래된 Claim과 Decision을 표시한다.
- 미해결 Question을 나열한다.
- 실행 가능한 review item을 만든다.

## 6개월 실패 모드와 대응

### 실패: Capture가 번거롭다

대응:

- 자유로운 생각 입력을 허용한다.
- 분류를 미룬다.
- 가능한 한 capture를 한 단계로 끝낸다.

### 실패: Dashboard가 재미없다

대응:

- 최근 변화, Insight, 긴장, Decision, 다음 행동을 보여준다.
- 홈을 정적인 index로 만들지 않는다.

### 실패: 비슷한 노트가 너무 많다

대응:

- 기존 노트 갱신을 우선한다.
- lint에 merge candidate를 추가한다.
- Object note type의 역할을 명확히 유지한다.

### 실패: 연구가 실행으로 이어지지 않는다

대응:

- 가능한 경우 Insight를 Project, Decision, next action에 연결한다.
- Weekly Review에 execution transfer를 포함한다.

### 실패: AI가 쓴 노트를 믿기 어렵다

대응:

- evidence, confidence, inference label을 요구한다.
- Source link를 보존한다.
- 불확실한 자료를 명시적으로 표시한다.

### 실패: Review가 숙제가 된다

대응:

- Daily Review는 3분으로 제한한다.
- Weekly Review는 20분으로 제한한다.
- 놓친 review는 다음 review로 넘겨도 되게 한다.

## 설계 결정

네 개의 스킬 구조를 사용한다.

- `obsidian-capture`
- `obsidian-compile`
- `obsidian-retrieve`
- `obsidian-lint`

먼저 vault 구조와 템플릿을 만들고, 그 구조를 기준으로 스킬을 구현한다.

사용자 관점의 성공 조건:

> 사용자가 생각과 자료를 자유롭게 넣으면, 시스템이 그것을 점진적으로 연결된 기억, 보이는 인사이트, 더 나은 실행으로 바꾼다.

