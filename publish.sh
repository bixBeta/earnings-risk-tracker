#!/usr/bin/env bash
# publish.sh — runs on the host (NOT inside Cowork's sandbox).
# Triggered by the launchd WatchPaths agent when index.html changes.
# Uses your existing SSH / git config; no PAT required.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

# Make sure $PATH has git and gh on it (launchd has a minimal PATH)
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

# Settle: launchd may fire on partial writes — give the writer a beat.
sleep 2

git add -A
if git diff --cached --quiet; then
  echo "$(date -u +%FT%TZ) no changes"
  exit 0
fi

STAMP="$(date -u +%FT%TZ)"
git -c user.email="auto@earnings-tracker.local" \
    -c user.name="Earnings Tracker Auto" \
    commit -m "auto: refresh dashboard ${STAMP}" \
    --quiet

# Push using whatever the remote is set to (SSH works fine when run from host).
git push origin HEAD:main --quiet
echo "$(date -u +%FT%TZ) pushed"
