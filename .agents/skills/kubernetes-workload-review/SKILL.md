---
name: kubernetes-workload-review
description: Review Kubernetes workload manifests for operational safety, security, reliability, and repository conventions without applying them
---

# Kubernetes Workload Review

Use this skill for Kubernetes YAML generation or review. Default to static, read-only analysis.

## Workflow

1. Identify every document by `apiVersion`, `kind`, namespace, and name. Flag unresolved templates and missing target information.
2. Inspect repository policy, examples, schemas, and deployment tooling before applying generic defaults.
3. Check applicable workload properties:
   - immutable image reference policy and pull behavior
   - non-root execution, privilege escalation, Linux capabilities, seccomp, and read-only root filesystem
   - CPU and memory requests/limits
   - startup, readiness, and liveness probes matched to actual application behavior
   - graceful termination, rollout strategy, replica availability, and disruption expectations
   - Service selectors/ports, labels, and namespace consistency
   - service account and RBAC scope
   - secret/config references without exposing values
   - network policy and storage implications when relevant
4. Classify each finding as `blocker`, `warning`, or `note`. Cite the manifest location and the violated repository rule or clearly label a community recommendation.
5. Propose the smallest patch. Do not apply to a cluster unless the user separately authorizes the exact target and change.

## Verification

Use available repository-native schema, render, policy, and dry-run tools. Report commands and results. Never equate YAML parsing with server acceptance, and never claim live-cluster validation if no cluster was queried.

## Output

Return scope, findings ordered by severity, proposed changes, checks performed, assumptions, and any remaining deployment risk.
