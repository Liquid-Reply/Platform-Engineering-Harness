#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

failures=0

pass() {
  printf 'ok - %s\n' "$1"
}

fail() {
  printf 'not ok - %s\n' "$1" >&2
  failures=$((failures + 1))
}

required_files=(
  AGENTS.md
  docs/architecture.md
  docs/getting-started.md
  adapters/kubernetes/contract.md
  recipes/platform-engineering/recipe.yaml
  scenarios/README.md
  scenarios/kubernetes-secure-service/rubric.yaml
)

for file in "${required_files[@]}"; do
  if [[ -s "$file" ]]; then
    pass "$file exists"
  else
    fail "$file is missing or empty"
  fi
done

skill_count=$(find .agents/skills -mindepth 2 -maxdepth 2 -name SKILL.md -type f | wc -l | tr -d ' ')
if [[ "$skill_count" -ge 5 ]]; then
  pass "at least five skills exist ($skill_count found)"
else
  fail "at least five skills must exist ($skill_count found)"
fi

for skill in .agents/skills/*/SKILL.md; do
  name=$(sed -n 's/^name:[[:space:]]*//p' "$skill" | head -n 1)
  description=$(sed -n 's/^description:[[:space:]]*//p' "$skill" | head -n 1)
  if [[ -n "$name" && -n "$description" ]]; then
    pass "$skill has name and description"
  else
    fail "$skill must have name and description frontmatter"
  fi
done

if command -v ruby >/dev/null 2>&1; then
  if ruby -e 'require "yaml"; ARGV.each { |file| YAML.load_file(file) }' \
    recipes/platform-engineering/recipe.yaml \
    scenarios/kubernetes-secure-service/rubric.yaml; then
    pass "YAML files parse"
  else
    fail "YAML files parse"
  fi
else
  printf 'skip - ruby unavailable; YAML parse not checked\n'
fi

if command -v goose >/dev/null 2>&1; then
  if goose recipe validate recipes/platform-engineering/recipe.yaml; then
    pass "Goose recipe validates"
  else
    fail "Goose recipe validates"
  fi
else
  printf 'skip - goose unavailable; recipe schema not checked\n'
fi

if [[ "$failures" -ne 0 ]]; then
  printf '%s\n' "$failures validation check(s) failed" >&2
  exit 1
fi

printf 'All available validation checks passed.\n'
