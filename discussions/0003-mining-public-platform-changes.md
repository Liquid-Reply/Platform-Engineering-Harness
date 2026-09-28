---
title: Mining recent public platform changes as benchmark tasks
status: open # open | converging | decided | parked | superseded
topic: evaluation
created: 2026-09-28
updated: 2026-09-28
owner: Viktor Matkovic
supersedes:
superseded-by:
related-work-checked: never
---

# 0003: Mining recent public platform changes as benchmark tasks

## Question

Should benchmark tasks come from recent merged changes in public platform repositories, SWE-bench style, and only from changes created after the evaluated model's training cutoff?

## Why it matters

Fictional organizations (0001) are tasks we write and score ourselves. Merged changes in public repositories carry the organization's own conventions, and its reviewers set the ground truth. No existing infrastructure benchmark tests organization-specific conventions.

## Proposal

Sources: [`kubernetes/k8s.io`](https://github.com/kubernetes/k8s.io) and Wikimedia's [`operations/deployment-charts`](https://gerrit.wikimedia.org/r/q/project:operations/deployment-charts). Both run production through GitOps review and ship machine-checkable rules (conftest policies, Chainsaw tests).

Building a task:

1. Pull merged changes created after the model's cutoff.
2. Drop image promotions, version bumps, reverts and bot changes.
3. Check out the parent commit. Someone other than the skill authors writes a goal statement that does not leak the diff.
4. Verify with the repository's CI and policies, then compare structurally with the final merged state, follow-up fixes included.
5. Package as a Harbor task: container, instruction, test script.

Sample pulled 2026-09-28:

- k8s.io: 56 of 96 merged PRs are image promotions, which need digests the model cannot derive. Usable only as fabrication traps.
- deployment-charts: 42 of 120 are version bumps; 2 were reverted.
- Merged is not always correct: k8s.io [#9926](https://github.com/kubernetes/k8s.io/pull/9926) added the `kustomization.yaml` entry [#9925](https://github.com/kubernetes/k8s.io/pull/9925) forgot. Ground truth is the final state.
- Multi-step work exists: Wikimedia's gVisor rollout took six changes over four weeks, staging before production ([first](https://gerrit.wikimedia.org/r/c/operations/deployment-charts/+/1330344), [last](https://gerrit.wikimedia.org/r/c/operations/deployment-charts/+/1345257)).

## Why only recent changes

- **Memorization.** Both repositories are likely in training data. On an older change the model can reproduce the merged diff from memory, and the score then measures recall.
- **Filter by creation date.** A change is public once proposed. k8s.io [#9860](https://github.com/kubernetes/k8s.io/pull/9860) was open a month before merge. Add a margin, since vendor cutoffs are approximate.
- **Per model.** Comparisons use only tasks after the latest cutoff among the compared models, so the pool needs continuous refresh.
- **Working verifiers.** Recent changes run on current toolchains, so the repositories' CI works as-is.

Recency does not hide the convention docs, which predate any cutoff. Unknown conventions still need 0001.

## Options

**A: Recent changes only.** For: no memorization; third-party ground truth. Against: small pool; refresh per model. Cost to reverse: low.

**B: Full history.** For: thousands of tasks. Against: scores are uninterpretable for the harness question. Useful only as a probe: scores before versus after the cutoff estimate memorization.

**C: Fictional organizations only.** For: full control. Against: every task is ours.

Leaning A plus C, with B as the probe.

## Related work

<!-- Maintained by .agents/skills/related-work. Re-run rather than hand-editing; put your own
     reading under "Added by hand" so a re-run does not clobber it. -->

_Not yet run._

### Added by hand

## Open questions

- [ ] Who writes task statements? Not the skill authors.
- [ ] How long a margin after a stated cutoff?
- [ ] Is a structural comparison fair to valid solutions that differ from the merged one?
- [ ] Confirm licenses and talk to SIG K8s Infra and Wikimedia SRE before publishing tasks.

## Where we landed

Fill in at `decided` or `parked`: the choice, the reasoning that actually drove it, and what would make us revisit.
