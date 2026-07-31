---
name: backstage-catalog-review
description: Review Backstage catalog entity YAML for schema coherence, ownership, lifecycle, dependency, and documentation metadata without publishing it
---

# Backstage Catalog Review

Use this skill for catalog entity review or scaffolding. Repository templates and installed Backstage configuration override generic examples.

## Workflow

1. Discover the repository's catalog templates, supported API versions/kinds, naming rules, annotations, and relation conventions.
2. Parse all entities and verify `apiVersion`, `kind`, `metadata.name`, and `spec` fields applicable to that kind.
3. Check that ownership and lifecycle values are present and reference known conventions. Treat unresolved owners as a governance gap, not a guessed value.
4. Check system/domain/component grouping, dependency/API relations, source location, and documentation annotations when required by local policy.
5. Validate references across entities in the submitted set. Distinguish syntax/schema errors from references that require a live catalog to resolve.
6. Propose a minimal patch and preserve custom annotations unless they are demonstrably invalid.

## Verification

Use repository-native linting, schema validation, or catalog tooling when available. Never claim registration or ingestion succeeded unless a Backstage instance returned evidence.

## Output

Return entities reviewed, blocking schema issues, governance/relation gaps, optional improvements, proposed changes, checks run, and unresolved live-catalog questions.
