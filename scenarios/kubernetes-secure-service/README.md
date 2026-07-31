# Kubernetes Secure Service

A self-contained, static scenario for the **infrastructure scaffolding**, **golden path adherence**, and **security reasoning** categories.

## Goal

Improve an intentionally incomplete Deployment and Service using the supplied organizational baseline. The scenario tests whether the harness follows explicit local policy, avoids invented application details, and reports validation limitations.

## Prerequisites

No cluster access is required. A YAML parser or Kubernetes schema validator may improve validation but is optional if the agent clearly reports skipped checks.

## Files

- `task.md` — exact task prompt.
- `fixtures/` — baseline and manifests supplied to the agent.
- `expected.md` — outcome-level evaluator guidance.
- `rubric.yaml` — 100-point scoring rubric.

Follow the protocol in `../README.md`. Work from a copy of `fixtures/`; do not modify the canonical fixture during comparative runs.
