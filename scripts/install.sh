#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

PROJECT_PATH=""
MODE="copy"

usage() {
  cat <<'EOF'
Usage:
  bash scripts/install.sh --project /path/to/project [--mode copy|link]

Behavior:
  - Installs the engineering-gate skill into:
      <project>/.agents/skills/engineering-gate/SKILL.md
  - Installs the project rule into:
      <project>/.trae/rules/engineering-gate.md
  - Reminds you to paste the global user rule into Trae > Settings > Rules > User Rules
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project)
      PROJECT_PATH="${2:-}"
      shift 2
      ;;
    --mode)
      MODE="${2:-copy}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ -z "${PROJECT_PATH}" ]]; then
  echo "Error: --project is required." >&2
  usage
  exit 1
fi

if [[ ! -d "${PROJECT_PATH}" ]]; then
  echo "Error: project path does not exist: ${PROJECT_PATH}" >&2
  exit 1
fi

SKILL_SRC="${REPO_ROOT}/skills/engineering-gate/SKILL.md"
RULE_SRC="${REPO_ROOT}/rules/project/engineering-gate.md"
USER_RULE_SRC="${REPO_ROOT}/rules/user/engineering-gate-global.md"

SKILL_DST_DIR="${PROJECT_PATH}/.agents/skills/engineering-gate"
RULE_DST_DIR="${PROJECT_PATH}/.trae/rules"
SKILL_DST="${SKILL_DST_DIR}/SKILL.md"
RULE_DST="${RULE_DST_DIR}/engineering-gate.md"

mkdir -p "${SKILL_DST_DIR}" "${RULE_DST_DIR}"

if [[ "${MODE}" == "link" ]]; then
  ln -sf "${SKILL_SRC}" "${SKILL_DST}"
  ln -sf "${RULE_SRC}" "${RULE_DST}"
else
  cp "${SKILL_SRC}" "${SKILL_DST}"
  cp "${RULE_SRC}" "${RULE_DST}"
fi

echo "Installed engineering gate into project:"
echo "  Skill: ${SKILL_DST}"
echo "  Rule : ${RULE_DST}"
echo
echo "Next step:"
echo "  Copy the content of the following file into Trae > Settings > Rules > User Rules"
echo "  ${USER_RULE_SRC}"
