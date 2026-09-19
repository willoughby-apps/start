# How a Willoughby app is built and shipped

Facts for Claude. The person you are helping never needs to read this.

## Where things live

- Every app is a **private repo** in the GitHub organization
  **`willoughby-apps`**, named `<guest>-<app>` (the first one is
  `<guest>-hello`). The person is a collaborator on their own repos only.
  `gh repo list willoughby-apps --json name,url` lists the ones they can see.
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
gh api repos/willoughby-apps/REPO/commits/SHA/statuses
gh api repos/willoughby-apps/REPO/commits/SHA/comments
```

Statuses come newest first. Use the newest one whose `context` is right and
whose `creator.login` is `willoughby-apps-bot[bot]`. Its `target_url` is the
run on GitHub, which is public: never send the person there, since it shows
nothing of their app.

The comment's screenshot line tells you how to fetch the picture with `gh api`.
Save it **outside the repo** (a temporary folder), look at it yourself with your
file reading tool, and open it for the person if they want to see it (`open
FILE` on a Mac, `Start-Process FILE` on Windows).

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
- A release is a tag `v<version>` (like `v1.1`, only digits and dots) on a
  commit on `main`, pushed to GitHub. Its check posts `willoughby/release`.
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
