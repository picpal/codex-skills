# OCR 책 Capture 품질 방어 설계

날짜: 2026-05-17
상태: 사용자 리뷰용 설계 초안

## 목표

Obsidian 제2의 뇌에서 OCR 책 PDF를 안정적으로 capture하고, 시간이 지나도 답변 품질이 떨어지지 않도록 한다.

책 OCR은 일반 링크나 짧은 메모와 다르다. 용량이 크고, 페이지가 많고, OCR 오류가 섞일 수 있으며, 한 번 잘못된 index나 요약이 만들어지면 이후 retrieve와 insight 품질까지 오염시킬 수 있다. 따라서 이번 설계는 자동화보다 품질 방어를 우선한다.

목표는 다음 네 가지다.

1. OCR PDF 원본을 안전하게 보존한다.
2. Book Index를 얇은 탐색 지도로 유지한다.
3. Chunk가 원문 위치와 품질 상태를 갖도록 한다.
4. 답변 시 index만 보고 결론을 내리지 않도록 retrieval 안전장치를 둔다.

## 범위

이번 설계에 포함한다.

- `20_Sources/books/raw/` 원본 보관 흐름
- Book Index Template 규격
- Chunk Boundary Policy
- OCR 품질과 chunk 품질 상태값
- Retrieval Safety Rule
- `obsidian-capture`, `obsidian-retrieve`, 템플릿, 검증 스크립트에 반영할 요구사항

이번 설계에서 제외한다.

- PDF 자동 파싱과 자동 OCR 실행 스크립트
- 완전 자동 장/절 분할 엔진
- 벡터 DB, 임베딩 검색, 외부 검색 인덱스
- 책 전체 자동 지식 그래프 생성
- 대량 batch importer UI

## 핵심 원칙

Book Index는 답변 근거가 아니다. Book Index는 관련 chunk와 원본 위치로 이동하기 위한 routing note다.

답변 근거는 다음 중 하나에서 나와야 한다.

- Chapter 또는 Section Source
- 짧은 OCR excerpt와 page/chapter/heading anchor
- Source로 되돌아가는 Concept, Claim, Question, Insight
- review가 완료되었거나 OCR 품질이 충분한 chunk

근거가 Book Index에만 있으면 답변은 제한되어야 한다.

## 아키텍처

OCR 책 capture는 네 계층으로 처리한다.

### Raw Layer

경로: `20_Sources/books/raw/`

역할:

- OCR PDF, 스캔 PDF, OCR text export, 원본 파일을 보관한다.
- 원본 파일은 수정하지 않는다.
- Source note는 이 원본 파일을 `Original` 섹션에서 가리킨다.

### Navigation Layer

경로: `20_Sources/books/<book>.md`

역할:

- 책 전체의 Book Index다.
- 목차, 원본 파일, OCR 품질, chunk 링크, 처리 상태를 담는다.
- 장문 요약이나 강한 결론을 담지 않는다.

### Evidence Layer

경로 예시:

```text
20_Sources/books/2026-05-17-book-title-ch01.md
20_Sources/books/2026-05-17-book-title-ch01-section-02.md
```

역할:

- 장, 절, heading, page range, claim 단위 Source다.
- 요약, 핵심 주장, 위치 메모, 짧은 근거 발췌, OCR 품질 상태를 담는다.
- Compile 후보를 제공한다.

### Knowledge Layer

경로:

```text
30_Objects/concepts/
30_Objects/claims/
30_Objects/questions/
30_Objects/insights/
40_Maps/topic-maps/
```

역할:

- 책에서 나온 개념, 주장, 질문, 인사이트를 기존 지식 구조와 연결한다.
- Source 위치 링크가 없으면 confidence를 높이지 않는다.

## Book Index Template

Book Index는 다음 섹션을 가진다.

```markdown
## Original

- Title:
- Author:
- Edition:
- Raw PDF:
- OCR Text:
- Language:

## Quality Gate

- OCR quality: low | medium | high
- Page boundary confidence: low | medium | high
- Missing pages: unknown | no | yes
- Review status: captured | needs_ocr_review

## Table of Contents

- Chapter or section outline

## Chunking Plan

- chunking_strategy: toc | heading | page_range | semantic | manual
- chunk_unit: chapter | section | claim | page_range
- chunk_quality: good | uneven | too_large | uncertain
- rechunk_candidates: []

## Chunk Index

- [[book-title-ch01]] - status
- [[book-title-ch02]] - status

## Topic Candidates

- Related maps:
- Concepts:
- Questions:

## Processing Notes

- status: raw_only | indexed | chunked | compiled | needs_ocr_review | needs_rechunk
- next_step:
```

### Index에 넣는 것

- 책 제목, 저자, 판본, 언어
- 원본 파일 링크
- OCR 품질과 page boundary 신뢰도
- 목차 또는 추정 목차
- chunk Source 링크
- 처리 상태
- 주제 후보와 관련 Map 후보

### Index에 넣지 않는 것

- 장문의 전체 책 요약
- 검증되지 않은 강한 결론
- 원문 위치가 없는 Claim 또는 Insight
- 책의 모든 세부 주장
- 긴 OCR 원문
- 내 해석과 저자 주장을 섞은 문장

## Chunk Boundary Policy

Index 규칙만으로는 청킹 품질을 보장할 수 없다. 별도의 chunk 경계 규칙을 둔다.

### 분할 우선순위

1. 책의 명시적 목차를 따른다.
2. 목차가 없거나 OCR로 깨졌으면 heading을 따른다.
3. heading이 불안정하면 page range를 사용한다.
4. 한 chunk에 여러 핵심 주장이 섞이면 semantic 또는 claim 단위로 재분할한다.
5. 사람이 판단해야 하는 경우 `manual` 전략과 `needs_rechunk` 상태를 남긴다.

### Chunk 품질 기준

좋은 chunk:

- 하나의 장, 절, 논점, 또는 주장 단위로 읽힌다.
- page/chapter/heading anchor를 가진다.
- 요약과 핵심 주장, 위치 메모가 분리되어 있다.
- OCR 품질 상태가 명시되어 있다.

나쁜 chunk:

- 너무 길어서 질문마다 많은 텍스트를 다시 읽어야 한다.
- 여러 주제가 섞여 있다.
- page나 heading 위치가 없다.
- OCR 오류가 많은데 confidence가 높다.
- 요약이 저자 주장과 내 해석을 섞는다.

### 상태값

- `chunk_quality: good`: 현재 단위로 검색과 참조에 적합하다.
- `chunk_quality: uneven`: 일부 경계가 애매하다.
- `chunk_quality: too_large`: 재분할이 필요하다.
- `chunk_quality: uncertain`: OCR이나 구조 문제로 판단이 어렵다.
- `status: needs_rechunk`: 재분할 후보로 남긴다.

## Retrieval Safety Rule

질문 답변 시 Book Index는 route만 제공한다. 실제 답변 근거는 Chunk Source와 원문 위치에서 확인해야 한다.

### Retrieval 경로

```text
Question
  -> Map/Object
  -> Book Index
  -> Chunk Source
  -> Raw location
  -> Answer
```

### 허용되는 근거

- Chunk Source의 `Summary`, `Key Points`, `Location Notes`
- page/chapter/heading anchor가 있는 짧은 excerpt
- Source로 되돌아가는 Concept, Claim, Question, Insight
- OCR quality가 medium 이상이거나 review가 완료된 chunk

### 제한되는 근거

- Book Index의 주제 후보만 보고 내린 결론
- 원문 위치가 없는 Claim 또는 Insight
- `needs_ocr_review` 상태의 chunk를 강한 근거처럼 사용하는 것
- `chunk_quality: too_large`인 chunk를 세부 답변 근거로 사용하는 것

### Retrieval 상태 필드

```yaml
retrieval_ready: yes | partial | no
evidence_level: source_verified | index_only | weak_ocr | needs_review
answer_scope: book | chapter | section | claim
```

### 답변 출력 규칙

- 근거가 충분하면 답변, Source 링크, confidence를 함께 표시한다.
- Book Index만 있고 chunk가 없으면 index 단계라고 밝히고 결론을 제한한다.
- OCR 품질이 낮으면 낮은 신뢰도를 명시한다.
- 관련 chunk가 너무 크면 먼저 rechunk 또는 좁은 범위 질문을 제안한다.
- 상충되는 chunk가 있으면 결론보다 차이와 추가 검토 질문을 우선 표시한다.

## 스킬별 반영 요구사항

### obsidian-capture

`obsidian-capture`는 OCR 책 입력을 받을 때 다음을 보장해야 한다.

- OCR PDF 원본을 `20_Sources/books/raw/`에 두도록 안내한다.
- Book Index를 장문 요약으로 만들지 않는다.
- Book Index에 `chunking_strategy`, `chunk_quality`, `retrieval_ready`를 남긴다.
- Chunk Source가 없으면 `retrieval_ready: partial` 또는 `no`로 둔다.
- OCR 품질이 낮거나 page boundary가 불확실하면 `needs_ocr_review`를 남긴다.
- 너무 큰 chunk는 `needs_rechunk`로 표시한다.

### obsidian-compile

`obsidian-compile`은 OCR 책 Source를 객체화할 때 다음을 지켜야 한다.

- Source 위치 링크가 없는 Claim 또는 Insight를 높은 confidence로 만들지 않는다.
- Book Index의 주제 후보만으로 Concept, Claim, Insight를 만들지 않는다.
- Chapter/Section Source를 확인한 뒤 객체를 생성하거나 갱신한다.
- 약한 근거는 Question이나 low confidence Claim으로 남긴다.

### obsidian-retrieve

`obsidian-retrieve`는 책 기반 답변을 만들 때 다음을 지켜야 한다.

- Book Index는 후보 탐색에만 사용한다.
- Chunk Source 또는 원문 위치 확인 없이 단정하지 않는다.
- `evidence_level`과 confidence를 답변에 드러낸다.
- `index_only`, `weak_ocr`, `needs_review` 상태에서는 제한 답변을 한다.

### obsidian-lint

`obsidian-lint`는 다음 문제를 찾아야 한다.

- Book Index가 장문 요약처럼 비대해진 경우
- `retrieval_ready: yes`인데 chunk 링크가 없는 경우
- `chunk_quality: too_large`인데 compile된 객체가 많은 경우
- 원문 위치 없는 Claim 또는 Insight
- `needs_ocr_review`가 오래 방치된 경우

## 검증 기준

레포 검증은 다음을 확인해야 한다.

- `vault-template/20_Sources/books/raw/`가 존재한다.
- Book OCR 템플릿에 `chunking_strategy`, `chunk_quality`, `retrieval_ready`가 있다.
- Workflow 문서에 `needs_rechunk`, `index_only`, `weak_ocr`가 있다.
- `obsidian-capture` 문서에 Book Index가 답변 근거가 아니라 routing note라는 원칙이 있다.
- `verify-vault.sh`가 `20_Sources/books/raw`를 요구한다.

## 성공 기준

이 설계가 구현되면 다음이 가능해야 한다.

1. 사용자가 OCR PDF를 `20_Sources/books/raw/`에 넣고 capture 요청을 한다.
2. capture 결과는 Book Index와 chunk 계획을 만든다.
3. Book Index는 장문 요약이 아니라 탐색 지도 역할을 한다.
4. 청킹이 불완전하면 `needs_rechunk` 또는 `needs_ocr_review`가 남는다.
5. retrieve는 index만 보고 답하지 않고 chunk와 원문 위치를 확인한다.
6. 근거가 약한 경우 답변에 낮은 confidence와 추가 검토 필요를 표시한다.

## 구현 순서 제안

1. Book OCR 템플릿에 Index/Chunk/Retrieval 필드를 추가한다.
2. `book-ocr-workflow.md`에 Chunk Boundary Policy와 Retrieval Safety Rule을 추가한다.
3. `obsidian-capture` 본문에 OCR 책 품질 게이트를 반영한다.
4. `obsidian-retrieve`에 책 기반 답변 안전 규칙을 추가한다.
5. `obsidian-lint`에 OCR 책 품질 점검 항목을 추가한다.
6. 검증 스크립트에 핵심 문구와 디렉토리 확인을 추가한다.

이 순서는 자동 PDF 파싱을 만들기 전에 지식베이스 품질 기준을 먼저 세우기 위한 것이다.
