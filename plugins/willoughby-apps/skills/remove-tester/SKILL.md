---
name: remove-tester
description: Stop someone from installing the person's app from TestFlight by taking their email address off the app's tester list. Use when they want to remove a tester.
argument-hint: <email address or name>
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

# Remove a tester

Read `${CLAUDE_PLUGIN_ROOT}/agents/guide.md` and talk that way, and read
`${CLAUDE_PLUGIN_ROOT}/reference/how-it-works.md` ("Testers"). Who to remove:
`$ARGUMENTS`

1. Go to the app folder and read `testers.txt` (one address per line; `#`
   lines are notes).
2. Find the address, ignoring capitals. If they gave a name or part of an
   address and more than one line matches, list the matches and ask which. If
   none match, show them the current list (addresses only) and ask.
3. Confirm: "Remove name@example.com? They won't be able to install new
   versions."
4. Delete that line only. Keep the notes and every other line as they are.
5. Commit ("Remove a tester") and push `main`, the same way the check does
   (`${CLAUDE_PLUGIN_ROOT}/skills/check/SKILL.md`, step 1).
6. Tell them: Andrew approves tester changes first (a "Testers request"
   opens in the app's repo within a few minutes). Once he does, the person
   loses access to the app in TestFlight and stops getting new versions.
   Apple does not email them about it.
