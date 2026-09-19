<!-- GENERATED from plugins/willoughby-apps/skills/setup/SKILL.md. Do not edit by hand:
     the publish step refuses a copy that differs from the skill. -->

# Willoughby Apps: setup guide for Claude

These are the same steps as the `willoughby-apps` plugin's setup skill
(`/willoughby-apps:setup`). Andrew's message asks Claude to read this file
right after adding the helper, so setup starts at once, with no restart.

Every path below that starts with `plugins/willoughby-apps/` is inside the
folder that holds this file: on a Mac
`~/.claude/plugins/marketplaces/willoughby-apps/`, on Windows
`%USERPROFILE%\.claude\plugins\marketplaces\willoughby-apps\`. If that
folder is missing, read the same path from
`https://raw.githubusercontent.com/willoughby-apps/start/main/`.

# Setup

The person pasted Andrew's setup message, or their invite code.
Their invite code is in the message they pasted.

First read `plugins/willoughby-apps/agents/guide.md` and talk the way it says for
the whole setup, and read `plugins/willoughby-apps/reference/how-it-works.md`
and `plugins/willoughby-apps/reference/screens.md` (every screen they will see,
one at a time).

## Before you start

- **Every step checks first and skips what is already done.** Setup may be run
  again after a restart or a break, with the same code, and must pick up where
  it left off without repeating anything or opening a second enroll issue.
- Start by telling them, in three sentences: you will install two free tools,
  get them signed in to GitHub (the website that keeps their app), and put
  their first app on this computer; it takes 15 to 30 minutes; they will only
  need to click a few buttons and type their own passwords into the windows
  that ask.
- The helper itself (this guide) is already installed: the message they pasted
  had you add it. If git was installed for that, step 1 finds it and moves on.
- **The invite code** is 8 letters and digits, shown like `ABCD-EFGH`. Ignore
  case, spaces and a missing dash; write it as four characters, a dash, four
  characters, in capitals. It never contains 0, O, 1, I or L. If it is missing
  or does not look like that, ask them to copy it from Andrew's message.
- Work out which computer this is: a Mac if `uname -s` prints `Darwin`,
  Windows if you are using PowerShell or `$env:OS` is `Windows_NT`. Say which
  you found ("You're on a Mac, so...").
- On Windows you may have PowerShell only, or Git Bash too once Git is
  installed. Use whichever shell tool you have; the `git` and `gh` commands are
  the same in both, only quoting differs.
- **Windows, after you install Git or `gh` in this setup:** each command you
  run may start from the PATH Claude had when it started, before the install,
  so a bare `git` or `gh` can fail with "is not recognized" even right after it
  worked. From then on, for the rest of this setup, start **every** PowerShell
  command with the refresh

  ```
  $env:Path = [Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [Environment]::GetEnvironmentVariable('Path','User');
  ```

  followed by the command itself, in the same command. (The next time Claude
  starts, the new tools are on its PATH and this is no longer needed.)
- Never ask them to type a command. When a window needs them, say exactly what
  it will look like and what to click, then wait for them to tell you it is
  done.
- **Permission questions.** Many commands here (installers, downloads, `open`,
  `winget`, `xcode-select`) make Claude ask them first whether it may run the
  command, showing the command itself. Before the first one, tell them: "Claude
  will sometimes ask you before it runs something on your computer. I will say
  what each one is for; choose the option that allows it this once." Then
  before each such command say in one sentence what it does ("This downloads
  GitHub's installer from GitHub."). Never ask them to allow something always.

## Step 1: git

Say: git is the free tool that saves each version of their app.

**Mac.** Check `xcode-select -p`. If it fails, the tools are missing (do not run
`git` to find out: on a new Mac that pops up a window by itself). Explain that
Apple's free "command line developer tools" include git, then run
`xcode-select --install`. Tell them: a window appears saying the command needs
the tools; click **Install**, then **Agree**; it takes 5 to 15 minutes; they
can tell you when it says the software was installed. Then check
`xcode-select -p` every 30 seconds until it succeeds, and confirm with
`git --version`.

**Windows.** Check `git --version`. If it is missing:
1. Check `winget --version`. If winget is missing, run
   `Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe`
   and check again. If it is still missing, open
   `https://apps.microsoft.com/detail/9nblggh4nns1` (Microsoft's App
   Installer) with `Start-Process`, ask them to click **Get** or **Update**,
   and check again when they say it is done.
2. Run `winget install --id Git.Git -e --source winget --accept-package-agreements --accept-source-agreements`.
   Tell them first: Windows may ask "Do you want to allow this app to make
   changes to your device?"; click **Yes** (screens.md, "Windows").
3. A new install is not on Claude's PATH yet. Confirm with the refresh and
   `git --version` in one command (see "Windows, after you install" above),
   and keep starting every later PowerShell command in this setup with that
   refresh.

## Step 2: the GitHub tool (`gh`)

Say: this lets you talk to GitHub for them, so they never have to use the
website for their app.

Check `gh --version`. If it is missing:

**Mac.** Use GitHub's own installer.
1. Read `https://api.github.com/repos/cli/cli/releases/latest` with `curl -fsSL`
   and take the asset named `gh_<version>_macOS_universal.pkg` and the
   `gh_<version>_checksums.txt` asset.
2. Download both into a new temporary folder (`mktemp -d`) with `curl -fsSL -o`.
3. Compare `shasum -a 256` of the package with its line in the checksums file.
   If it differs, delete it, stop, and tell them the download was damaged and
   you will try again.
4. Run `open` on the package. Tell them: the Installer opens; click
   **Continue**, **Continue**, **Agree**, **Install**; type their Mac password
   **into the Installer's window** (never into this chat); then **Close**.
5. Check `gh --version` every 15 seconds until it works (if this shell does not
   find it yet, try `/usr/local/bin/gh --version`).

**Windows.** Run
`winget install --id GitHub.cli -e --source winget --accept-package-agreements --accept-source-agreements`
(same "allow changes" window: **Yes**), then confirm with the refresh and
`gh --version` in one command, and keep the refresh on every later PowerShell
command in this setup.

## Step 3: a GitHub account

Check `gh auth status`. If they are signed in already, skip to step 5.

Ask whether they already have a GitHub account. If not, open
`https://github.com/signup` in their browser (`open URL` on a Mac,
`Start-Process URL` on Windows) and walk them through it one screen at a time
exactly as screens.md says ("GitHub: a new account"): their own email, a
password only they know, a username (it will be visible to Andrew), the
"verify you're human" puzzle, and the launch code GitHub emails them. The free
plan is all they need. Wait for them to say they are in. If GitHub asks for
email verification or two-factor now or later, screens.md has those screens
too.

## Step 4: sign in the GitHub tool

1. Start `gh auth login --web --hostname github.com --git-protocol https` **in
   the background**, with **both** its output and its error stream going to
   files in a temporary folder: gh prints the code on the error stream, and
   plain output stays empty. In Bash, end the command with `> FILE 2>&1`; in
   PowerShell use `Start-Process` with both `-RedirectStandardOutput OUT` and
   `-RedirectStandardError ERR` (two different files) and read both. Without a
   terminal it does not open a browser; it prints a line
   `First copy your one-time code: XXXX-XXXX` and waits.
2. Read that code from the files. Tell them the code, then open
   `https://github.com/login/device` for them and walk them through it
   (screens.md, "The GitHub tool's sign-in"): they type or paste the code,
   click **Continue**, then the green **Authorize** button. The code works for
   15 minutes; if it runs out, start again.
3. Check `gh auth status` every 10 seconds until it says they are logged in.
   Then run `gh auth setup-git` so git uses the same sign-in.
4. Get their username with `gh api user --jq .login` and say it back to them.

## Step 5: redeem the invite code

Say: this sends Andrew's system the code, which gives them access to their app.

1. **Already done?** List pending invitations with
   `gh api user/repository_invitations`, and their apps as how-it-works says
   under "Their apps" (private repos they can push to, never `pipeline`,
   `start` or `app-template`; the first two are public, so every account sees
   them). If there is an
   invitation from `willoughby-apps` or at least one app, skip to step 5's
   part 5 (accept) and then step 6.
2. **Already asked?** `gh issue list -R willoughby-apps/pipeline --author @me --state all --json number,createdAt`.
   If they opened one in the last 30 minutes, do not open another; go to 4
   and wait on it. Never open more than three in a day: after that the code
   is not even checked.
3. Otherwise open the enroll issue in the public repo `willoughby-apps/pipeline`,
   with exactly this title and body and nothing else (no email, no other text):

   Title: `Enroll <username>`

   Body (three lines; write it to a temporary file with your own file-writing
   tool, which saves plain UTF-8, and pass it with `--body-file`; on Windows
   never write it with `Set-Content` or `Out-File`, which add an invisible
   mark at the start that makes the request unreadable):

   ```
   <!-- willoughby-enroll v1 -->
   code: ABCD-EFGH
   github: <username>
   ```

   with their code and username in place of the examples:
   `gh issue create -R willoughby-apps/pipeline --title "Enroll <username>" --body-file FILE`.
   Tell them it is a short public note holding only their GitHub username and
   the one-time code, which stops working once it is used.
4. **Wait for the invitation.** Within a minute or two the issue is emptied,
   closed and locked, with one comment from `github-actions[bot]` (read it
   with `gh issue view NUMBER -R willoughby-apps/pipeline --comments`; ignore
   comments from anyone else). The comment never says whether the code was
   right; it only says the request was read, or that it was not in the right
   form (then check the code and the username and open one new issue), or
   that there were too many requests today (then go straight to the message
   for Andrew below). Every 30 seconds, check
   `gh api user/repository_invitations` for one whose `repository.owner.login`
   is `willoughby-apps`. If none has arrived 10 minutes after the comment,
   stop and write a two-line message they can send Andrew themselves (their
   GitHub username and that the invite has not arrived); do not open more
   issues.
5. Accept each such invitation: `gh api -X PATCH user/repository_invitations/ID`.

## Step 6: put the app on this computer

1. Find Documents (see how-it-works) and make the folder `My Apps` in it if it
   is not there.
2. For each of their apps (how-it-works, "Their apps": private, one they can
   push to, never `pipeline`, `start` or `app-template`) that is not already a
   folder there, `gh repo clone willoughby-apps/REPO "<Documents>/My Apps/REPO"`.
3. In each new folder:
   - set the git identity from `gh api user` (name, or the login if they have
     no name; email `<id>+<login>@users.noreply.github.com`) with
     `git config user.name` and `git config user.email` (never `--global`);
   - add these lines to `.git/info/exclude` if missing: `.DS_Store`,
     `Thumbs.db`, `desktop.ini`, `build/`, `*.xcodeproj/`, `*.xcworkspace/`,
     `screenshot*.png`.
4. **Do not change, commit or push anything in the app.** The first version is
   Andrew's starter app exactly as it is; changing it now would stop it going
   to their phone without a review.
5. Tell them where the folder is, in words they can find ("In your Documents
   folder there is now a folder called My Apps, and inside it
   `sam-hello`. That is your app.").

## Step 7: keep this helper up to date

Say: this makes the helper update itself when Andrew improves it.

The message they pasted usually did this already: read the file first, and
skip this step when the entry below is there with `"autoUpdate": true`.
Otherwise add to Claude's own settings file for this person (`~/.claude/settings.json`;
on Windows `%USERPROFILE%\.claude\settings.json`) the entry below, merged into
whatever is already there (read it first, keep every other setting, write
valid JSON, create the file if it does not exist):

```json
{
  "extraKnownMarketplaces": {
    "willoughby-apps": {
      "source": { "source": "github", "repo": "willoughby-apps/start" },
      "autoUpdate": true
    }
  }
}
```

Third-party marketplaces do not update by themselves unless `autoUpdate` is
on. Changes apply the next time Claude starts.

## Step 8: TestFlight

Walk them through, as the last things they do with their hands today, one
screen at a time from screens.md:
1. **Joining Andrew's team** ("Apple: joining Andrew's team"): Apple's email
   inviting them to App Store Connect, signing in with their Apple Account,
   the code on their phone, and any terms. If it has not arrived, check spam;
   it can take a while after Andrew sets things up, and this step can wait.
2. **TestFlight** ("TestFlight: installing and matching the Apple ID"): install
   it on their iPhone, and check the iPhone's Apple Account is the one Andrew
   invited.
3. When the first version is ready, Apple emails a TestFlight invitation;
   they open it on the iPhone and tap **View in TestFlight**, then **Install**.

## Step 9: show the app is on its way

For their first app repo, get the newest commit on `main`
(`gh api repos/willoughby-apps/REPO/commits/main --jq .sha`) and read its
`willoughby/check` status from `willoughby-apps-bot[bot]` (how-it-works has the
command and the rule about whose status counts).

- **success**: fetch the screenshot from the bot's comment, look at it, and
  open it for them: "This is your app, built and checked. Andrew's system is
  putting it on TestFlight; it will show up in the TestFlight app on your
  phone."
- **pending** or no status yet: "Andrew's system is checking and building your
  app now. It takes up to half an hour." Offer to wait with them (as
  how-it-works describes) and show the picture when it arrives.
- **failure** or **error** on the untouched starter app is Andrew's problem,
  not theirs: say so and offer `/willoughby-apps:help`.

## Finish

End with, in plain words:
- setup is done, and what is on its way;
- next time, open Claude in their app's folder (in a terminal: `cd` there
  first, which you can do for them now by saying where it is; in the Claude
  app: choose the folder `Documents > My Apps > REPO`), or just start Claude
  and say "let's work on my app";
- from now on they only say what they want, like **"make me a gym app for
  tracking workouts"**. Their first idea turns the starter app into that app,
  in place. You build it, have it checked, show them pictures, and ask "Send
  it to Andrew?"; after his OK it arrives in TestFlight. From an idea to their
  phone is usually 20 to 40 minutes plus Andrew's approval;
- making an app uses a good share of a Claude Pro plan's usage. If Claude says
  the limit is reached, nothing is lost: come back when it says, and say "keep
  going";
- they can offer it an icon any time: a picture of their own, or a
  description.

If they would like to start right now, ask what the app should be and carry
on with `plugins/willoughby-apps/skills/make/SKILL.md` in the app's folder.
