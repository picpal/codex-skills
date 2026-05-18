# codex-skills 설치 가이드

이 문서는 다른 사용자가 `picpal/codex-skills` 레포를 받아 Codex에서 스킬 컬렉션을 쓰기 위한 안내입니다.

## 전제 조건

- Git
- Bash
- Codex Desktop 또는 Codex CLI
- 스킬을 설치할 로컬 Codex 홈 디렉토리: 기본값 `~/.codex`

Obsidian 제2의 뇌 pack을 사용할 경우 Obsidian도 필요합니다.

## 1. 레포 받기

원하는 작업 폴더에서 레포를 받습니다.

```bash
git clone https://github.com/picpal/codex-skills.git codex-skills
cd codex-skills
```

레포 전체가 정상인지 확인합니다.

```bash
./tools/verify-skill-repo.sh
```

성공 시 출력:

```text
Codex skill repository verification passed.
```

## 2. Codex에 스킬 설치

다음 스크립트는 `skills/*`의 독립 스킬과 `packs/*/skills/*`의 pack 스킬을 `~/.codex/skills`에 심볼릭 링크로 연결합니다.

```bash
./tools/install-codex-skills.sh
```

설치 위치를 바꾸고 싶다면 `CODEX_HOME`을 지정합니다.

```bash
CODEX_HOME=/path/to/codex-home ./tools/install-codex-skills.sh
```

pack 전용 지원 파일은 `~/.codex/skills/.packs/<pack-name>/` 아래에 연결됩니다.

## 3. Obsidian 제2의 뇌 Pack 사용

설치 후 새 Codex 세션을 열면 다음 스킬을 사용할 수 있습니다.

- `obsidian-init`
- `obsidian-capture`
- `obsidian-compile`
- `obsidian-retrieve`
- `obsidian-lint`

실제 Obsidian Vault를 준비하려면 레포 안에서 다음을 실행합니다.

```bash
packs/obsidian-second-brain/tools/init-second-brain-vault.sh /path/to/obsidian-vault
packs/obsidian-second-brain/tools/verify-vault.sh /path/to/obsidian-vault
```

레포 밖에서는 설치된 pack 지원 경로를 사용할 수 있습니다.

```bash
~/.codex/skills/.packs/obsidian-second-brain/tools/init-second-brain-vault.sh /path/to/obsidian-vault
~/.codex/skills/.packs/obsidian-second-brain/tools/verify-vault.sh /path/to/obsidian-vault
```

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

## 확장 규칙

독립 스킬:

```text
skills/<skill-name>/
  SKILL.md
  references/
```

스킬팩:

```text
packs/<pack-name>/
  README.md
  skills/
    <skill-name>/
      SKILL.md
  shared/
  tools/
```

새 스킬을 추가할 때의 규칙:

- 하나의 독립 기능이면 `skills/<skill-name>/`에 둡니다.
- 여러 스킬이 같은 도메인 모델, 템플릿, 도구를 공유하면 `packs/<pack-name>/`에 둡니다.
- pack 내부에서만 쓰는 자산은 pack 안의 `shared/`, `tools/`, `templates/`, `vault-template/`에 둡니다.
- 루트 `tools/`에는 레포 전체에 적용되는 설치/검증 도구만 둡니다.
- 새 pack을 추가하면 `tools/install-codex-skills.sh`가 자동으로 `packs/*/skills/*`를 설치합니다.
- 새 pack 검증 스크립트를 만들었다면 `tools/verify-skill-repo.sh`에서도 호출하도록 추가합니다.

## 문제 해결

`~/.codex/skills`에 같은 이름의 스킬 폴더가 이미 있으면 설치 스크립트는 덮어쓰지 않고 멈춥니다. 기존 스킬을 백업하거나 삭제한 뒤 다시 실행하세요.

Obsidian Vault 검증이 실패하면 누락된 파일이나 폴더 목록을 확인한 뒤 초기화 스크립트를 다시 실행하세요.
