# Obsidian 제2의 뇌 Pack

이 pack은 Obsidian Vault를 제2의 뇌처럼 운용하기 위한 스킬, 공통 레퍼런스, 템플릿, 실행 도구를 묶습니다.

## 구성

- `skills/`: Codex가 직접 호출하는 Obsidian 관련 스킬.
- `shared/obsidian-second-brain/`: 이 pack 내부 스킬들이 공유하는 노트 타입, 워크플로우, 신뢰성 규칙, 템플릿.
- `tools/`: Vault 초기화와 pack 검증 스크립트.
- `vault-template/`: 실제 Obsidian Vault에 복사되는 초기 구조.

## 포함 스킬

- `obsidian-init`
- `obsidian-capture`
- `obsidian-compile`
- `obsidian-retrieve`
- `obsidian-lint`

## Vault 초기화

```bash
packs/obsidian-second-brain/tools/init-second-brain-vault.sh /path/to/obsidian-vault
packs/obsidian-second-brain/tools/verify-vault.sh /path/to/obsidian-vault
```

## Pack 검증

```bash
packs/obsidian-second-brain/tools/verify-second-brain-skills.sh
```

성공 시 출력:

```text
Second brain skill pack verification passed.
```
