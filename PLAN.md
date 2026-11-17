# Cue — PLAN

The full plan (product outline, decisions, roadmap) lives in the
"Executive-Function Assistant — Product Plan & Roadmap" doc. This file is the
in-repo checklist: updated at the end of every work session.

## Current milestone: Phase 0 · Setup (Nov 16–22, 2026)

- [x] Key decisions made (iPhone, Swift + SwiftUI, on-phone data, model adapter for AI, one repo, shifts in calendar, name: Cue; App Store name "Cue | Doxle", home-screen label "Cue")
- [x] GitHub repo created (slpcc63/cue)
- [x] Swift package with the domain layer (Belief, Confidence, Unknown) and tests
- [x] PLAN.md, NEVER-DO.md and .compass files in repo
- [x] Claude Code installed on Shannon's Mac, working in this repo
- [x] `swift test` passes on the Mac (first compile of this code)
- [x] iPhone app target created (bundle ID `com.slpcc63.cue`), placeholder "Next" card
- [x] TestFlight script adapted from Prism's (`Scripts/archive-testflight.sh`, `Docs/TestFlight.md`)
- [x] App record in App Store Connect, renamed "Cue | Doxle" on 2026-11-16 (Shannon, in the web UI)
- [x] Build 0.0.1 (1) uploaded via the TestFlight script (2026-11-14, from `1ac5790`)
- [x] Build 0.0.1 (1) processed and added to Owner Testing in App Store Connect > TestFlight
- [ ] Approved app icon installed: `assets/cue/cue-guiding-ribbon-v1.png` from the Branding folder (1254×1254 opaque RGB; scale to 1024×1024, no alpha, no rounded corners); home-screen label "Cue"
- [x] Cue opens on Shannon's iPhone from TestFlight (build 1, placeholder icon; confirmed by Shannon 2026-11-16)

## Then: Prism P1 · Reminders (Nov 23–29) and P2 · V0 hardening (Nov 30–Dec 6)

One milestone at a time across both apps; Prism's V0 finishes first. See the Prism tab in the plan doc.

## Next for Cue: M1 · "You have to leave in 18 minutes" (Dec 7–20)

- Calendar reading (EventKit)
- Saved places with a fixed commute time (Shannon walks/bikes 6–8 blocks; no live traffic)
- Prep buffer
- Decision engine skeleton: all 8 pipeline steps, one action (Leave)
- One-thing home card + Why?
- Notification when it's time to start getting ready

Done when (Shannon ticks these on her phone):
- [ ] For 5 real shifts, leave time within 5 minutes of what she'd have chosen
- [ ] Why? shows the event, commute time and buffer
- [ ] Notification arrives with the phone locked

## Daybreak as a parts bin

Decided 2026-11-14: Cue is a fresh start, not a continuation of Daybreak/AWA
([slpcc63/adaptive-workday-assistant](https://github.com/slpcc63/adaptive-workday-assistant)).
Daybreak's `Sources/WorkdayCore` holds decision logic that was tested on Shannon's
iPhone in September. Port a piece only when the current milestone needs it, with its
tests, adapted to Cue's layers:

| Cue milestone | Daybreak source to reuse |
| --- | --- |
| M1 Leave time | `CalendarPipeline.swift`, `AlertReconciliation.swift` (departure math, stable alert identities) |
| M2 Getting ready | `PreparationPlan.swift`, `ShiftAttentionPlan.swift` (routines, per-shift states) |
| M3 Real durations | `RecoveryAndActivity.swift` (p80 duration history, Can I Start?) |
| M4 Running Late | `RecoveryAndActivity.swift` (critical → important → optional fit) |

Never copy Daybreak's app layer or UI wholesale; never change Daybreak's repo.

## Architecture

Same layering as Prism (slpcc63/pulse): Features (SwiftUI) → Services → Domain,
with Persistence behind repository interfaces. Time and notifications are
injected so the engine is testable. The Domain layer imports Foundation only.
Every belief records its source, so Prism can plug in later as a source.

## Rules of the road

1. One milestone at a time; scope freezes the day it starts.
2. New ideas go to the Parking lot in the plan doc; reviewed only at a gate.
3. Design just in time: ≤1 hour before each milestone.
4. Done = ticked on Shannon's phone, not "code written".
5. 50% over the time box → cut scope, don't extend.
6. Branches: `main` + one `m<N>` branch per milestone, merged when done, then tagged.
7. Every session ends with a handoff and this file updated.

## Session log

- 2026-11-14: Phase 0 started with an Expo skeleton.
- 2026-11-14: Switched to Swift + SwiftUI to match Prism. Expo files removed;
  domain package added. This code has not been compiled yet: the first `swift test`
  runs on the Mac.
- 2026-11-14: Prism's V0 milestones scheduled before Cue M1; Cue dates moved back two weeks (M1 Dec 7–20, Gate B ends Apr 25).
- 2026-11-14: First compile on the Mac: `swift test` passes (5 tests, 3 suites) with
  Xcode 26.6's toolchain (`DEVELOPER_DIR`, since `xcode-select` points at Command
  Line Tools). Added `.swift-format` (4-space indent) and fixed lint. Added the iPhone
  app target (`Cue.xcodeproj`, `Cue/App`) with the placeholder Next card and a
  placeholder icon; Debug simulator and unsigned Release device builds succeed, and
  the card renders in the iOS 26.5 simulator. Adapted Prism's TestFlight script.
  Remaining for Phase 0: App Store Connect record, first upload, install on iPhone.
  Committed and pushed as `75768fd`.
- 2026-11-14: App Store Connect record created by Shannon. Build 0.0.1 (1) archived
  from `1ac5790` and uploaded to TestFlight (upload succeeded, processing). Build
  number raised to 2 on `main`.

- 2026-11-16: Build 0.0.1 (1) processed and added to Owner Testing; Shannon
  installed it from TestFlight and it opens on her iPhone. Phase 0's only open
  item is the approved app icon.

## Handoff — where we left off (2026-11-16)

State: build **0.0.1 (1)** (placeholder icon) is in TestFlight Owner Testing and
runs on Shannon's iPhone. `main` has the build number set to **2** — never upload
build 1 again.

Next steps, in order:
1. Install the approved icon `assets/cue/cue-guiding-ribbon-v1.png` (read the
   branding files listed in CLAUDE.md first): scale to 1024×1024, opaque, no
   rounded corners; home-screen label stays "Cue".
2. Commit, upload build 2 with a new output path, e.g.
   `/private/tmp/cue-testflight-0.0.1-2-upload` (see `Docs/TestFlight.md`).
   Shannon adds it to Owner Testing, installs it and ticks the icon item. That
   closes Phase 0.
3. Then Prism P1 · Reminders (Nov 23–29), per the plan above.

Notes for the next session:
- Always prefix `swift test` / `xcodebuild` / the TestFlight script with
  `DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer` (or run
  `sudo xcode-select -s /Applications/Xcode.app` once).
- 2026-11-16: Store name changed to "Cue | Doxle". CLAUDE.md branding rule added (approved by Shannon). Icon install added to Phase 0.
