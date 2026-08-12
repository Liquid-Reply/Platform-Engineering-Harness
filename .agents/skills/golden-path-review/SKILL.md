---
name: golden-path-review
description: Compare a service or proposed platform change with an explicitly documented organizational golden path and produce evidence-based gaps
---

# Golden Path Review

Use this skill only when a repository, portal, template, or user provides a golden-path contract.

## Workflow

1. Locate and list the governing sources. Do not invent a golden path from generic best practices.
2. Convert requirements into a checklist with stable IDs and `required`, `recommended`, or `optional` strength.
3. Map each requirement to observable evidence in the target artifact.
4. Mark each item:
   - `pass`: direct evidence satisfies it
   - `fail`: direct evidence contradicts or omits a required item
   - `unknown`: evidence or environment access is insufficient
   - `not-applicable`: explain why
5. Separate compliance gaps from optional improvements. Recommend the smallest changes that move failed required items to pass.
6. If the golden-path sources conflict or are stale, report that as a contract issue and request an owner decision.

## Verification

Every pass/fail must cite a file, field, tool result, or user-provided constraint. Do not score unknown as pass. Re-run applicable validation after edits.

## Output

Provide sources, the requirement/evidence/status matrix, prioritized remediation, validation results, and questions for the golden-path owner.
