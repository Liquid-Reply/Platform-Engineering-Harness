---
title: Counterfactual golden paths as the core adherence measure
status: open # open | converging | decided | parked | superseded
topic: evaluation
created: 2026-09-28
updated: 2026-09-28
owner: Viktor Matkovic
supersedes:
superseded-by:
related-work-checked: never
---

# 0001: Counterfactual golden paths as the core adherence measure

## Question

Should scenarios measure adherence with golden paths that contradict community practice? If so, hand-written or generated from templates?

## Why it matters

`kubernetes-secure-service` cannot test the hypothesis. Its baseline restates the Pod Security Standards and common production advice, which strong models already know, so runs with and without the harness should score about the same. This is unverified; no comparison run exists.

Platform teams deviate from community defaults. A deploy tool owns a label prefix, a throttling incident removed CPU limits, a legacy workload has a documented exception. General models get these wrong. A counterfactual baseline builds such deviations in, and both configurations receive it, so the score reflects whether the agent follows supplied rules.

## Proposal

Pair each scenario with a counterfactual baseline: same fixtures and task, some rules flipped against common practice. Tag each rule `aligned` or `counterfactual`.

| Counterfactual rule | Contradicts |
| --- | --- |
| Labels use `acme.io/*`; `app.kubernetes.io/*` is forbidden because the deploy tool owns it | Kubernetes recommended labels |
| CPU requests, never CPU limits | Checklists requiring limits |
| Tags allowed in `payments-dev`, digests only in `payments-prod` | Pin everything |
| `readOnlyRootFilesystem: false` allowed with an `acme.io/exception-id` annotation | Hardening guidance |
| Three replicas, `maxUnavailable: 1` | The aligned baseline's two and `0` |

Each rule states a plausible reason. Without one, the task tests instruction following.

**Build.** Take a task mined in 0003. Write two organization packs with conflicting rules and encode each rule as a conftest policy. Same task, two correct answers. Practicing platform engineers review the rules for plausibility.

**Measures.**

- Adherence on `aligned` versus `counterfactual` rules.
- Community rules applied where the baseline overrides them.
- Resources the baseline does not ask for.

**Prediction.** Without the harness, counterfactual adherence falls below aligned. With it, the gap narrows. An unchanged gap means the harness adds nothing here.

## Options

**A: Hand-written variants.** For: plausible rules; cheap. Against: few tasks; published rules can leak into training data. Cost to reverse: low.

**B: Generated from templates.** Randomized label prefixes, replica counts, exceptions. For: resists memorization; many samples. Against: rationales read as fake; expected outcomes must be generated too. Cost to reverse: medium.

**C: Community-aligned baselines only.** For: no invented rules. Against: adherence stays untested. Cost to reverse: none.

Leaning A, structured so B can follow.

## Related work

<!-- Maintained by .agents/skills/related-work. Re-run rather than hand-editing; put your own
     reading under "Added by hand" so a re-run does not clobber it. -->

_Not yet run._

### Added by hand

**Jev (TypeSafe AI), parked.** Hosted decision model, released 2026-09-15, returning typed yes/no, choice and score answers with probabilities. Could judge fuzzy golden-path rules; exact rules suit a policy engine. Closed, hosted only. Closest Kubernetes prior art: [jevlet](https://github.com/slateeho/jevlet), 2 commits as of 2026-09-28. Source: [flaviocopes.com/jev](https://flaviocopes.com/jev/) (as of 2026-09-28).

## Open questions

- [ ] When the baseline allows a weaker control, should the agent comply silently or also note the community recommendation? `AGENTS.md` does not cover a deliberate choice.
- [ ] How many counterfactual rules before a baseline reads as invented?
- [ ] Does the harness configuration get a hint about counterfactual rules, or does that leak the design?
- [ ] Run `related-work`: does a benchmark already score organization-specific adherence?
- [ ] Run the existing scenario with and without the harness to check the assumption above.

## Where we landed

Fill in at `decided` or `parked`: the choice, the reasoning that actually drove it, and what would make us revisit.
