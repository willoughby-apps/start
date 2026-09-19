---
name: release
description: Put a new version of the person's app on their phone. Bumps the version, writes a plain-English note for the TestFlight "What to Test" box, tags and pushes it, and explains that Andrew approves each release. Use when they say yes to "Send it to Andrew?", or ask to put it on their phone, send it to Andrew, or share it with testers.
argument-hint: [what is new, in their words]
allowed-tools:
  - Bash(git status)
  - Bash(git status --porcelain)
  - Bash(git status -sb)
  - Bash(git add -A)
  - Bash(git commit -m *)
  - Bash(git push origin main)
  - Bash(git push origin main --follow-tags)
  - Bash(git pull --rebase origin main)
  - Bash(git rebase --abort)
  - Bash(git log *)
  - Bash(git diff *)
  - Bash(git show *)
  - Bash(git rev-parse HEAD)
  - Bash(git tag -a v*)
  - Bash(git ls-remote --tags origin)
  - Bash(git config user.name *)
  - Bash(git config user.email *)
  - Bash(gh api user)
  - Bash(gh api user --jq .login)
  - Bash(gh api user/repository_invitations)
  - Bash(gh api repos/willoughby-apps/* --method GET --hostname github.com)
  - Bash(gh issue list *)
  - Bash(gh issue view *)
  - Bash(gh issue create -R willoughby-apps/*)
  - Bash(gh label create new-app -R willoughby-apps/*)
  - Bash(gh label create needs-andrew -R willoughby-apps/*)
  - Bash(gh repo list willoughby-apps --visibility private --json name,url,viewerPermission)
  - Bash(gh repo clone willoughby-apps/*)
  - Bash(gh auth status)
  - PowerShell(git status)
  - PowerShell(git status --porcelain)
  - PowerShell(git status -sb)
  - PowerShell(git add -A)
  - PowerShell(git commit -m *)
  - PowerShell(git push origin main)
  - PowerShell(git push origin main --follow-tags)
  - PowerShell(git pull --rebase origin main)
  - PowerShell(git rebase --abort)
  - PowerShell(git log *)
  - PowerShell(git diff *)
  - PowerShell(git show *)
  - PowerShell(git rev-parse HEAD)
  - PowerShell(git tag -a v*)
  - PowerShell(git ls-remote --tags origin)
  - PowerShell(git config user.name *)
  - PowerShell(git config user.email *)
  - PowerShell(gh api user)
  - PowerShell(gh api user --jq .login)
  - PowerShell(gh api user/repository_invitations)
  - PowerShell(gh api repos/willoughby-apps/* --method GET --hostname github.com)
  - PowerShell(gh issue list *)
  - PowerShell(gh issue view *)
  - PowerShell(gh issue create -R willoughby-apps/*)
  - PowerShell(gh label create new-app -R willoughby-apps/*)
  - PowerShell(gh label create needs-andrew -R willoughby-apps/*)
  - PowerShell(gh repo list willoughby-apps --visibility private --json name,url,viewerPermission)
  - PowerShell(gh repo clone willoughby-apps/*)
  - PowerShell(gh auth status)
---

# Release

Read `${CLAUDE_PLUGIN_ROOT}/agents/guide.md` and talk that way, and read
`${CLAUDE_PLUGIN_ROOT}/reference/how-it-works.md` ("Releases") before you start.
What they said about this release, if anything: `$ARGUMENTS`

## 1. Make sure the app is ready

Go to the app folder. If anything is unsaved, or the newest commit on `main`
does not have a `success` `willoughby/check` status from
`willoughby-apps-bot[bot]`, run the check first (follow
`${CLAUDE_PLUGIN_ROOT}/skills/check/SKILL.md`). Release only a commit that
passed: a release that fails its check never reaches Andrew.

## 2. Pick the version

1. Read `MARKETING_VERSION` from `project.yml` (for example `"1.0"`).
2. The new version adds one to the second number (`1.0` becomes `1.1`, `1.9`
   becomes `1.10`), unless they asked for something else. Versions are only
   digits and dots, at most three numbers.
3. Check the tag is free: `git ls-remote --tags origin`. If `v<new>` exists,
   add one again.

## 3. Write the note

1. Look at what changed since the last release (the commits since the newest
   `v` tag, or since the start).
2. Write two to five short bullets in plain English about what someone using the
   app will notice ("You can now pick a color for each list."). No file names,
   no code words. This becomes the "What to Test" note in TestFlight.
3. Show them the note and the version and wait for their OK or changes.
4. Add it to the top of `CHANGELOG.md`, below the introduction and above the
   previous version, as `## <new version>` followed by the bullets.

## 4. Tag and send

1. In `project.yml`, change only the `MARKETING_VERSION` value, keeping the
   quotes (`MARKETING_VERSION: "1.1"`). Change nothing else there.
2. Commit both files ("Release 1.1") and `git push origin main`.
3. Tag that commit and send the tag:
   `git tag -a v1.1 -m "Version 1.1"`, then `git push origin main --follow-tags`.
   Check it arrived: `git ls-remote --tags origin` lists `refs/tags/v1.1`. If
   it does not, the tag name was already on GitHub: never move or force it;
   release the next version instead.

## 5. Explain what happens next

Tell them, in plain words:
- Andrew's system checks and builds this version (15 to 30 minutes), and
  from their idea to their phone is usually 20 to 40 minutes plus Andrew's
  approval.
- When it passes, a note called "Release request: v1.1" appears in their app's
  GitHub page and GitHub emails them about it.
- Andrew reads a safety review of the changes and approves it himself. When he
  does, the new version goes to TestFlight and GitHub emails them that it is
  there. If he has a question or says no, his note arrives the same way.

Offer to wait for the check with them. If they want to, wait for the
`willoughby/release` status on the tagged commit from `willoughby-apps-bot[bot]`
(how-it-works, "Waiting"), then look for the open issue titled
`Release request: v<version>` whose author is `willoughby-apps-bot[bot]`
(`gh issue list -R willoughby-apps/REPO --label release-request --state open --json number,title,author,url`)
and tell them it is waiting for Andrew. If the release check fails, fix the app,
run the check, and release the **next** version; never move or delete a tag.
