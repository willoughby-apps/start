---
name: new-app
description: Ask Andrew for a SECOND app, alongside the one they have. Interviews the person, proposes a short plan, and once they agree sends the request to Andrew. Use only when they already have an app of their own and want another one next to it; their first idea always replaces the starter app in place instead (the make loop).
argument-hint: [the idea, in their words]
allowed-tools: Bash(git *) Bash(gh *) PowerShell(git *) PowerShell(gh *)
---

# A new app

Read `${CLAUDE_PLUGIN_ROOT}/agents/guide.md` and talk that way, and read
`${CLAUDE_PLUGIN_ROOT}/reference/how-it-works.md`. Their idea, if they gave
one: `$ARGUMENTS`

**One app slot first.** If their only app is still the starter app (its screen
says hello and `CHANGELOG.md` has only the `1.0` entry), do not use this skill:
their idea becomes that app, in place, through
`${CLAUDE_PLUGIN_ROOT}/skills/make/SKILL.md`. Tell them so ("Your first app
is waiting to become this, so no need to ask Andrew").

A second app is its own repo that Andrew sets up. This skill only asks him; it
never creates a repo, a folder or any code.

## 1. Interview

Ask one question at a time, and keep it friendly and short. Skip anything they
already told you.
1. **What** does the app do? What is the first thing you do when you open it?
2. **Who** is it for? Just them, family, friends?
3. **Name**: what should it be called on the home screen? It must be letters
   and digits only, start with a letter, and be at most 30 characters (so
   "Grocery List" becomes `GroceryList`). Suggest one if they are unsure.
4. **Look**: colors, mood, anything it should look like.
5. Anything it needs from the phone (camera, photos, location, the internet)?

## 2. Propose

Write back a short plan in three to five sentences: the name, what the first
version does, how it looks, and anything it will ask permission for. Say what
the first version will **not** do yet if that helps keep it small. Check it
against `${CLAUDE_PLUGIN_ROOT}/RULES.md`: if the idea needs something the Rules
forbid (its own server of Andrew's, a capability like iCloud or push, a secret
key), say so gently and note it for Andrew in the request.

**Wait for their OK.** Change the plan until they say yes.

## 3. Send it to Andrew

1. Their first app's repo is the one named `<guest>-hello` among their apps
   (how-it-works, "Their apps":
   `gh repo list willoughby-apps --visibility private --json name,url,viewerPermission`,
   only the ones they can push to). The request goes there.
2. Make sure the label exists (it is fine if it already does):
   `gh label create new-app -R willoughby-apps/REPO --color 1D76DB --description "A request for a new app" --force`.
3. Open the issue with `--body-file` (write the body to a temporary file):
   `gh issue create -R willoughby-apps/REPO --label new-app --title "New app: <Name>" --body-file FILE`.
   The body, in plain English:

   ```
   ## <Name>

   **What it does:** ...
   **Who it's for:** ...
   **How it looks:** ...
   **Needs from the phone:** ... (or "nothing special")
   **Needs Andrew to decide:** ... (only if something above needs his OK)

   Plan agreed with <their first name>:
   <the plan from step 2>
   ```

4. Tell them: Andrew sees the request in his app. When he sets it up, GitHub
   emails them an invitation to the new app, and they can ask you "what's the
   status?" to bring it onto this computer (`/willoughby-apps:status` accepts
   the invitation and makes the folder). Its first version is a starter app
   that says hello, which you then turn into their idea together.
