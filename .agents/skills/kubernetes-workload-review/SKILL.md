---
name: kubernetes-workload-review
description: Inspect Kubernetes workload manifests for object-level coherence and verify them with static tooling, applying workload rules supplied by the golden path rather than a built-in policy
---

# Kubernetes Workload Review

Use this skill for Kubernetes YAML generation or review. It supplies Kubernetes mechanics and verification discipline. It does not define what a compliant workload looks like.

## Rule sources

The organization's golden path is the only source of workload policy. Use `golden-path-review` to convert it into a checklist before judging any manifest.

- Where a baseline, policy, or template exists, every requirement cited must come from it, by requirement ID.
- Where none exists, say so explicitly, then draw on `docs/community-baseline.md` and label each item as an external community recommendation. Never present one as an organizational requirement.
- Never infer a rule from what other manifests in the repository happen to do without naming that as the source and its strength.

## Workflow

1. Identify every document by `apiVersion`, `kind`, namespace, and name. Flag unresolved templates and missing target information.
2. Resolve object-level coherence, which no golden path defines:
   - Service selectors against pod template labels
   - container port names against Service `targetPort`
   - namespace consistency across the submitted set
   - volume and mount pairing
   - secret, ConfigMap, and service account references that resolve, without exposing values
3. Apply the golden-path checklist to the manifests. Cite the requirement ID for every finding.
4. Separate out what the manifests cannot answer:
   - an image digest cannot be derived from a tag. Report the release blocker; never fabricate a digest.
   - a probe cannot be authored without a verified application contract. Report an unresolved deployment risk; never invent an endpoint, path, or command.
   - resource quantities cannot be derived without profiling data. If you supply values, record them as a documented assumption.
5. Classify each finding as `blocker`, `warning`, or `note`. Every finding cites a manifest location plus either a golden-path requirement ID or a labeled external recommendation.
6. Propose the smallest patch. Do not apply to a cluster unless the user separately authorizes the exact target and change.

## Verification

Use available repository-native schema, render, policy, and dry-run tools. Report the commands and their results. Schema validity is not policy validity, and YAML parsing is not server acceptance. Never claim live-cluster validation if no cluster was queried.

## Output

Return scope, findings ordered by severity, proposed changes, checks performed and skipped, assumptions, and any remaining deployment risk.
