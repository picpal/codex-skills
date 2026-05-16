# Obsidian 제2의 뇌 스킬팩

이 저장소는 Codex와 Claude Code가 Obsidian Vault를 제2의 뇌처럼 다루기 위한 스킬팩입니다.

핵심 원칙은 하나입니다.

> 자유롭게 입력하고, 원본을 보존하고, 지식을 재구성하고, 인사이트를 드러내며, 실행과 의사결정으로 연결한다.

## 구성

- `vault-template/`: Obsidian Vault 초기 디렉토리 구조.
- `shared/obsidian-second-brain/`: 공통 레퍼런스와 노트 템플릿.
- `obsidian-init/`: Vault 초기 세팅과 연결 상태 점검 스킬.
- `obsidian-capture/`: 생각, 링크, 세션, 자료를 마찰 없이 기록하는 스킬.
- `obsidian-compile/`: 원본 자료를 링크된 기억 구조로 재구성하는 스킬.
- `obsidian-retrieve/`: Vault 안의 근거를 따라 질문에 답하는 스킬.
- `obsidian-lint/`: 기억 구조의 건강 상태를 점검하고 리뷰 항목을 만드는 스킬.

## 흐름

1. Vault 구조를 초기화하거나 검증합니다.
2. 생각, 대화, 링크, 영상, 이미지, 웹페이지 같은 원자료를 자유롭게 기록합니다.
3. 원본과 메타데이터를 보존합니다.
4. 개념, 주장, 질문, 인사이트, 프로젝트, 의사결정 노트로 재구성합니다.
5. 맵과 출처 링크를 따라 근거 기반으로 조회합니다.
6. 오래된 주장, 약한 근거, 중복 노트, 누락된 링크를 점검합니다.

## Vault 초기화

실제 Obsidian Vault를 준비하려면 다음을 실행합니다.

```bash
./tools/init-second-brain-vault.sh /path/to/obsidian-vault
./tools/verify-vault.sh /path/to/obsidian-vault
```

초기화 스크립트는 비파괴 방식입니다. 빠진 폴더와 템플릿, 스키마, 대시보드만 생성하고 기존 파일은 덮어쓰지 않습니다.

Vault 검증 성공 시 출력:

```text
Obsidian second brain vault verification passed.
```

## 스킬팩 검증

스킬팩 자체가 필요한 파일과 구조를 갖추고 있는지 확인합니다.

```bash
./tools/verify-second-brain-skills.sh
```

검증 성공 시 출력:

```text
Second brain skill pack verification passed.
```
