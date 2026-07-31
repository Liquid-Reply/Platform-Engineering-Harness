# Task

Review `fixtures/deployment.yaml` and `fixtures/service.yaml` against `fixtures/platform-baseline.md`.

Produce corrected Kubernetes manifests and a concise review report. Preserve the application's known behavior and do not invent health endpoints, secret names, or cluster capabilities. Use repository-native or locally available static validation where possible.

Do not access or mutate a live cluster. In the report, include:

- findings and their severity,
- assumptions and unresolved questions,
- validation performed and skipped,
- deployment risks and rollback guidance.
