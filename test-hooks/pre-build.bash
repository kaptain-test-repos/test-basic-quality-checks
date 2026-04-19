#!/usr/bin/env bash
set -euo pipefail
# Hook: preBuild
# Validates environment at the start of the build pipeline — before quality checks

errors=0
assert_set() { if [[ -z "${!1:-}" ]]; then echo "FAIL: $1 should be set" >&2; ((errors++)); fi; }
assert_not_set() { if [[ -n "${!1:-}" ]]; then echo "FAIL: $1 should NOT be set (got '${!1}')" >&2; ((errors++)); fi; }

# Basic context should be available
assert_set REPOSITORY_NAME
assert_set PROJECT_NAME
assert_set CURRENT_BRANCH
assert_set DEFAULT_BRANCH

# Version vars should NOT be set yet (this is pre-build)
assert_not_set VERSION
assert_not_set DOCKER_TAG
assert_not_set GIT_TAG

if [[ "$errors" -gt 0 ]]; then echo "FAILED: $errors assertion(s) in preBuild" >&2; exit 1; fi
echo "PASSED: preBuild validation"
