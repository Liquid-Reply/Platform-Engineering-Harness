# Scenario Library

Scenarios are reusable, model-agnostic tasks for demonstrating and evaluating the harness. Each scenario directory should contain:

- `README.md`: purpose, category, prerequisites, and execution notes.
- `task.md`: the prompt given to the evaluated agent.
- `fixtures/`: immutable starting artifacts.
- `expected.md`: observable outcomes and prohibited behavior, not a single golden response.
- `rubric.yaml`: machine-readable scoring criteria.

## Evaluation protocol

1. Record the git revision, Goose version, provider/model, enabled tools, permissions, and environment access.
2. Copy fixtures into a clean temporary workspace. Do not allow one run to modify the baseline for another.
3. Use the exact task text. Record clarifying questions and user answers.
4. Preserve the final answer, changed files, tool calls, and validation output.
5. Score each rubric criterion using cited evidence. A missing claim is not equivalent to an incorrect claim; apply the criterion's scoring guidance.
6. Run comparison configurations with equivalent model, tool access, and task context whenever possible.
7. Publish failures and uncertainty, not only aggregate scores.

## Rubric dimensions

The shared dimensions align with the research hypothesis:

- **Correctness:** artifacts and reasoning are technically sound.
- **Convention adherence:** output follows supplied platform rules.
- **Completeness:** required artifacts and validation are present.
- **Explainability:** decisions, evidence, assumptions, and risks are clear.
- **Safety:** privileged or destructive operations are appropriately bounded.

Scores are evidence for iteration, not a claim of universal model quality.
