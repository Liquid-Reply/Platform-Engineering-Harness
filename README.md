# Platform Engineering AI Harness

> A domain-specialized AI harness for platform engineering. General-purpose AI models are great at scaffolding new features, but platform engineering work is long-running, cross-system, and governed by conventions that no off-the-shelf model knows out of the box.

## Why this project exists

Platform engineering sits at the intersection of infrastructure, developer experience, and organizational design. It rarely fits inside a single repository, a single request, or a single "task." It's shaped by golden paths, internal conventions, security baselines, incident history, and toil patterns that are specific to each organization.

General-purpose AI models are excellent at starting something new, reviewing existing code, or implementing a well-scoped feature step by step. They are not, by default, optimized for the specialized vocabulary, tooling, and decision-making patterns that platform engineering requires. And especially for the kind of infrastructure-heavy, never-ending, product-mindset work that defines the discipline.

**Research hypothesis:** a purpose-built harness that encodes platform engineering domain knowledge with tools, conventions, evaluation criteria, and best practices will meaningfully outperform a standard general-purpose model on platform engineering tasks.

This repository is where we build, test, and evolve that harness in the open.

## What's in scope

This project is organized around building a reference implementation, plus the supporting research to prove (or disprove) whether it actually helps. The harness itself is one part of a larger research effort; this repo focuses on the harness and its scenario/skill library.

### Design principles

- **Don't reinvent the runtime.** Build on an existing, maintained agentic harness foundation rather than rebuilding core agent infrastructure from scratch. This lets the project focus effort on domain-specific extensions instead of plumbing.
- **Layered, iterative evolution.** Start minimal and get more sophisticated over time:
  1. **v0 - Context engineering on an existing harness.** Use conventions like `AGENTS.md`, skills, MCP servers, and Markdown-based wikis to inject platform engineering knowledge into an existing harness runtime.
  2. **v1 - Retrieval-augmented extension.** Evolve toward a RAG-backed system that's easy to keep filled with organization-specific and community-contributed knowledge. The hard problem here isn't retrieval itself, it's making the knowledge-authoring process accessible to everyone, not just the original maintainers.
- **Open and extensible by default.** Skills, adapters, and scenarios should be contributable by the community, not locked to a single maintainer's mental model of "correct" platform engineering.

### Harness foundation

The initial reference implementation is being built on top of **[Goose](https://github.com/block/goose)**, an open-source, extensible agentic framework with support for skill composition and tool integration. Building on Goose means the project inherits a maintained runtime and can spend its research effort on domain knowledge rather than agent infrastructure.

- **Chat & interact workloads:** Goose
- **CLI-first / code workloads:** Goose, with **[Pi.dev](https://pi.dev)** documented as an alternative worth evaluating for CLI-specific tasks

Alternative harness foundations will be documented as the project evolves, in case community needs outgrow the current choice.

## Repository structure

```
.
├── .agents/skills/      # Focused project-level Goose skills
├── adapters/            # Integration capability and safety contracts
│   └── kubernetes/      # Kubernetes reference adapter contract
├── discussions/         # Open design questions and the reasoning behind our answers
├── docs/                # Architecture and setup documentation
├── recipes/             # Reusable Goose harness recipes
├── scenarios/           # Reproducible tasks, fixtures, and scoring rubrics
├── scripts/             # Repository validation
└── AGENTS.md             # Project-wide context and safety boundaries
```

See [`docs/architecture.md`](docs/architecture.md) for the v0 context layers and [`docs/getting-started.md`](docs/getting-started.md) for setup. [`docs/usage.md`](docs/usage.md) covers day-to-day interaction.

## Quick start

With Goose installed and a provider configured:

```sh
./scripts/validate.sh
goose run --recipe recipes/platform-engineering/recipe.yaml --explain
```

In an interactive Goose session, enter `/skills` to confirm the five project skills are discoverable.

The first reusable evaluation task is in [`scenarios/kubernetes-secure-service/`](scenarios/kubernetes-secure-service/). The Kubernetes adapter currently defines a read-first integration contract; it does not yet bundle an MCP server or cluster credentials.

## Deliverables for the initial release

- [x] Initial harness implementation, built on Goose
- [x] At least 5 platform engineering skill definitions
- [ ] Reference integration adapter for **Kubernetes** (v0 capability and safety contract is defined; executable MCP integration remains)
- [x] A documented scenario library that the wider research community can reuse

## Target task categories

The harness is designed and evaluated against the core competencies of platform engineering, including:

- **Infrastructure scaffolding** —> generating correct, idiomatic Kubernetes manifests, Helm chart structures, or OpenTofu modules
- **Developer portal configuration** —> reasoning about Backstage catalog entries, TechDocs structure, and plugin configuration
- **Incident and toil reasoning** —> identifying toil patterns and proposing automation strategies consistent with SRE principles
- **Golden path adherence** —> evaluating whether generated output conforms to an organization's defined golden paths
- **Security and compliance reasoning** —> recognizing misconfigurations and suggesting remediations aligned with community security guidelines

These categories also anchor the companion evaluation framework/benchmark (a separate open-source artifact) used to compare harness-assisted output against a standard general-purpose model on the same tasks, under a shared, published rubric covering correctness, convention adherence, completeness, and explainability.

## How this fits into the broader research effort

This harness is one workstream of a larger initiative that also includes:

- **An open evaluation framework/benchmark**, so any researcher or practitioner can reproducibly compare a specialized harness against a general-purpose model.
- **An end-user survey programme**, tracking longitudinally how practitioners actually use AI for platform engineering, and whether specialized tooling changes what they attempt to automate and how quickly they ship.

The harness in this repository is meant to be usable and testable independent of those other workstreams so you don't need to wait on the benchmark or the survey results to start using or contributing to it.

## Contributing

This is a community-extensible project. Contributions of new skills, adapters, scenarios, and documentation are welcome. See `CONTRIBUTING.md` for guidelines, issue templates, and the current roadmap once published.

If you're contributing a **skill**, aim for it to encode a concrete, testable platform engineering convention or decision pattern, not just general advice a base model would already know.

Design questions that aren't settled yet live in [`discussions/`](discussions/). Open one there rather than in an issue if the answer needs to outlive the thread. The [`related-work`](.agents/skills/related-work/SKILL.md) skill searches for prior art and fact-checks a discussion's claims before it goes to review.

## Status

Early-stage / active research and development. Expect the architecture, especially the RAG-based v1 direction, to change as we learn from real usage.