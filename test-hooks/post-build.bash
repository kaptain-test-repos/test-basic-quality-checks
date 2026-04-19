#!/usr/bin/env bash
set -euo pipefail
# Hook: postBuild
# Validates environment at the end of the build pipeline

errors=0
assert_set() { if [[ -z "${!1:-}" ]]; then echo "FAIL: $1 should be set" >&2; ((errors++)); fi; }

# Basic context should still be available
assert_set REPOSITORY_NAME
assert_set CURRENT_BRANCH
assert_set DEFAULT_BRANCH

if [[ "$errors" -gt 0 ]]; then echo "FAILED: $errors assertion(s) in postBuild" >&2; exit 1; fi
echo "PASSED: postBuild validation"
