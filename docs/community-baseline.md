# Community Baseline

A fallback for the case where an organization has supplied no golden path. It is not this project's policy and carries no organizational authority.

Rules taken from here must be labeled in output as an external community recommendation, with the standard named. An unlabeled recommendation is indistinguishable from an invented organizational policy, which `AGENTS.md` prohibits.

## Sources, in order of preference

1. **Kubernetes Pod Security Standards**, `restricted` profile. The reference for pod and container security context. Upstream, versioned, and enforceable through Pod Security Admission.
2. **CIS Kubernetes Benchmark**. Broader operational and control-plane coverage. Note the benchmark version and the Kubernetes version it targets.
3. **NSA/CISA Kubernetes Hardening Guidance**. Useful where a control needs justification to a security reviewer.
4. **Kubernetes documentation on production readiness**, for reliability concerns that no security standard covers, such as rollout strategy and termination behavior.

Where these disagree, report the disagreement rather than picking a winner.

## Limits

- Nothing here is scoped to an organization's risk tolerance, workload profile, or compliance obligations.
- Reliability and cost concerns are largely uncovered. Resource quantities in particular cannot be derived from any standard and require profiling data.
- Standards drift. Record which version informed a finding.

Treat a run that falls back to this file as a gap in the organization's golden path, and say so in the output. The correct long-term fix is a written baseline, not a better fallback.
