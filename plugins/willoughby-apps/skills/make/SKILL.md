---
name: make
description: The whole loop for the person's app, from their plain words to their phone. Use whenever they ask for anything about their app in their own words, such as "make me a gym app for tracking workouts", "change the color to green", "add a timer", "make the text bigger", "it should remember my scores" or "fix the button". Builds the change, sends it for Andrew's checks, fixes what they report (three rounds), shows pictures of the app, asks "Send it to Andrew?", and then releases it. The other helpers are shortcuts into parts of this loop.
argument-hint: [what they want, in their words]
allowed-tools: Bash(git *) Bash(gh *) PowerShell(git *) PowerShell(gh *)
---

# Make it

Read `${CLAUDE_PLUGIN_ROOT}/agents/guide.md` and talk that way, and read
`${CLAUDE_PLUGIN_ROOT}/reference/how-it-works.md` and
`${CLAUDE_PLUGIN_ROOT}/RULES.md` before you start. What they asked for:
`$ARGUMENTS`

The person only ever says what they want. Everything below is yours, in one
go, telling them the stage now and then. They never type a command.

## 1. Which app

Find the app folder (how-it-works, "Where things live"). Then apply **one app
slot** (how-it-works, "One app, in place"):

- If their only app is still the **starter app** (its screen still says hello
  and `CHANGELOG.md` has only the `1.0` entry), a new idea ("make me a gym app")
  **becomes this app**: same folder, same repo, same place on their phone.
  Never ask Andrew for a new app for it, and never open a `new-app` request.
- If the app already does something and they ask for a **different** app ("a
  second app", "another one for my recipes"), check whether they mean to
  replace what they have. Replace only with a clear yes; a second app alongside
  goes through `${CLAUDE_PLUGIN_ROOT}/skills/new-app/SKILL.md`.
- Anything else ("change", "add", "fix", "bigger") is a change to the app they
  have.

## 2. Agree on it (only when it is big)

For a new app or a big change, write back a plan in three to five plain
sentences: what the first version does, the screens, the look, the name under
the icon, anything it asks permission for (camera, location...), and what it
will **not** do yet, to keep the first version small enough to work. Check it
against the Rules. Wait for their OK. A small change ("make the text bigger")
needs no plan: just do it.

## 3. Build it

- SwiftUI, iPhone only, iOS 18, Apple's own frameworks. Keep it to files under
  `App/` and the settings in `project.yml` the template already uses.
- **The name under the icon** is `CFBundleDisplayName` under the app target's
  `info: properties:` in `project.yml`. For a new app, set it to the app's name
  (short, up to about 12 characters so the home screen does not cut it off).
  Change nothing else there that names the app: not `name:`, the target's
  name, `PRODUCT_NAME` or the bundle ID. Andrew's system and TestFlight know
  the app by those.
- A new app replacing the starter: rewrite `App/ContentView.swift` and add
  the screens it needs, update `README.md` (what it does, and the Permissions
  list), keep `App/MainApp.swift`'s app entry point (rename the struct only if
  you must, and keep `@main`). Offer an icon for it
  (`${CLAUDE_PLUGIN_ROOT}/skills/icon/SKILL.md`): "Want an icon? Describe it
  or give me a picture."
- Data the app keeps goes on the phone (SwiftData, or `UserDefaults` for small
  settings). A feature that needs a server, an account or a key is one to
  raise with Andrew (`/willoughby-apps:help`), not to build.
- Before you send it, read your change against the Rules yourself.

## 4. Check it

Follow `${CLAUDE_PLUGIN_ROOT}/skills/check/SKILL.md` from its step 1: commit
with a plain message, push, wait for Andrew's system, and on a problem fix it
and push again, **at most three rounds**, then stop and offer
`/willoughby-apps:help`. While it waits, tell them what stage it is at, and
that a check takes 15 to 30 minutes, a good time for a coffee.

## 5. Show it

When it passes, fetch the screenshot (and the icon, when the report shows one)
into a temporary folder, look at them yourself, and open them for the person.
Say what they are looking at, and whether it matches what they asked for. If
it does not look right to you, say so, fix it, and check again (it counts as a
round).

## 6. Send it to Andrew?

Ask exactly: **"Send it to Andrew?"** and say what that means in one
sentence: Andrew looks it over and approves it, and then it goes to TestFlight
on their phone. If they want more changes first, go back to step 2 with their
words. When they say yes, follow `${CLAUDE_PLUGIN_ROOT}/skills/release/SKILL.md`
from its step 2 (the check already passed): the version, the note (show it,
their OK), the tag. Then tell them the rest takes 20 to 40 minutes in all plus
the time Andrew takes to approve, and that GitHub will email them when it is
on its way.

## If their Claude plan runs out

Making an app uses a good share of a Pro plan's usage. If Claude says the
limit is reached, tell them plainly that nothing is lost: when the time Claude
names comes (usually a few hours), they open Claude in the app's folder and
say "keep going", and you pick up from the app's own state (git status, the
newest check).
