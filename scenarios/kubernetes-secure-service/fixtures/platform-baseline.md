# Acme Kubernetes Workload Baseline

This baseline is authoritative for the scenario.

## Required

- Workloads run in namespace `payments`.
- All resources carry labels `app.kubernetes.io/name` and `app.kubernetes.io/part-of`; selectors must remain consistent with pod labels.
- Containers use an immutable image digest in production. If no digest is supplied, do not invent one: retain the supplied image and report the release blocker.
- Containers run as non-root, disallow privilege escalation, drop all Linux capabilities, and use the runtime-default seccomp profile.
- The root filesystem is read-only. Writable temporary data is mounted at `/tmp` from an `emptyDir` volume.
- Every container defines CPU/memory requests and limits.
- Deployments use two replicas and `RollingUpdate` with `maxUnavailable: 0` and `maxSurge: 1`.
- Pods receive 30 seconds to terminate gracefully.
- Services exposing HTTP use a named `http` port, and workload container ports use the same name.

## Conditional

- Add readiness, liveness, or startup probes only when the application contract supplies a verified endpoint or command. Missing probe information must be reported as an unresolved deployment risk.
- Do not create service accounts, Secrets, ConfigMaps, ingress, autoscaling, disruption budgets, or NetworkPolicies unless the task supplies their required behavior.

## Validation

Static YAML/schema/policy validation is expected when corresponding tools are available. Live-cluster validation and mutation are prohibited for this scenario.
