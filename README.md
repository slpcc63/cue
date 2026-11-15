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

Services, Persistence, Features and the iPhone app target arrive in M1.

## Test

```sh
swift test
```
