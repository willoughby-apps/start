---
name: setup
description: First-time setup for making iPhone apps with Andrew. Installs git and the GitHub tool, signs in to GitHub, redeems the invite code from Andrew's message, and puts the person's first app on this computer. Use when someone pastes their invite code or says they are setting up.
argument-hint: <invite code, like ABCD-EFGH>
allowed-tools: Bash(git *) Bash(gh *) PowerShell(git *) PowerShell(gh *)
---

# Setup

The person has just installed Claude and pasted this with an invite code from
Andrew: `$ARGUMENTS`

First read `${CLAUDE_PLUGIN_ROOT}/agents/guide.md` and talk the way it says for
the whole setup, and read `${CLAUDE_PLUGIN_ROOT}/reference/how-it-works.md`.

## Before you start

- **Every step checks first and skips what is already done.** Setup may be run
  again after a restart or a break, with the same code, and must pick up where
  it left off without repeating anything or opening a second enroll issue.
- Start by telling them, in three sentences: you will install two free tools,
  get them signed in to GitHub (the website that keeps their app), and put
  their first app on this computer; it takes 15 to 30 minutes; they will only
  need to click a few buttons and type their own passwords into the windows
  that ask.
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
- Never ask them to type a command. When a window needs them, say exactly what
  it will look like and what to click, then wait for them to tell you it is
  done.

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
   changes to your device?"; click **Yes**.
3. A new install is not on this window's PATH yet. Refresh it with
   `$env:Path = [Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [Environment]::GetEnvironmentVariable('Path','User')`,
   or call `& "$env:ProgramFiles\Git\cmd\git.exe"` directly, and confirm
   `git --version`.

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
(same "allow changes" window: **Yes**), refresh PATH as in step 1 or call
`& "$env:ProgramFiles\GitHub CLI\gh.exe"`, and confirm `gh --version`.

## Step 3: a GitHub account

Check `gh auth status`. If they are signed in already, skip to step 5.

Ask whether they already have a GitHub account. If not, open
`https://github.com/signup` in their browser (`open URL` on a Mac,
`Start-Process URL` on Windows) and walk them through it one screen at a time:
their own email, a password only they know, a username (suggest something
simple like their first and last name; it will be visible to Andrew), the
"verify you're human" puzzle, and the code GitHub emails them. The free plan is
all they need. Wait for them to say they are in.

## Step 4: sign in the GitHub tool

1. Start `gh auth login --web --hostname github.com --git-protocol https` **in
   the background**, with its output going to a file in a temporary folder.
   Without a terminal it does not open a browser; it prints a line
   `First copy your one-time code: XXXX-XXXX` and waits.
2. Read that code from the file. Tell them the code, then open
   `https://github.com/login/device` for them. They type or paste the code,
   click **Continue**, then the green **Authorize** button. The code works for 15
   minutes; if it runs out, start again.
3. Check `gh auth status` every 10 seconds until it says they are logged in.
   Then run `gh auth setup-git` so git uses the same sign-in.
4. Get their username with `gh api user --jq .login` and say it back to them.

## Step 5: redeem the invite code

Say: this sends Andrew's system the code, which gives them access to their app.

1. **Already done?** List pending invitations with
   `gh api user/repository_invitations`, and repos they can already see with
   `gh repo list willoughby-apps --json name`. If either shows a
   `willoughby-apps` repo, skip to step 6.
2. **Already asked?** `gh issue list -R willoughby-apps/pipeline --author @me --state open --json number,title`.
   If one titled `Enroll <username>` is open, do not open another; go to 4 and wait.
3. Otherwise open the enroll issue in the public repo `willoughby-apps/pipeline`,
   with exactly this title and body and nothing else (no email, no other text):

   Title: `Enroll <username>`

   Body (three lines; write it to a temporary file and pass it with
   `--body-file`):

   ```
   <!-- willoughby-enroll v1 -->
   code: ABCD-EFGH
   github: <username>
   ```

   with their code and username in place of the examples:
   `gh issue create -R willoughby-apps/pipeline --title "Enroll <username>" --body-file FILE`.
   Tell them it is a short public note holding only their GitHub username and
   the one-time code, which stops working once it is used.
4. **Wait for the invitation.** Every 30 seconds, check
   `gh api user/repository_invitations` for one whose `repository.owner.login`
   is `willoughby-apps`. It usually arrives within 10 minutes. Meanwhile read
   the comments on their enroll issue (`gh issue view NUMBER -R willoughby-apps/pipeline --comments`);
   a comment from `willoughby-apps-bot[bot]` saying the code was not accepted
   means stop and tell them in plain words. After 30 minutes with nothing,
   stop and write a two-line message they can send Andrew themselves (their
   GitHub username and that the invite has not arrived); do not open more
   issues.
5. Accept each such invitation: `gh api -X PATCH user/repository_invitations/ID`.

## Step 6: put the app on this computer

1. Find Documents (see how-it-works) and make the folder `My Apps` in it if it
   is not there.
2. For each `willoughby-apps` repo they can see that is not already a folder
   there, `gh repo clone willoughby-apps/REPO "<Documents>/My Apps/REPO"`.
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

Add to Claude's own settings file for this person (`~/.claude/settings.json`;
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

Tell them, as the last thing they do with their hands today:
1. On their iPhone, install **TestFlight** from the App Store (free, by Apple).
2. Apple sends an email inviting them to Andrew's team and to test the app.
   Open it **on the iPhone** and accept (tap the link in the email, then
   **Accept** or **View in TestFlight**). If it has not arrived, check spam; it
   can take a while after Andrew sets things up.
3. Open TestFlight. Their app appears there when it is ready.

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
- next time, open Claude in their app's folder (in the Claude app: choose the
  folder `Documents > My Apps > REPO`), or just start Claude and say "let's
  work on my app";
- they can simply say what they want the app to do. The helpers they may hear
  about: check, release, add a tester, status, new app, help.
