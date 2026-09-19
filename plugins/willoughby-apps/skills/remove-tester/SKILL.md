---
name: remove-tester
description: Stop someone from installing the person's app from TestFlight by taking their email address off the app's tester list. Use when they want to remove a tester.
argument-hint: <email address or name>
allowed-tools: Bash(git *) Bash(gh *) PowerShell(git *) PowerShell(gh *)
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
6. Tell them: Andrew's system takes the person off the app's testers in
   TestFlight shortly; they stop getting new versions. Apple does not email
   them about it.
