# Willoughby Apps: start here

This is the helper that lets you make an iPhone app by talking to Claude, with
Andrew's help. You never need to write code or learn any tools: Claude does the
technical parts and tells you what it is doing.

## You need

- A Claude plan that includes Claude Code (Pro or higher).
- Claude on your computer, Mac or Windows: the Claude desktop app, or Claude in
  a terminal window.
- An iPhone with the free **TestFlight** app from the App Store.
- The invite code from Andrew's message.

## Start

Paste these three lines into Claude, one at a time, with your own code on the
last one:

```
/plugin marketplace add willoughby-apps/start
/plugin install willoughby-apps@willoughby-apps
/willoughby-apps:setup ABCD-EFGH
```

When the second line asks where to install, choose **User scope** (for you, in
every folder).

In the Claude desktop app, if Claude says `/plugin` is not available there,
click the **+** next to the message box, choose **Plugins**, then **Add
plugin**, add the marketplace `willoughby-apps/start`, install
**willoughby-apps** for your user account, and then paste the last line.

Claude then sets up your computer one step at a time and puts your first app on
it. It takes 15 to 30 minutes, and you only click a few buttons.

## After that

Just tell Claude what you want your app to do. It saves your work, checks it
with Andrew's system and shows you a picture of the app. When you want the new
version on your phone, ask Claude to release it; Andrew approves each release.

If you get stuck, ask Claude for help. It can reach Andrew.

## What this repo is

A Claude Code plugin marketplace (`.claude-plugin/marketplace.json`) with one
plugin, `willoughby-apps` (`plugins/willoughby-apps/`): the `setup`, `check`,
`release`, `new-app`, `add-tester`, `remove-tester`, `status` and `help`
skills, a `guide` agent, and the Rules every app follows (`RULES.md`). It is
generated from Andrew's own repository and published here; changes made here
directly are overwritten.
