---
title: Capturing and updating organizational knowledge
status: open # open | converging | decided | parked | superseded
topic: knowledge
created: 2026-09-28
updated: 2026-09-28
owner: Viktor Matkovic
supersedes:
superseded-by:
related-work-checked: never
---

# 0002: Capturing and updating organizational knowledge

## Question

Who writes organizational knowledge: engineers only, agents through pull requests, or agent sessions through shared live state?

## Why it matters

Organizational knowledge lives in the organization's repositories (see `docs/usage.md`). An outdated golden path is worse than none because the agent follows it.

Sessions learn during work, such as a verified probe endpoint or an unwritten convention. Unless someone writes it back, that is lost when the session ends. Written back without review, one session's wrong guess or planted instruction reaches every later session.

Concurrent sessions, as of 2026-09-28:

- Goose sessions are isolated. They share only the git repository and live systems.
- Sessions can be exported and imported as JSON.
- Session-to-session messaging exists only as a [feature request in a fork](https://github.com/kojiromike/goose/issues/15).
- One Goose instance can run as a shared [team bot](https://aaif.io/blog/how-goose-is-building-a-distributed-ai-teammate-ecosystem).
- Kubernetes already rejects stale writes (`resourceVersion`) and tracks field ownership.

## Options

**A: Engineers only.** For: agents spread no errors. Against: lessons are lost and knowledge goes stale. Cost to reverse: none.

**B: Agents propose, engineers merge.** The agent opens a pull request with the lesson and its evidence; other sessions get it after merge. Draft pull requests and issue assignment mark work in flight. For: reviewed; uses the existing GitOps flow. Against: review load; markers go stale. Cost to reverse: low.

**C: Shared live state.** For: helps two agents on one incident. Against: no Goose support; unreviewed state spreads errors and injected instructions. Cost to reverse: high.

Leaning B. Incidents keep using the incident channel. Revisit C if incident scenarios show agents duplicating or contradicting each other.

## Related work

<!-- Maintained by .agents/skills/related-work. Re-run rather than hand-editing; put your own
     reading under "Added by hand" so a re-run does not clobber it. -->

_Not yet run._

### Added by hand

## Open questions

- [ ] What evidence must a proposed update carry?
- [ ] How is staleness detected: review dates, or checks against schemas and policies?
- [ ] Can a scenario measure the loop: task, merged lesson, same task again?
- [ ] Can an incident scenario count duplicate actions between two concurrent agents?

## Where we landed

Fill in at `decided` or `parked`: the choice, the reasoning that actually drove it, and what would make us revisit.
