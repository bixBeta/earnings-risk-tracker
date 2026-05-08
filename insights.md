# Insights — How to Read the Dashboard

A plain-English walkthrough of what the [Earnings Risk Tracker](https://bixbeta.github.io/earnings-risk-tracker/) shows, what the colors mean, and how to actually use it for 45 DTE options on TQQQ, QQQ, and TSLL.

## The Big Idea

When a company reports earnings, its stock can jump or crash 5–15% in a single after-hours session. Implied volatility (IV) — what options *cost* — also crashes the morning after ("IV crush"). Both of those are bad for someone who sold a 45-day option and is just sitting on it: the underlying could blow past your strikes, and the volatility move screws with how the position prices.

The dashboard's whole job is to answer one question:

> Before I open a 45-day contract today, are any of the companies I care about going to report earnings while I'm still holding it? If yes, how soon and how badly will that hit me?

For **TQQQ** and **QQQ** (Nasdaq-100 ETFs), the companies that move the index are the Mag 7: Apple, Microsoft, Nvidia, Amazon, Meta, Alphabet, Tesla. For **TSLL** (2x Tesla), only Tesla matters.

## What Each Section Shows

### "Open a contract today?" cards (top)

A quick verdict for each ticker.

- **Green ✅** means if you open a 45 DTE today, no earnings will happen during its life.
- **Yellow / orange / red** means earnings *will* happen during the contract's life, and the color tells you how bad that is.

The card also tells you the earliest date in the future when you could open and be in the clear.

### Entry calendar (middle)

Three horizontal strips, one per ticker. Each tiny cell is one calendar day going forward. The color of cell `N` tells you:

> *If you opened a 45 DTE on day N, here's what risk you'd inherit.*

The **black cell** is the actual earnings day itself. **Today** has a blue outline. Use this strip to spot the next clean entry window at a glance.

### Earnings on the radar (bottom)

The raw date list driving everything above. Each row says: *X reports on Y, in Z days*, with a badge for **In window** (would land inside a 45 DTE opened today) or **Outside** (safely beyond the window).

## What the Colors Mean (and Why)

The dashboard splits the 45-day life of a hypothetical contract into three zones, because earnings hurt differently depending on *when* in the contract they hit.

| Tier | Zone | What it means |
|---|---|---|
| 🟢 Green | No earnings in the 45-day window | Theta decay does its thing in peace. |
| 🟡 Yellow | Days 0–15 (early) | IV usually drops after the print, and you've got 30+ days left for the position to recover from any move. Annoying but survivable. |
| 🟠 Orange | Days 15–30 (mid) | Material risk. Depending on strikes, you're in real territory. |
| 🔴 Red | Days 30–45 (late, high gamma) | Gamma is highest near expiration. Small underlying moves cause huge P&L swings, and IV crush isn't your friend at this stage. Avoid. |

The DTE input at the top scales these zones proportionally — for a 30 DTE contract the early/mid/late cutoffs become days 10 and 20.

## How to Actually Use It

The dashboard is biased toward the **selling-premium** lens — cash-secured puts, credit spreads, covered calls, the typical 45 DTE play. For that lens:

- **Open today?** Green = go. Yellow = probably fine if your strikes are reasonable. Orange/red = wait for the next green window.
- **Best entry timing?** Look at the calendar strip and find the next stretch of green. The "earliest safe entry" line on each card tells you the exact date.
- **Already in a red position?** That's a separate question — typically you'd close before the earnings print or roll out, but that's a management call, not an entry call.

### Buying premium flips the interpretation

If instead you're **buying premium** as a directional bet — long calls or long puts — flip the read. Red weeks become opportunities (you *want* the volatility event), green weeks are deserts.

Same data, opposite conclusion.

## What It Can't Tell You

The dashboard answers one question well: **is there an earnings event in my contract window?**

It does **not** tell you:

- Whether to be bullish or bearish
- Whether IV is rich or cheap right now
- What strikes to pick or what spreads to size
- Whether the broader market is risk-on
- Anything macro (Fed, CPI, geopolitics)

Those are separate decisions. This is one input — the calendar input — done well so you don't get blindsided by an earnings date you forgot was coming.

## A Note on the Tickers

- **QQQ** is the standard Invesco Nasdaq-100 ETF. Big tech weighting → Mag 7 earnings dominate moves.
- **TQQQ** is ProShares 3x leveraged QQQ. Same earnings calendar matters, amplified 3×. Compounding decay also matters here, but that's a separate story.
- **TSLL** is Direxion 2x Tesla. Only TSLA earnings affect it; nothing else on the Mag 7 list applies.

## Disclaimer

This dashboard is a calendar-aware checklist, not a buy/sell signal, and the author of this tool is not a financial advisor. Earnings dates can shift; companies sometimes confirm dates only a few weeks out. Always verify before sizing into a position.
