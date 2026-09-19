# Willoughby Apps: start here

This is the helper that lets you make an iPhone app by talking to Claude, with
Andrew's help. You never need to write code or learn any tools: Claude does the
technical parts and tells you what it is doing.

## You need

- Claude Code on your computer, Mac or Windows, with a Claude plan that
  includes it (Pro or higher).
- An iPhone with the free **TestFlight** app from the App Store.
- Andrew's message, which holds your invite code.

## Start

Open Claude Code and paste in the part of Andrew's message that starts with
"Hi Claude.", all at once. That is the only thing you paste. Claude then:

1. installs git if your computer does not have it yet;
2. adds this helper with `claude plugin marketplace add willoughby-apps/start`
   and `claude plugin install willoughby-apps@willoughby-apps`, and turns on
   its automatic updates;
3. reads `setup.md` (in this repo) and follows it at once, with no restart:
   it installs the GitHub tool, gets you signed in to GitHub, redeems your
   code and puts your first app on your computer.

It takes 15 to 30 minutes, and you only click a few buttons and type your own
passwords. (If the helper is already installed, `/willoughby-apps:setup ABCD-EFGH`
with your own code runs the same setup.)

## After that

Just tell Claude what you want, like "make me a gym app for tracking
workouts". Your first idea turns the starter app into that app. Claude builds
it, has Andrew's system check it, shows you pictures of it and asks "Send it to
Andrew?". Andrew approves each version, and it arrives in TestFlight on your
phone: usually 20 to 40 minutes from an idea, plus the time Andrew takes.

Making an app uses a good share of a Claude Pro plan's usage. If Claude says
you have reached your limit, nothing is lost: come back when it says and say
"keep going". If you get stuck, ask Claude for help. It can reach Andrew.

## What this repo is

A Claude Code plugin marketplace (`.claude-plugin/marketplace.json`) with one
plugin, `willoughby-apps` (`plugins/willoughby-apps/`): the `setup`, `make`,
`check`, `icon`, `release`, `new-app`, `add-tester`, `remove-tester`, `status`
and `help` skills, a `guide` agent, screen-by-screen guides
(`reference/screens.md`), and the Rules every app follows (`RULES.md`).
`setup.md` is the setup skill as a plain file, for the first session. It is
generated from Andrew's own repository and published here; changes made here
directly are overwritten.
