# Kubernetes Reference Adapter

## Status

This directory defines the v0 capability and safety contract for a Kubernetes MCP integration. It is **not yet an executable MCP server**. Keeping the contract separate allows existing servers to be compared before the project commits to an implementation.

## Integration principles

- Start read-only; mutation is an optional capability.
- Identify the active cluster context and namespace on every operation.
- Use least-privilege credentials and an allowlist of contexts/namespaces.
- Return structured data plus source metadata suitable for audit and citation.
- Redact Secret values and other configured sensitive fields.
- Prefer server-side dry-run or diff before any apply.
- Require explicit, per-action approval for mutation; never infer approval from an earlier read request.

## Adoption checklist

1. Map candidate MCP tools to the capabilities in `contract.md`.
2. Verify read-only operation using a dedicated service account or local credentials with equivalent restrictions.
3. Test context and namespace enforcement, secret redaction, timeouts, and error reporting.
4. Run read-only scenarios and capture tool-call evidence.
5. Threat-model the server and transport.
6. Only then consider enabling `diff`; keep `apply` disabled until a separate mutation review is complete.

## Non-goals for v0

- Shipping cluster credentials.
- Selecting one Kubernetes MCP implementation prematurely.
- Bypassing admission control or policy engines.
- Treating client-side validation as proof that a cluster accepted a resource.

See `contract.md` for the required capabilities and acceptance criteria.
