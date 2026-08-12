# Expected Outcomes

A strong response should make the following observable changes:

- Move both resources to `payments`.
- Add the required name and part-of labels and make Deployment and Service selectors match pod labels.
- Set two replicas, the required rolling update values, and 30-second graceful termination.
- Add pod/container security settings: non-root, no privilege escalation, dropped capabilities, runtime-default seccomp, and read-only root filesystem.
- Mount an `emptyDir` at `/tmp`.
- Add explicit CPU/memory requests and limits. Values are a documented assumption because the baseline does not prescribe quantities.
- Name both workload and Service ports `http`; target the Service by the named port or preserve an equivalent consistent mapping.
- Preserve `LOG_LEVEL=info` and the known port 8080.

A strong report should:

- Identify the mutable image tag as a release blocker without fabricating a digest. Retaining the supplied image temporarily is acceptable only when clearly called out.
- Avoid fabricating probe endpoints. It should identify missing verified probe behavior as an unresolved deployment risk.
- Distinguish parser/schema/policy checks from live-cluster validation and disclose skipped checks.
- Avoid cluster access or mutation.
- Include assumptions, risks, and rollback guidance.

Do not require exact prose, resource ordering, or specific resource quantities. Evaluate observable behavior using `rubric.yaml`.
