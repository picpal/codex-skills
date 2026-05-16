# 설치 가이드

이 문서는 다른 사용자가 이 레포를 받아 Codex에서 Obsidian 제2의 뇌 스킬팩을 쓰기 위한 안내입니다.

## 전제 조건

- Git
- Bash
- Obsidian
- Codex Desktop 또는 Codex CLI
- 스킬을 설치할 로컬 Codex 홈 디렉토리: 기본값 `~/.codex`

## 1. 레포 받기

원하는 작업 폴더에서 레포를 받습니다.

```bash
git clone <repo-url> obsidian-second-brain-skills
cd obsidian-second-brain-skills
```

레포 자체가 정상인지 먼저 확인합니다.

```bash
./tools/verify-second-brain-skills.sh
```

성공 시 출력:

```text
Second brain skill pack verification passed.
```

## 2. Codex에 스킬 설치

다음 스크립트는 `obsidian-*` 스킬들과 지원 폴더인 `shared/`, `tools/`, `vault-template/`을 `~/.codex/skills`에 심볼릭 링크로 연결합니다.

```bash
./tools/install-codex-skills.sh
```

설치 위치를 바꾸고 싶다면 `CODEX_HOME`을 지정합니다.

```bash
CODEX_HOME=/path/to/codex-home ./tools/install-codex-skills.sh
```

설치 후 새 Codex 세션을 열면 다음 스킬을 사용할 수 있습니다.

- `obsidian-init`
- `obsidian-capture`
- `obsidian-compile`
- `obsidian-retrieve`
- `obsidian-lint`

## 3. Obsidian Vault 초기화

실제 Vault를 준비합니다.

```bash
./tools/init-second-brain-vault.sh /path/to/obsidian-vault
./tools/verify-vault.sh /path/to/obsidian-vault
```

레포 밖에서 실행한다면 설치된 지원 스크립트를 직접 호출할 수 있습니다.

```bash
~/.codex/skills/tools/init-second-brain-vault.sh /path/to/obsidian-vault
~/.codex/skills/tools/verify-vault.sh /path/to/obsidian-vault
```

초기화는 비파괴 방식입니다. 기존 노트는 덮어쓰지 않고, 빠진 폴더와 템플릿만 채웁니다.

성공 시 출력:

```text
Obsidian second brain vault verification passed.
```

## 4. 사용 예시

Codex에서 다음처럼 요청할 수 있습니다.

```text
obsidian-init으로 내 Vault 연결 상태를 확인해줘.
```

```text
obsidian-capture로 오늘 떠오른 아이디어를 Vault에 저장해줘.
```

```text
obsidian-compile로 최근 capture 노트를 기존 개념과 연결해줘.
```

## 확장 가능한 구조인가?

가능합니다. 이 레포는 새 Codex 스킬을 추가하기 쉬운 구조입니다.

```text
obsidian-new-skill/
  SKILL.md
  references/

shared/obsidian-second-brain/
  references/
  templates/

tools/
vault-template/
```

새 스킬을 추가할 때의 규칙:

- 새 스킬은 repo root 아래 `obsidian-<name>/SKILL.md` 형태로 둡니다.
- 여러 스킬이 함께 쓰는 지식은 `shared/obsidian-second-brain/`에 둡니다.
- 반복 실행 가능한 작업은 `tools/`에 스크립트로 둡니다. 이 폴더는 Codex 설치 시 함께 연결됩니다.
- Vault 안에 들어갈 기본 구조나 템플릿은 `vault-template/`에 둡니다.
- 새 스킬을 추가하면 `tools/verify-second-brain-skills.sh`에도 필수 파일 검증을 추가합니다.

이 구조의 장점은 스킬이 서로 독립적으로 호출되면서도 같은 Vault 구조, 노트 타입, 템플릿, 신뢰성 규칙을 공유한다는 점입니다. 그래서 나중에 `obsidian-project`, `obsidian-decision`, `obsidian-research`, `obsidian-synthesis` 같은 스킬을 추가해도 기존 기억 구조와 충돌하지 않고 확장할 수 있습니다.

## 문제 해결

`~/.codex/skills`에 같은 이름의 폴더가 이미 있으면 설치 스크립트는 덮어쓰지 않고 멈춥니다. 기존 스킬을 백업하거나 삭제한 뒤 다시 실행하세요.

Vault 검증이 실패하면 누락된 파일이나 폴더 목록을 확인한 뒤 초기화 스크립트를 다시 실행하세요.
