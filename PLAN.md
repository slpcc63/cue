# Cue — PLAN

The full plan (product outline, decisions, roadmap) lives in the
"Executive-Function Assistant — Product Plan & Roadmap" doc. This file is the
in-repo checklist: updated at the end of every work session.

## Current milestone: Phase 0 · Setup (Nov 16–22, 2026)

- [x] Key decisions made (iPhone, Swift + SwiftUI, on-phone data, model adapter for AI, one repo, shifts in calendar, name: Cue)
- [x] GitHub repo created (slpcc63/cue)
- [x] Swift package with the domain layer (Belief, Confidence, Unknown) and tests
- [x] PLAN.md, NEVER-DO.md and .compass files in repo
- [ ] Claude Code installed on Shannon's Mac, working in this repo
- [ ] `swift test` passes on the Mac (first compile of this code)
- [ ] iPhone app target created (bundle ID `com.slpcc63.cue`), placeholder "Next" card
- [ ] App record "Cue by SLPCC63" in App Store Connect; build uploaded via a TestFlight script adapted from Prism's
- [ ] Cue opens on Shannon's iPhone from TestFlight

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
