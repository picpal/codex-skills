# Codex 스킬 컬렉션

이 저장소는 여러 종류의 Codex 스킬과 스킬팩을 함께 관리하기 위한 컬렉션입니다.

Obsidian 제2의 뇌는 이 저장소의 한 pack일 뿐이며, 앞으로 GitHub, 글쓰기, 리서치, 의사결정, 자동화 같은 다른 스킬도 같은 구조 안에서 확장할 수 있습니다.

## 디렉토리 구조

- `skills/`: 특정 pack에 묶이지 않는 독립 스킬.
- `packs/`: 여러 스킬과 전용 자산을 함께 쓰는 스킬팩.
- `packs/obsidian-second-brain/`: Obsidian 제2의 뇌 pack.
- `tools/`: 레포 전체 설치와 검증 도구.
- `docs/`: 설계 문서와 작업 계획.

## 빠른 시작

설치와 Codex 연결 방법은 [INSTALL.ko.md](INSTALL.ko.md)를 참고하세요.

```bash
./tools/verify-skill-repo.sh
./tools/install-codex-skills.sh
```

Obsidian 제2의 뇌 Vault를 초기화하려면 pack 전용 도구를 사용합니다.

```bash
packs/obsidian-second-brain/tools/init-second-brain-vault.sh /path/to/obsidian-vault
packs/obsidian-second-brain/tools/verify-vault.sh /path/to/obsidian-vault
```

## 현재 포함된 Pack

### Obsidian Second Brain

경로: `packs/obsidian-second-brain/`

포함 스킬:

- `obsidian-init`
- `obsidian-capture`
- `obsidian-compile`
- `obsidian-retrieve`
- `obsidian-lint`

이 pack은 자유 입력, 원본 보존, 지식 재구성, 인사이트 생성, 프로젝트와 의사결정 연결을 목표로 합니다.

## 스킬 추가 규칙

독립 스킬은 다음처럼 추가합니다.

```text
skills/<skill-name>/
  SKILL.md
  references/
```

특정 시스템에 묶인 스킬 묶음은 pack으로 추가합니다.

```text
packs/<pack-name>/
  README.md
  skills/
    <skill-name>/
      SKILL.md
  shared/
  tools/
```

`shared/`, `tools/`, `vault-template/` 같은 자산은 루트 공용으로 두지 않고, 해당 pack에 종속된다면 pack 내부에 둡니다. 루트 `tools/`에는 레포 전체 설치/검증처럼 모든 스킬에 공통인 도구만 둡니다.

## 검증

레포 전체 검증:

```bash
./tools/verify-skill-repo.sh
```

성공 시 출력:

```text
Codex skill repository verification passed.
```
