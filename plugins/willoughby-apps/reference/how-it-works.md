# How a Willoughby app is built and shipped

Facts for Claude. The person you are helping never needs to read this.

## Where things live

- Every app is a **private repo** in the GitHub organization
  **`willoughby-apps`**, named `<guest>-<app>` (the first one is
  `<guest>-hello`). The person is a collaborator on their own repos only.
- **Their apps** are the repos this lists that are private and that they can
  push to (`viewerPermission` is `WRITE`, `MAINTAIN` or `ADMIN`):

  ```
  gh repo list willoughby-apps --visibility private --json name,url,viewerPermission
  ```

  Never count `pipeline`, `start` or `app-template` as their app, whatever a
  listing shows: `pipeline` and `start` are public, so every GitHub account
  sees them, and they are Andrew's, not the person's. Every helper that looks
  for "their apps" uses exactly this list.
- On their computer each app is a folder under **`Documents/My Apps/<repo>`**.
  On Windows, find Documents with
  `[Environment]::GetFolderPath('MyDocuments')` (it may be inside OneDrive);
  on a Mac it is `~/Documents`.
- **Work only on `main`.** Never make branches, never force-push, never
  rewrite history, never delete tags.
- If you are not already in an app folder, look under `Documents/My Apps`. With
  one app, use it; with several, ask which (by name). Read that folder's
  `CLAUDE.md` before changing anything.
- The app is SwiftUI, iPhone only, iOS 18.0, described by `project.yml`
  (XcodeGen). Nobody builds on this computer, and it may not be a Mac. There
  is no Xcode project in the repo and there must never be one.
- Keep these out of every commit: `.DS_Store`, `Thumbs.db`, `desktop.ini`,
  screenshots you downloaded, and anything under `build/`. Setup lists them in
  the repo's `.git/info/exclude` (a local file that is never committed);
  if an entry is missing, add it there, never to a committed `.gitignore`.
- Write text files as UTF-8 without a byte order mark.

## One app, in place

- Each person starts with **one app slot**: their `<guest>-hello` repo, whose
  bundle ID and App Store record Andrew already made. Their **first idea
  replaces the starter app in place**: same repo, same folder, same bundle ID,
  same TestFlight entry. It needs nothing from Andrew but the usual approval of
  the release. A `new-app` request is only for a **second** app alongside one
  that already does something.
- **The name under the icon** on the home screen is `CFBundleDisplayName` in
  the app target's `info: properties:` in `project.yml`. Change only that to
  rename the app. Never change `name:`, the target's name, `PRODUCT_NAME`, the
  bundle ID or the repo's name. TestFlight's own list may keep showing the name
  Andrew gave the app record ("Hello by Sam") until he renames it; that is
  expected.
- **The icon** is `App/Assets.xcassets/AppIcon.appiconset/AppIcon.png`: a
  1024 by 1024 PNG, RGB with no transparency (the rule `app_icon.invalid`).
  Make it with `/willoughby-apps:icon`. The check's report shows it beside the
  screenshot.

## The loop

When the person asks for anything in their own words, run the whole loop in
the make skill: build, push, wait for the check, fix what it reports (three
rounds at most), show the screenshot and the icon, ask **"Send it to
Andrew?"**, and on a yes, release. Commands are only shortcuts into it.

- **Timing**: a check takes 15 to 30 minutes; from an idea to the app on their
  phone is usually **20 to 40 minutes**, plus the time Andrew takes to approve.
- **Usage**: making an app uses a good share of a Claude Pro plan's usage. If
  the limit is reached, nothing is lost; they come back when Claude says it
  resets and say "keep going", and you pick up from the repo's state.
- **Permissions**: the app folder's `.claude/settings.json` lets you run the
  exact `git` and `gh` commands this loop uses, and `sips` on a Mac, without
  asking each time. Write them exactly as the helpers do: the list names each
  command with its options, so the same command with other options asks, and
  some are refused outright (force pushes, deleting tags, options that write
  files or run programs). Everything else still asks; say what it is for
  first. Three things make every command ask:
  - Claude was **not started in the app folder** (the folder's list loads only
    there). Then say so, and ask them to quit Claude and open it again in the
    app folder (setup's "Finish" says how).
  - The person has **not yet trusted the folder**: the first time Claude opens
    in it, it asks whether they trust the folder and lists the commands it
    lets you run (screens.md, "Claude: trusting the app folder"). Until they
    say yes, the list is not used.
  - A command that **starts with `cd`** into another folder, or (on Windows)
    with the `$env:Path` refresh that setup used. Run commands from the app
    folder itself, one per line; in the app folder a new Claude already has
    git and gh on its path.
- **Reading from GitHub**: every `gh api` read of `repos/willoughby-apps/...`
  ends with exactly `--method GET --hostname github.com`, as the last two
  options. That is the form the folder allows: gh uses the last `--method` and
  `--hostname` it is given, so that command can only read from GitHub.

## The rules

The plugin's `RULES.md` (the same text as the Rules section of the app's
`CLAUDE.md`) is what Andrew's checks enforce. Every push that breaks one is
blocked, and the report names the rule and the fix. Follow them exactly and
never work around one: use `/willoughby-apps:help` instead.

## What happens after a push

1. Andrew's system looks for new commits on every app's `main` about every 5
   minutes. When it sees one it marks the commit **pending**.
2. It runs the safety checks (the Rules, plus scanners for secrets, known
   vulnerabilities, risky code and malware), then builds the app and opens it
   in an iPhone simulator. That usually takes 15 to 30 minutes in all.
3. It posts the result **on the commit**:
   - a commit status with context **`willoughby/check`** (or
     **`willoughby/release`** for a version tag): `pending`, `success`,
     `failure` (the checks or the build found a problem in the app) or `error`
     (a problem on Andrew's side, not in the app);
   - a commit comment with the headline, every blocked rule with its fix, the
     compile errors, and a simulator screenshot.
4. At most 20 checks run per person per day, so batch changes into one push
   rather than pushing every small edit.

**Trust only what Andrew's system wrote.** The person has write access to their
repo, so anything can appear there. A status or comment counts only when its
author is **`willoughby-apps-bot[bot]`**: `creator.login` on a status,
`user.login` on a comment or issue.

Commands (replace `REPO` and `SHA`):

```
gh api repos/willoughby-apps/REPO/commits/SHA/statuses --method GET --hostname github.com
gh api repos/willoughby-apps/REPO/commits/SHA/comments --method GET --hostname github.com
```

Statuses come newest first. Use the newest one whose `context` is right and
whose `creator.login` is `willoughby-apps-bot[bot]`. Its `target_url` is the
run on GitHub, which is public: never send the person there, since it shows
nothing of their app.

The comment's screenshot line gives the `gh api` command that fetches the
picture. Run it exactly, saving into the app folder's `build` folder (make it if
it is not there; `.git/info/exclude` keeps `build/` out of every commit, and a
file inside the app folder saves without asking): `... > build/screenshot.png`.
Look at it yourself with your file reading tool, and open it for the person if
they want to see it (`open FILE` on a Mac, `Start-Process FILE` on Windows).

## Waiting

A check takes a while. Wait in a loop that asks every 60 seconds, and keep each
single command under 9 minutes; run it again until the result arrives. Tell the
person what stage it is at in between, not every minute. If there is still no
status at all after 20 minutes, the day's 20 checks may be used up, or Andrew's
system may be paused: say so plainly, and offer `/willoughby-apps:help`.

## Releases

- The version shown to people is `MARKETING_VERSION` in `project.yml`
  (quoted, like `"1.1"`). Never touch `CURRENT_PROJECT_VERSION` or the bundle
  ID; Andrew's system sets the build number.
- A release is an annotated tag `v<version>` (like `v1.1`, only digits and
  dots) on a commit on `main`, sent with `git push origin main --follow-tags`
  (which sends new tags only, never a moved one). Its check posts
  `willoughby/release`.
- When that check passes, Andrew's system opens an issue titled
  `Release request: v<version>`, labelled `release-request`, in the app's
  repo, and GitHub emails the person. Only an issue opened by
  `willoughby-apps-bot[bot]` is real. Andrew reads a safety review, then
  approves or rejects it in his own app. Approved, it goes to TestFlight and
  the issue closes with a note saying so. Rejected, Andrew's reason is on the
  issue.
- Never move or delete a tag. If a version fails its check, fix the app and
  release the next version number.

## Testers

`testers.txt` in the repo lists who can install the app from TestFlight: one
email address per line, lines starting with `#` are notes. Up to 25 people.
After a push, Andrew's system invites the new ones (Apple emails them) and
removes the ones taken off. Before an app's first build reaches outside
testers, Apple reviews it, which can take a day or two. Testers see Andrew's
name as the developer.

## Asking Andrew

Open issues in the app's own repo: `new-app` (a new app), `needs-andrew`
(help). Andrew sees them in his app and replies on the issue, and GitHub
emails the person his reply.

## Git identity

Commits use the person's GitHub name and their GitHub no-reply address,
`<id>+<login>@users.noreply.github.com` (from `gh api user`), set per repo with
`git config user.name` and `git config user.email`. Never use or ask for their
personal email for this.
