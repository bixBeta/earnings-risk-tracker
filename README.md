# Earnings Risk Tracker

A 45 DTE earnings risk dashboard for TQQQ / QQQ / TSLL options. Hosted as a static page on GitHub Pages and refreshed weekly by a Claude scheduled task.

**Live:** https://bixBeta.github.io/earnings-risk-tracker/

## How it stays up to date

```
┌──────────────────────────┐    writes index.html    ┌────────────────────┐
│  Cowork scheduled task   │ ──────────────────────▶ │  this repo (host)  │
│  Sun 8am ET, weekly      │                          └─────────┬──────────┘
│  (refreshes dates via    │                                    │ launchd WatchPaths
│   WebSearch + updates    │                                    ▼
│   the Cowork artifact)   │                          ┌────────────────────┐
└──────────────────────────┘                          │  publish.sh        │
                                                      │  git commit + push │
                                                      └─────────┬──────────┘
                                                                ▼
                                                      ┌────────────────────┐
                                                      │  GitHub Pages      │
                                                      └────────────────────┘
```

The Cowork sandbox can't run git directly, so the host launchd agent does the
commit+push using the user's existing SSH/git config.

## Files

| File | Purpose |
|------|---------|
| `index.html`           | The dashboard itself (single self-contained file). |
| `manifest.webmanifest` | PWA manifest — enables iPhone "Add to Home Screen" install. |
| `icon-{180,192,512}.png` | App icons. |
| `publish.sh`           | Host-side launchd-triggered git push. |
| `com.earnings-risk-tracker.publish.plist` | launchd agent definition. |
| `setup.sh`             | One-time host setup. |

## On the iPhone

1. Open `https://bixBeta.github.io/earnings-risk-tracker/` in Safari.
2. Tap Share → **Add to Home Screen**.
3. The dashboard installs as a standalone app — no Safari chrome.

## Manual republish

If you edit something locally and want to publish without waiting for launchd:

```bash
bash publish.sh
```

## Disabling the auto-publish

```bash
launchctl bootout gui/$(id -u)/com.earnings-risk-tracker.publish
rm ~/Library/LaunchAgents/com.earnings-risk-tracker.publish.plist
```
