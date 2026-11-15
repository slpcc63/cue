# Cue

An executive-function assistant for iPhone that answers one question:
"What should I be doing right now?" — with exactly one recommendation and a Why?.

Sibling app: [Prism](https://github.com/slpcc63/pulse) collects observations;
Cue decides what to do next. Prism can later become one of Cue's evidence sources.

- Plan and checklist: [PLAN.md](PLAN.md)
- Rules we don't break: [NEVER-DO.md](NEVER-DO.md)

## Layout

| Path | Contents |
| --- | --- |
| `Cue/Domain` | Core types (beliefs, confidence, unknowns). Foundation only. |
| `Cue/Tests` | Swift Testing suites |
| `Cue/App` | iPhone app entry point and the placeholder "Next" card (SwiftUI) |
| `Cue.xcodeproj` | iPhone app target (`com.slpcc63.cue`), uses the local package |
| `Scripts/archive-testflight.sh` | Signed Release archive and TestFlight upload ([Docs/TestFlight.md](Docs/TestFlight.md)) |

Services, Persistence and Features targets arrive in M1.

## Test

This Mac's `xcode-select` points at Command Line Tools, which lack Swift Testing,
so use full Xcode's toolchain:

```sh
DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer swift test
```

## Lint

```sh
xcrun swift-format lint -r Cue Package.swift
```
