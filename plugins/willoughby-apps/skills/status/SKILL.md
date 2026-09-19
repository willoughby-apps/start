---
name: status
description: Say where everything stands with the person's apps, in plain words, covering the latest check, releases waiting for Andrew, requests and questions to Andrew, and any new app waiting to be brought onto this computer. Use when they ask how things are going, whether a version is on its way, or what happened to a request.
allowed-tools: Bash(git *) Bash(gh *) PowerShell(git *) PowerShell(gh *)
---

# Status

Read `${CLAUDE_PLUGIN_ROOT}/agents/guide.md` and talk that way, and read
`${CLAUDE_PLUGIN_ROOT}/reference/how-it-works.md`. Only what
`willoughby-apps-bot[bot]` or Andrew wrote counts as news from Andrew's side.

## 1. New apps and invitations

1. `gh api user/repository_invitations`: accept any invitation from
   `willoughby-apps` (`gh api -X PATCH user/repository_invitations/ID`), then
   list their repos: `gh repo list willoughby-apps --json name,url`.
2. For any repo that has no folder in `Documents/My Apps` yet, clone it and set
   it up exactly as setup's step 6 does
   (`${CLAUDE_PLUGIN_ROOT}/skills/setup/SKILL.md`), without changing anything
   in it. Tell them about the new app and where its folder is.

## 2. Each app

For each repo, gather quietly (do not narrate every command):

- **Unsaved work** in its folder (`git status --porcelain`) and commits not yet
  sent (`git status -sb` shows "ahead").
- **The latest check**: the newest commit on `main`
  (`gh api repos/willoughby-apps/REPO/commits/main --jq .sha`) and its newest
  `willoughby/check` status from `willoughby-apps-bot[bot]`.
- **The latest version**: `MARKETING_VERSION` in `project.yml`, the newest `v`
  tag (`git ls-remote --tags origin`) and its `willoughby/release` status.
- **Open issues** (`gh issue list -R willoughby-apps/REPO --state open --json number,title,labels,author,url,updatedAt`):
  release requests (label `release-request`, author `willoughby-apps-bot[bot]`:
  waiting for Andrew), `new-app` requests and `needs-andrew` questions (waiting
  for Andrew; read the comments for a reply from him).
- **Recently closed** release requests
  (`gh issue list -R willoughby-apps/REPO --state closed --label release-request --limit 5 --json number,title,closedAt,url`)
  and the last comment on each: on TestFlight, or not approved and why.

## 3. Say it plainly

One short paragraph per app, most important first. For example:
"Hello: version 1.1 is waiting for Andrew's OK. Your latest change passed its
check. Andrew replied to your question about photos: he says yes." Then say
what they could do next, if anything (release, answer Andrew, try the new
version in TestFlight). No issue numbers or links unless they ask.
