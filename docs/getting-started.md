# Getting Started

## Prerequisites

- A current Goose CLI installation with an LLM provider configured.
- A local clone of this repository.
- Optional domain tools such as `kubectl` only when a scenario requires them. The starter scenario does not require cluster access.

Run all commands from the repository root.

## Inspect the context

Goose discovers `AGENTS.md` and the project skills in `.agents/skills/` when a session starts. Start an interactive session and enter `/skills` to confirm the skills are visible:

```sh
goose session
# Then enter: /skills
```

Restart an existing session after changing project instructions or skills so the updated context is discovered reliably.

## Validate the starter artifacts

```sh
./scripts/validate.sh
```

The script checks the repository contracts and uses Goose to validate the recipe when the CLI is available. You can validate the recipe directly with:

```sh
goose recipe validate recipes/platform-engineering/recipe.yaml
```

## Run the harness recipe

Preview its configuration before execution:

```sh
goose run --recipe recipes/platform-engineering/recipe.yaml --explain
```

Start an interactive task:

```sh
goose run --recipe recipes/platform-engineering/recipe.yaml \
  --params task="Review scenarios/kubernetes-secure-service without changing the fixture" \
  --interactive
```

For a one-shot run, omit `--interactive`. The recipe does not pin a model or provider; it uses the operator's configured defaults.

## Try the first scenario

Read `scenarios/kubernetes-secure-service/task.md`, then ask the harness to perform that task. Keep generated artifacts outside the fixture directory or in an ignored temporary working copy. Score the response using `rubric.yaml` and record:

- Harness and model/provider versions.
- Enabled tools and whether cluster access was available.
- Output artifacts.
- Per-criterion score and evidence.
- Unexpected behavior or missing context.

## Safe Kubernetes integration

The initial Kubernetes adapter is a capability and safety contract, not a bundled server. Before connecting an MCP implementation, review `adapters/kubernetes/README.md` and map its tools to `adapters/kubernetes/contract.md`. Keep mutation disabled for initial evaluations.
