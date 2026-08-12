---
name: incident-triage
description: Triage platform incidents with an evidence timeline, explicit hypotheses, safe diagnostic actions, and reversible mitigation choices
---

# Incident Triage

Optimize for safe service restoration while preserving evidence. Never state root cause from correlation alone.

## Workflow

1. Establish impact, affected users/services, start time, current state, severity owner, and recent changes. Mark missing facts.
2. Build a UTC timeline. Label entries as observed facts, reported facts, or inferences and cite their source.
3. Generate a small ranked hypothesis set. For each hypothesis record supporting evidence, contradicting evidence, and the cheapest safe discriminating check.
4. Perform read-only checks first. Bound queries by time, namespace/account, and result size; redact sensitive data.
5. Present mitigation options with expected impact, risk, verification signal, and rollback. Require explicit authorization before state-changing actions.
6. After mitigation, verify user-facing recovery and guardrails, not merely process health.
7. Capture follow-ups without mixing them into immediate response work.

## Verification

A hypothesis becomes confirmed only with discriminating evidence. Record failed checks and data gaps. Preserve exact timestamps and command/tool context.

## Output

Return current impact, timeline, hypothesis table, checks and evidence, proposed/authorized actions, recovery signals, rollback, and follow-up items.
