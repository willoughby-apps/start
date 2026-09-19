---
name: add-tester
description: Let someone install the person's app from TestFlight by adding their email address to the app's tester list. Use when they want family or friends to try the app.
argument-hint: <email address> [more addresses]
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

# Add a tester

Read `${CLAUDE_PLUGIN_ROOT}/agents/guide.md` and talk that way, and read
`${CLAUDE_PLUGIN_ROOT}/reference/how-it-works.md` ("Testers"). Who to add:
`$ARGUMENTS`

1. If no address was given, ask for the email address the person uses on their
   iPhone's Apple account (the one TestFlight will use). One or more.
2. Go to the app folder and read `testers.txt`. Addresses are one per line,
   an optional name after the address; lines starting with `#` are notes.
   Compare addresses ignoring capitals.
3. For each new address: it must look like an email (one `@`, a dot after it,
   no spaces). Skip ones already there and say so. Ask their name if the
   person knows it (Apple's invitation shows it); it is optional.
4. **The cap is 25 people per app.** If adding would pass 25, add none of the
   extra ones, say how many places are left, and mention that Andrew can raise
   the limit (`/willoughby-apps:help`).
5. Add each address on its own line, lower case, with the name after it if
   given, **above** any `# external:` line (friends and family), unless the
   person clearly wants an outside tester, who goes below `# external:` (add
   that line at the end if it is not there). Keep the notes untouched.
6. Commit ("Add a tester") and push `main`, the same way the check does
   (`${CLAUDE_PLUGIN_ROOT}/skills/check/SKILL.md`, step 1). You do not need to
   wait for the build.
7. Tell them, in plain words:
   - Andrew approves tester changes first: a "Testers request" opens in the
     app's repo within a few minutes, and nothing happens until he approves it.
   - Then Apple emails each new person an invitation to join Andrew's team for
     this one app. They open it and accept within 3 days (it is sent again if
     they miss it), signing in with their Apple account.
   - Next TestFlight emails them. They install **TestFlight** from the App
     Store on their iPhone, then open that email on the phone and tap the link.
   - Outside testers (below `# external:`) instead wait for Apple to review
     each new version, which can take a day or two.
   - Testers see Andrew's name as the developer.
   - The list is private: only they and Andrew can see it.
