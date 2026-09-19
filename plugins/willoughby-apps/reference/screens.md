# Screen by screen: the parts only the person can do

Facts for Claude. When a step needs the person's own hands, open the page for
them, then describe **one screen at a time** from here, in plain words, and
wait for them to say what they see before the next. Never ask them to read you
a password or a code from their phone. Pages change: if what they see does not
match, ask them to describe it and help from that.

## GitHub: a new account

Open `https://github.com/signup` (`open URL` on a Mac, `Start-Process URL` on
Windows).

1. **"Welcome to GitHub!"** asks for an email address. Their own email, the one
   they read. Click **Continue**.
2. **A password.** One only they know, at least 15 characters, or at least 8
   with a number and a lower-case letter. It goes into the page, never into
   this chat. **Continue**.
3. **A username.** Letters, digits and single hyphens. Suggest their first and
   last name run together (`samcohen`); if it is taken, GitHub says so and
   they add a number. Andrew will see it. **Continue**.
4. **Email preferences** (a box about product updates). Either is fine.
   **Continue**.
5. **"Verify your account"**: a small puzzle. Click **Verify** and follow it;
   it can take two or three tries.
6. **"You're almost done!"**: GitHub emails an 8-digit **launch code**. They
   open the email from GitHub in their inbox (check spam if it is not there in
   a minute) and type the code into the page. It is for the page only.
7. It may ask how many people are on their team or what they are interested
   in. They can click **Skip personalization** or pick anything; the **Free**
   plan is all they need. Never pick a paid plan.

They are in when they see their GitHub home page.

## GitHub: verifying the email address

If a yellow bar says the email is not verified, or `gh` later reports that the
email must be verified, they open the email **"[GitHub] Please verify your
email address"** and click **Verify email address**. Then carry on.

## GitHub: two-factor authentication

GitHub requires two-factor for accounts it selects as contributors
(docs.github.com, "About mandatory two-factor authentication", read
2026-09-19): it emails them, gives **45 days** to turn it on, then a 7-day
grace, and after that they cannot use GitHub until they do. Email is not a
second factor. Allowed: an **authenticator app** (recommended), **text
message (SMS)**, and as backups a passkey, a security key or GitHub Mobile.

If GitHub asks (a banner, an email, or a page at sign-in), set it up now
rather than later:
1. Open `https://github.com/settings/security` (**Password and
   authentication**) and click **Enable two-factor authentication**.
2. The simplest choice for someone new is **SMS**: pick their country, type
   their mobile number, then the 6-digit code the text brings. (An
   authenticator app is safer; offer it if they already have one.)
3. **Recovery codes.** GitHub shows a list and asks them to save it. They
   click **Download** and keep the file somewhere safe, or print it. Never
   paste the codes here.
4. **"I have saved my recovery codes"**, then **Done**.

## The GitHub tool's sign-in (device code)

This comes from setup's step 4: Claude reads an 8-character code like
`ABCD-1234` and opens `https://github.com/login/device`.

1. If GitHub asks them to sign in first, they do (email or username, and
   password; with two-factor on, the code from their phone).
2. **"Device Activation"**: a row of boxes. They type the code Claude told
   them (or paste it) and click **Continue**.
3. **"Authorize GitHub CLI"**: it lists what the tool may do. They click the
   green **Authorize github** button. It may ask for their password once more.
4. **"Congratulations, you're all set!"** They can close the tab.

The code lasts 15 minutes. If it has run out, Claude starts the sign-in again
and reads a new code.

## Claude: trusting the app folder

The first time Claude opens in their app's folder (`Documents/My Apps/<repo>`),
before anything else, Claude itself asks whether they trust the files in this
folder, and lists what the folder's settings would let Claude do: the `git`
and `gh` commands that save and send their app, and on a Mac `sips` and
`qlmanage` (the icon). The wording and the buttons change between versions of
Claude.

1. Tell them before they open it that this question comes, that the folder is
   their own app from Andrew, and that the list is the commands Claude uses to
   save their app and send it to Andrew's checks.
2. They choose the answer that trusts the folder and carries on (for example
   **Yes, proceed** or **Trust**). It asks once per folder.
3. If they said no, or Claude quit: open it again in the same folder, and
   choose yes this time. Until they do, Claude asks before every command, and
   a check (15 to 30 minutes of waiting) turns into a question every minute.

## Apple: joining Andrew's team

Andrew invites their Apple ID email to his App Store Connect team, so they can
test their own app before anyone else.

1. An email from Apple arrives saying they have been invited to join Andrew's
   team in **App Store Connect**. Check spam if it is not there. It must go to the same email as
   their Apple ID; if Andrew used another address, tell Claude, which asks
   Andrew with `/willoughby-apps:help`.
2. They tap or click **Accept invitation** (or **Join**). A page asks them to
   **sign in with their Apple Account** (the one they use for the App Store on
   their iPhone). Their password goes into Apple's page.
3. **Two-factor**: Apple sends a 6-digit code to their iPhone or by text. They
   type it into the page. If Apple asks them to trust this browser, either
   answer is fine.
4. **Terms**: if a page asks them to review and agree to terms for using App
   Store Connect, they may click **Agree** or **Accept**. If a page asks for
   money, bank or tax details, or to sign a contract, they must stop: that
   is Andrew's side and never theirs. Tell Claude.
5. They land on **App Store Connect** with one app in it, theirs. There is
   nothing to do there. They can close it.

## TestFlight: installing and matching the Apple ID

1. On their iPhone, open the **App Store**, search for **TestFlight** (by
   Apple, free, a blue propeller icon) and tap **Get**.
2. **The same Apple Account.** TestFlight uses the account the iPhone's App
   Store is signed in with. It must be the one Andrew invited. To check: open
   **Settings**, tap their name at the top, and read the email under it. If it
   is different, tell Claude (Andrew can invite that address instead). Never
   sign out of their own phone's account for this.
3. Apple emails a TestFlight invitation when the first version of their app is
   ready: **"<App> is now available to test"** or **"You're invited to test"**.
   Open it **on the iPhone** and tap **View in TestFlight** (or **Start
   Testing**). TestFlight opens.
4. In TestFlight, tap **Accept**, then **Install**. The app appears on the
   home screen with its icon and its name.
5. Later versions show up in TestFlight with an **Update** button (and
   TestFlight can update apps by itself: it offers to turn on automatic
   updates the first time).

A TestFlight version works for 90 days. Andrew's system keeps sending new ones.

## Windows: "Do you want to allow this app to make changes to your device?"

Installing Git or the GitHub tool on Windows shows this box (User Account
Control). It darkens the rest of the screen and may appear behind other
windows: tell them to look for a flashing shield icon on the taskbar if
nothing seems to happen.

1. It names the program (**Git**, **GitHub CLI**, or **App Installer**) and
   **Verified publisher** (for example **Johannes Schindelin** for Git or
   **GitHub, Inc.** for the GitHub tool).
2. They click **Yes**.
3. If instead it asks for an **administrator's user name and password**, their
   Windows account is not an administrator. Someone who knows the
   administrator password types it there; if nobody does, stop and tell
   Claude, which asks Andrew with `/willoughby-apps:help`.
4. If they clicked **No** by mistake, Claude simply runs the install again.
