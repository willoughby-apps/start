---
name: add-tester
description: Let someone install the person's app from TestFlight by adding their email address to the app's tester list. Use when they want family or friends to try the app.
argument-hint: <email address> [more addresses]
allowed-tools: Bash(git *) Bash(gh *) PowerShell(git *) PowerShell(gh *)
---

# Add a tester

Read `${CLAUDE_PLUGIN_ROOT}/agents/guide.md` and talk that way, and read
`${CLAUDE_PLUGIN_ROOT}/reference/how-it-works.md` ("Testers"). Who to add:
`$ARGUMENTS`

1. If no address was given, ask for the email address the person uses on their
   iPhone's Apple account (the one TestFlight will use). One or more.
2. Go to the app folder and read `testers.txt`. Addresses are one per line;
   lines starting with `#` are notes. Compare addresses ignoring capitals.
3. For each new address: it must look like an email (one `@`, a dot after it,
   no spaces). Skip ones already there and say so.
4. **The cap is 25 people per app.** If adding would pass 25, add none of the
   extra ones, say how many places are left, and mention that Andrew can raise
   the limit (`/willoughby-apps:help`).
5. Add each address on its own line at the end, lower case. Keep the notes at
   the top untouched.
6. Commit ("Add a tester") and push `main`, the same way the check does
   (`${CLAUDE_PLUGIN_ROOT}/skills/check/SKILL.md`, step 1). You do not need to
   wait for the build.
7. Tell them, in plain words:
   - Apple emails each new tester an invitation to test the app, usually within
     the hour. They install **TestFlight** from the App Store on their iPhone,
     then open the email on the phone and tap the link.
   - The first time the app goes to testers, Apple reviews it once, which can
     take a day or two. After that, new versions reach them without a wait.
   - Testers see Andrew's name as the developer.
   - The list is private: only they and Andrew can see it.
