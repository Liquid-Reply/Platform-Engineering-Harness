# Using the Harness

The harness is context that Goose loads when it runs in this repository: `AGENTS.md`, the skills in `.agents/skills/`, and the recipe. You interact with Goose, a terminal agent comparable to Claude Code, and Goose follows the harness. Install and validation steps are in [`getting-started.md`](getting-started.md). To use it on your own repositories, see [below](#using-it-on-your-own-repositories).

## Two ways in

| Mode | Command | Use it for |
| --- | --- | --- |
| Interactive session | `goose session` | Exploratory, multi-step work. Skills load when a request matches one. |
| Recipe run | `goose run --recipe recipes/platform-engineering/recipe.yaml --params task="..."` | Repeatable runs and evaluations. Adds a required closing report. Append `--interactive` to keep chatting after the first answer. |

Start either from the repository root. In a session, `/skills` lists what Goose discovered; expect six. Restart the session after editing `AGENTS.md` or a skill.

## Using it on your own repositories

This repository ships public practice and working discipline. Organizational knowledge lives in the repositories you work on. A session needs both.

1. Install the skills globally so Goose finds them in every repository. From this repository's root:

   ```sh
   mkdir -p ~/.agents/skills
   ln -s "$PWD"/.agents/skills/* ~/.agents/skills/
   ```

   Symlinks follow `git pull`. To pin a version per repository, copy the skills into that repository's `.agents/skills/` instead. `related-work` is only useful inside this repository. Inside this repository the project copies load as well; Goose does not document which copy wins on a name clash, but they are identical.
2. Carry the safety boundaries. `AGENTS.md` is read per repository and does not travel with the skills. Merge its safety boundaries into the target repository's `AGENTS.md`, or into `~/.config/goose/.goosehints`. Goose reads `AGENTS.md` and `.goosehints` from both its global config directory and the project ([goosehints guide](https://goose-docs.ai/docs/guides/context-engineering/using-goosehints/), as of 2026-09-28).
3. Put organizational knowledge in the target repository: golden-path documents, templates, policies. Name their paths in that repository's `AGENTS.md` so every session finds them. Without them, reviews fall back to the community baseline and report the gap.
4. Run from the target repository's root and pass the recipe by path:

   ```sh
   goose run --recipe /path/to/Platform-Engineering-Harness/recipes/platform-engineering/recipe.yaml \
     --params task="Review deploy/api against docs/platform-baseline.md"
   ```

Restart sessions after pulling harness updates.

## Asking for work

Describe the task in plain language. Naming the skill is optional but makes loading deterministic.

| Task | Skill | Example request | Returned |
| --- | --- | --- | --- |
| Review manifests against a baseline | `kubernetes-workload-review` + `golden-path-review` | "Review `deploy/api/*.yaml` against `docs/platform-baseline.md`." | Findings as blocker/warning/note with requirement IDs, a minimal patch, checks run and skipped |
| Check golden-path conformance | `golden-path-review` | "Does `services/billing` follow the golden path in `templates/service/README.md`?" | Checklist with pass/fail/unknown/not-applicable per requirement |
| Review a Backstage entity | `backstage-catalog-review` | "Review `catalog-info.yaml` for ownership and relation gaps." | Schema issues, governance gaps, proposed patch |
| Triage an incident | `incident-triage` | "Checkout 5xx since 14:10 UTC. Here are the events and logs: ..." | UTC timeline, ranked hypotheses, read-only checks, mitigation options with rollback |
| Assess toil | `toil-assessment` | "We rotate staging certs by hand every two weeks, about 3 hours each. Worth automating?" | Toil classification, baseline hours, ranked interventions, a thin experiment |
| Fact-check a design discussion | `related-work` | "Run related-work on `discussions/0001-*.md`." | Prior art and claim verdicts written into the document |

Point it at your rules. The harness never invents organizational policy. If you supply no golden path for a Kubernetes review, it falls back to [`community-baselines/kubernetes.md`](community-baselines/kubernetes.md), labels every such finding as an external recommendation, and reports the missing baseline as a gap.

Give it the facts it cannot derive. It will not fabricate image digests, probe endpoints, secret names or resource sizes; it reports them as open questions or blockers instead.

## What to expect

- Discovery is read-only. Before any change to infrastructure it shows the target context, namespace, diff, impact and rollback, then waits for explicit approval.
- Output separates observed facts, assumptions and recommendations.
- Checks that could not run are reported as skipped, never as passed.
- Material changes end with Context, Decision, Changes, Verification, Risks and Recovery.
- Secret values are redacted.

## Limits

- No live-cluster access ships with the repository. [`adapters/kubernetes/`](../adapters/kubernetes/README.md) is a contract with no MCP server behind it. To connect a server, map its tools to the contract and keep mutation disabled.
- One evaluation scenario exists, [`kubernetes-secure-service`](../scenarios/kubernetes-secure-service/README.md). The evaluation protocol is in [`scenarios/README.md`](../scenarios/README.md).
- The recipe pins no model; results depend on the provider configured in `goose configure`.
