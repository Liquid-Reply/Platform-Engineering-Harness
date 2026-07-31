# Kubernetes Adapter Contract

## Common request envelope

Every operation must accept or resolve these fields:

| Field | Requirement | Meaning |
| --- | --- | --- |
| `context` | Required or explicitly resolved | Kubernetes context; return the resolved value |
| `namespace` | Required for namespaced resources | Namespace; never silently fall back for mutation |
| `timeout_seconds` | Optional, bounded | Operation timeout |
| `request_id` | Recommended | Caller-provided audit correlation ID |

Every response must include the resolved context, namespace where applicable, operation, timestamp, and a success or error status. Errors must preserve whether they represent authentication, authorization, connectivity, validation, or resource-state failure.

## Capability: `cluster_context`

**Purpose:** establish the target before other calls.

Returns the active context, cluster server identifier, default namespace, authenticated identity when discoverable, and whether the context is allowlisted. It must not return credential material.

## Capability: `get_resource`

**Purpose:** read one named object.

Inputs: `api_version`, `kind`, `name`, and common envelope. The response returns the object and source metadata. Secret `data` and `stringData` values must be redacted regardless of caller permissions.

## Capability: `list_resources`

**Purpose:** bounded discovery.

Inputs: `api_version`, `kind`, common envelope, optional label/field selectors, and a bounded limit. Pagination or truncation must be explicit. Cluster-wide listing is denied by default.

## Capability: `events`

**Purpose:** gather recent operational evidence.

Inputs: common envelope, optional resource identity, and bounded time window/limit. Return normalized event timestamps, reason, type, message, and involved object. Do not present events alone as root-cause proof.

## Capability: `logs`

**Purpose:** gather bounded workload evidence.

Inputs: pod name, common envelope, optional container, `since_seconds`, and bounded tail size. Disable unbounded follow mode. Apply configured redaction and indicate truncation.

## Capability: `diff`

**Purpose:** compare a proposed manifest with the target safely.

Inputs: manifest plus common envelope. Prefer server-side dry-run semantics and report admission/defaulting effects when supported. Return a structured diff and warnings. A successful diff does not authorize apply.

## Optional capability: `apply`

Disabled by default. An implementation may expose it only when all of the following hold:

- The user explicitly authorized this exact manifest, context, and namespace.
- A fresh diff is attached to the request.
- The target is allowlisted and credentials are least-privilege.
- The tool emits an audit record and returns the resulting object identity/version.
- Destructive replacement and force-conflict behavior are separately gated.

## Conformance checks

A candidate adapter passes the v0 contract when tests show that it:

1. Rejects an absent or disallowed target for mutation.
2. Reports its resolved context and namespace.
3. Redacts Secret values.
4. Enforces bounded lists and log reads.
5. Distinguishes authorization errors from missing resources.
6. Supports read-only operation with mutation unavailable.
7. Cannot turn a read, diff, or prior approval into implicit apply authorization.
