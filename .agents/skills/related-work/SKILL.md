---
name: related-work
description: Search for prior art and fact-check the claims in a discussion document, then write the findings back into its Related work section. Use before arguing for a position in discussions/, or to refresh a document whose related-work-checked date is stale.
---

# Related work

Most ideas in platform engineering tooling have been tried. This skill finds who tried
them and checks whether what the document asserts is still true.

## Input

A path under `discussions/`, or a raw idea. If given an idea with no document, report
in chat and offer to open one from `discussions/_template.md`.

## Procedure

1. **Extract.** List every falsifiable claim and every proposed idea in the document.
   Skip preferences and value judgements; only things that can be checked.
2. **Search.** Two passes per item: prior art (has someone built this?) and verification
   (is the stated fact true today?). Prefer primary sources (the project's own docs,
   repo, spec or paper) over blog summaries.
3. **Judge.** One verdict per item, from the table below.
4. **Write back.** Replace the generated portion of `## Related work`, leaving
   `### Added by hand` untouched. Set `related-work-checked` in the frontmatter to
   today's date and bump `updated`.

## Where to look

- **Platform engineering:** CNCF Landscape and TAG App Delivery output (incl. the
  Platforms White Paper), platformengineering.org, PlatformCon talks, Thoughtworks Radar.
- **Adjacent products:** Backstage and its plugin ecosystem, Score, Kratix, Crossplane,
  Radius, Port, Humanitec.
- **Agent harnesses:** Goose, OpenHands, SWE-agent, Aider, Claude Code; the MCP spec and
  the Agent Skills format.
- **Research:** arXiv cs.SE for LLM-on-infrastructure work and agent benchmarks; check
  whether a benchmark we are proposing already exists.
- **GitHub:** search for the idea directly, plus the relevant `awesome-*` lists. Check
  last-commit dates before calling anything active.

## Verdicts

| Verdict         | Means                                                            |
| --------------- | ---------------------------------------------------------------- |
| `exists`        | Someone already ships this. Link it. Say what we would add.      |
| `partial`       | Covered in part; name the gap we would fill.                     |
| `novel`         | Searched and found nothing equivalent. Say where you searched.   |
| `contradicted`  | The document's claim is wrong. Give the correcting source.       |
| `stale`         | Was true, no longer is. Give the date it changed.                |
| `unverified`    | Could not confirm either way. Do not round this to `novel`.      |

## Output format

```markdown
_Checked YYYY-MM-DD._

**Claim / idea**: `verdict`
Source: <url> (as of YYYY-MM-DD)
One or two lines: what they do, and what it means for us.
```

## Rules

- Never assert without a link. "I could not find one" is `unverified`, not `novel`.
- Date every source. This ecosystem moves faster than the documents describing it.
- Report findings that undercut the document's argument first and plainly. The point of
  the skill is to catch us before reviewers do.
- Do not rewrite the author's prose or change `status`. Findings go in one section.
