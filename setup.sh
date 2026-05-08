#!/usr/bin/env bash
# setup.sh — one-time host-side setup for the auto-publish pipeline.
# Run from your Mac terminal:
#     cd ~/Projects/earnings-risk-tracker && bash setup.sh

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

PLIST_NAME="com.earnings-risk-tracker.publish.plist"
PLIST_SRC="$REPO_DIR/$PLIST_NAME"
PLIST_DST="$HOME/Library/LaunchAgents/$PLIST_NAME"

echo "==> 1/4 Initial commit (if needed)"
# Clean up any leftover artifacts the Cowork sandbox couldn't delete itself.
# (sandbox mount denies unlink, so stale lockfiles/tmp objects can accumulate)
rm -f test_rm .git/test_can_create .git/index.lock
find .git/objects -name 'tmp_obj_*' -delete 2>/dev/null || true
git add -A
if ! git diff --cached --quiet; then
  git commit -m "feat: dashboard, PWA assets, publish pipeline" --quiet
  git push origin HEAD:main
  echo "    pushed initial state"
else
  echo "    nothing to commit"
fi

echo "==> 2/4 Verify GitHub Pages config"
if command -v gh >/dev/null 2>&1; then
  gh api -X GET "repos/bixBeta/earnings-risk-tracker/pages" 2>/dev/null \
    | grep -E '"html_url"|"status"' || echo "    (Pages may still be initializing — first build takes ~1 min)"
else
  echo "    gh CLI not found — verify manually at:"
  echo "    https://github.com/bixBeta/earnings-risk-tracker/settings/pages"
fi

echo "==> 3/4 Install launchd agent"
mkdir -p "$HOME/Library/LaunchAgents"
cp "$PLIST_SRC" "$PLIST_DST"
# Bootout if already loaded, then bootstrap fresh
launchctl bootout "gui/$(id -u)/com.earnings-risk-tracker.publish" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$PLIST_DST"
echo "    agent loaded — will auto-push on every index.html change"

echo "==> 4/4 Done"
echo
echo "Live URL (allow 1–2 min for first deploy):"
echo "    https://bixBeta.github.io/earnings-risk-tracker/"
echo
echo "Logs:"
echo "    tail -f /tmp/earnings-risk-tracker.publish.log"
echo "    tail -f /tmp/earnings-risk-tracker.publish.err.log"
echo
echo "To uninstall later:"
echo "    launchctl bootout gui/\$(id -u)/com.earnings-risk-tracker.publish"
echo "    rm $PLIST_DST"
