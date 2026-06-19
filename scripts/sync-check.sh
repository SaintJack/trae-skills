#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

PROJECT_PATH="${1:-}"

if [[ -z "${PROJECT_PATH}" ]]; then
  echo "Usage: bash scripts/sync-check.sh /path/to/project" >&2
  exit 1
fi

SKILL_SRC="${REPO_ROOT}/skills/engineering-gate/SKILL.md"
RULE_SRC="${REPO_ROOT}/rules/project/engineering-gate.md"
SKILL_DST="${PROJECT_PATH}/.agents/skills/engineering-gate/SKILL.md"
RULE_DST="${PROJECT_PATH}/.trae/rules/engineering-gate.md"

check_file() {
  local src="$1"
  local dst="$2"
  local label="$3"

  if [[ ! -f "${dst}" ]]; then
    echo "[MISSING] ${label}: ${dst}"
    return 0
  fi

  if cmp -s "${src}" "${dst}"; then
    echo "[OK] ${label} is in sync"
  else
    echo "[DIFF] ${label} differs from repository source"
    diff -u "${src}" "${dst}" || true
  fi
}

check_file "${SKILL_SRC}" "${SKILL_DST}" "Skill"
check_file "${RULE_SRC}" "${RULE_DST}" "Project rule"
