---
name: help
description: Ask Andrew for help. Writes him a short note in the person's own words, with the facts he needs (which app, what was being done, the last check report), on their app's GitHub page. Use when something keeps failing, when the app needs something the Rules forbid, or when they want Andrew's opinion.
argument-hint: [what they need, in their words]
allowed-tools: Bash(git *) Bash(gh *) PowerShell(git *) PowerShell(gh *)
---

# Ask Andrew

Read `${CLAUDE_PLUGIN_ROOT}/agents/guide.md` and talk that way, and read
`${CLAUDE_PLUGIN_ROOT}/reference/how-it-works.md`. What they said: `$ARGUMENTS`

1. If you do not know yet, ask them in one question what they were trying to do
   and what they would like from Andrew. Keep their words.
2. Gather the facts yourself, quietly:
   - which app (the repo) and the newest commit on `main` (`git rev-parse HEAD`
     and whether it was sent to GitHub);
   - the newest `willoughby/check` or `willoughby/release` status on it from
     `willoughby-apps-bot[bot]`, and the link to that commit's newest comment
     from the bot (its `html_url`);
   - what you already tried, in one or two sentences;
   - if a Rule is in the way, which one (its name from `RULES.md`).
3. Make sure the label exists:
   `gh label create needs-andrew -R willoughby-apps/REPO --color D93F0B --description "A question for Andrew" --force`.
4. Open the issue with a body file:
   `gh issue create -R willoughby-apps/REPO --label needs-andrew --title "Help: <a few words>" --body-file FILE`.
   The body:

   ```
   **In <their first name>'s words:** ...

   **What we were doing:** ...
   **What happened:** ... (one or two sentences, no pasted logs)
   **What Claude tried:** ...
   **Latest check:** <state> on <short commit>, report: <link to the bot's comment>
   ```

   Never include passwords, codes, keys, tokens, or anything from their
   computer outside the app folder.
5. Show them the note in plain words before you send it, and send it when they
   say it is right.
6. Tell them: Andrew sees it in his app, and his reply arrives by email from
   GitHub. They can ask you "any word from Andrew?" at any time
   (`/willoughby-apps:status`). Meanwhile, suggest something else you can work
   on together if there is anything.
