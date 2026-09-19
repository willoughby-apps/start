---
name: check
description: Save the person's app changes, send them to GitHub, and wait for Andrew's system to check and build the app, then fix anything it reports (up to three rounds) and show pictures of the app and its icon. Part of the make loop; use it on its own after changing the app, or when they ask "does it work?", "what does it look like?" or "is it done?".
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

# Check

Read `${CLAUDE_PLUGIN_ROOT}/agents/guide.md` and talk that way, and read
`${CLAUDE_PLUGIN_ROOT}/reference/how-it-works.md` and
`${CLAUDE_PLUGIN_ROOT}/RULES.md` before you start.

Tell them in one sentence what is about to happen: you will save their changes,
send them to GitHub, and Andrew's system will check and build the app, which
takes 15 to 30 minutes.

## 1. Save and send

1. Go to the app folder (how-it-works says how to find it).
2. Make sure `git config user.name` and `git config user.email` are set in this
   repo (how-it-works, "Git identity") and `.git/info/exclude` has the entries
   setup adds.
3. `git status --porcelain`. If nothing changed and the newest commit on
   `main` already has a result from Andrew's system, skip to step 3 and show
   that result.
4. Before committing, read over what changed against the Rules yourself and fix
   anything that would obviously be blocked (a new kind of file, a secret, an
   address of Andrew's). Never commit a file the Rules forbid.
5. Stage the changes (`git add -A` inside the app folder), commit with a short
   plain-English message saying what changed ("Add a blue start button"), and
   `git push origin main`.
6. If the push is refused because GitHub has newer commits, run
   `git pull --rebase origin main` and push again. Never force-push. If the
   rebase stops on a conflict you cannot resolve safely, run
   `git rebase --abort` and use `/willoughby-apps:help`.
7. Note the commit: `git rev-parse HEAD`.

## 2. Wait for the result

Wait for the newest `willoughby/check` status on that commit whose
`creator.login` is `willoughby-apps-bot[bot]` to be something other than
`pending`, as how-it-works describes (ask every 60 seconds, each command under 9
minutes, tell them the stage now and then: "It's in the queue", "It's being
built").

## 3. Read the report

Read the newest commit comment on that commit from `willoughby-apps-bot[bot]`.

- **success**: fetch the screenshot the comment names, and the icon when it
  shows one, into the app folder's `build` folder (how-it-works, "What
  happens after a push"), look at them, and tell
  them what the app looks like now. Open them for them. Then ask **"Send it to
  Andrew?"** (Andrew approves it, then it goes to TestFlight on their phone);
  on a yes follow `${CLAUDE_PLUGIN_ROOT}/skills/release/SKILL.md` from its
  step 2. If this check is part of the make loop
  (`${CLAUDE_PLUGIN_ROOT}/skills/make/SKILL.md`), carry on with its step 5.
- **failure**: the comment lists each blocked rule with its file, line and fix,
  or the compile errors. Fix them in the app (follow each "Fix:" line; read
  `RULES.md` for the rule), then go back to step 1. Tell them in one sentence
  what you are fixing ("The app used a word the safety checks don't allow;
  I'm changing it."). Do not paste the report at them.
- **error**: a problem on Andrew's side, not in the app. Do not change the app
  for it. Say so, wait 10 minutes and push again only if they want to; if it
  happens twice, offer `/willoughby-apps:help`.

## 4. Three rounds, then help

Try at most **three rounds** of fix and check for the same request. If it still
fails after the third, stop, tell them plainly what is not working, and offer
`/willoughby-apps:help` so Andrew can look (it includes the last report for
him).
