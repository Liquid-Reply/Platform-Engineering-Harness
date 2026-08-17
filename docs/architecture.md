# v0 Architecture

## Goal

Version 0 tests whether explicit platform-engineering context improves an existing agent runtime. It intentionally does not introduce a custom agent runtime or retrieval service.

## Context layers

```text
User task
   |
   v
AGENTS.md                 project-wide behavior and safety boundaries
   |
   v
.agents/skills/*/SKILL.md focused, on-demand domain workflows
   |
   +--> docs/             shared conventions and architecture notes
   +--> adapters/         external-system capability contracts
   +--> scenarios/        repeatable tasks and evaluation rubrics
   |
   v
Goose + enabled tools     execution, inspection, and validation
```

### Project instructions

`AGENTS.md` is deliberately concise and always applicable. It defines source precedence, the operating model, and non-negotiable safety behavior.

### Skills

Skills are stored in the standard project-level `.agents/skills/<name>/SKILL.md` layout. Each skill should encode a focused and testable workflow. Large reference material belongs in supporting files or `docs/`, not in the always-loaded project instructions.

Skills separate rules from mechanics, and the two compose rather than compete:

- **Rule skills** convert an organization's documented contract into a checklist. `golden-path-review` is the general engine.
- **Technology skills** supply the mechanics of inspecting and verifying one kind of artifact, and consume that checklist. `kubernetes-workload-review` is the reference example.

A technology skill must not carry its own workload policy. Doing so creates a second source of truth that can silently contradict the organization's baseline, and it makes evaluation scores depend on which skill the runtime happened to load. Where no golden path exists, the matching file under `docs/community-baselines/` names external standards to fall back on, and every finding drawn from it is labeled as an external recommendation rather than an organizational requirement.

### Adapters

Adapters expose external platform capabilities through MCP-compatible tools. The v0 Kubernetes contract starts read-only and separates observation, diffing, and mutation. The contract is implementation-neutral so different Kubernetes MCP servers can be evaluated against the same safety expectations.

### Scenarios

A scenario packages a task, fixtures, expected outcomes, and a scored rubric. Expected outcomes describe observable properties rather than prescribing exact prose, allowing different models and harness configurations to be compared fairly.

## Deliberate v0 constraints

- No RAG or vector store.
- No bundled credentials or cluster access.
- No automatic infrastructure mutation.
- No claim that a Markdown adapter contract is a working MCP server.
- No model or provider lock-in in the reusable recipe.

## Evolution criteria

Add another context layer only when scenario results identify a repeatable failure that the simpler layer cannot address. Candidate v1 retrieval work should record corpus ownership, freshness, access control, citations, and evaluation impact before implementation.
