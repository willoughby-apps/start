---
name: icon
description: Make or change the person's app icon, the picture on the iPhone home screen. Works from any picture they have (a photo, a drawing, a logo) or from one they describe ("a blue dumbbell"). Squares it up, shows a preview and asks before using it, then saves it the way Apple needs. Use when they mention the icon, the app's picture, or how the app looks on the home screen.
argument-hint: [a picture's location, or a description]
allowed-tools: Bash(sips *) Bash(qlmanage *) Bash(git *) Bash(gh *) PowerShell(git *) PowerShell(gh *)
---

# The app icon

Read `${CLAUDE_PLUGIN_ROOT}/agents/guide.md` and talk that way, and read
`${CLAUDE_PLUGIN_ROOT}/reference/how-it-works.md` ("The app icon"). What they
said: `$ARGUMENTS`

Apple's rules for the file (checked on every push, rule `app_icon.invalid` in
`${CLAUDE_PLUGIN_ROOT}/RULES.md`): a **PNG**, exactly **1024 by 1024** pixels,
square, **RGB with no alpha channel** (no transparency at all), in sRGB. The
iPhone rounds the corners itself, so the picture stays square with nothing
cut out. Nothing gets installed for this: a Mac has `sips` and `qlmanage`, and
Windows has .NET's drawing library.

## 1. Get the picture

- **They have one.** Ask them to drag it into this window or tell you where it
  is (Desktop, Downloads, Pictures). Look at it yourself with your file
  reading tool. Any common format is fine (PNG, JPEG, HEIC on a Mac, BMP, GIF).
- **They describe one.** Draw it as an SVG file yourself: `viewBox="0 0 1024
  1024"`, width and height 1024, a full background rectangle in a colour (never
  transparent), bold simple shapes, at most one short word, big and centred,
  nothing important in the outer 100 pixels (the corners get rounded). Write it
  to a temporary folder outside the app.
  - **Mac**: `qlmanage -t -s 1024 -o TMPDIR TMPDIR/icon.svg` makes
    `TMPDIR/icon.svg.png`.
  - **Windows**: Microsoft Edge draws it:
    `& "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe" --headless --disable-gpu --hide-scrollbars --window-size=1024,1024 --screenshot="TMPDIR\icon-svg.png" "file:///TMPDIR/icon.svg"`
    (forward slashes in the `file:///` address). If Edge is not there, draw
    the same shapes with the script below's `System.Drawing` calls instead.

## 2. Make it square, 1024, no transparency

Work in the temporary folder, never in the app, until they have said yes.

**Mac** (each is one `sips` command):
1. Read it: `sips -g pixelWidth -g pixelHeight -g hasAlpha PICTURE`.
2. Not square? Ask them **crop** (keep the middle square) or **pad** (show all
   of it on a colour; ask which colour, white if they do not mind), unless the
   picture makes it obvious.
   - crop: `sips -c SIDE SIDE PICTURE --out TMPDIR/square.png` with SIDE the
     smaller of width and height;
   - pad: `sips -p SIDE SIDE --padColor RRGGBB PICTURE --out TMPDIR/square.png`
     with SIDE the larger.
3. `sips -z 1024 1024 TMPDIR/square.png --out TMPDIR/sized.png`
4. Take out the alpha channel and set sRGB, through a best-quality JPEG:
   `sips -s format jpeg -s formatOptions best TMPDIR/sized.png --out TMPDIR/flat.jpg`, then
   `sips -m "/System/Library/ColorSync/Profiles/sRGB Profile.icc" TMPDIR/flat.jpg --out TMPDIR/srgb.jpg`, then
   `sips -s format png TMPDIR/srgb.jpg --out TMPDIR/AppIcon.png`.
   See-through parts turn black this way: if the picture has any (`hasAlpha:
   yes` and it looks cut out), pad it on a colour in step 2 first, or draw it
   again with a background.
5. Check: `sips -g pixelWidth -g pixelHeight -g hasAlpha TMPDIR/AppIcon.png`
   must say 1024, 1024 and `hasAlpha: no`.

**Windows**: one script does all of it (it asks nothing and installs nothing).
Tell them first that Claude will ask before running it, that it only reads
their picture and writes a new one, and that allowing it once is safe:

```
powershell -NoProfile -ExecutionPolicy Bypass -File "${CLAUDE_PLUGIN_ROOT}/scripts/icon.ps1" -In "PICTURE" -Out "TMPDIR\AppIcon.png" -Fit crop -Background FFFFFF
```

`-Fit pad` shows the whole picture on the background colour instead. It writes
a 24-bit RGB PNG (no alpha), so see-through parts land on the background.

## 3. Preview and ask

Look at `TMPDIR/AppIcon.png` yourself, then open it for them (`open FILE` on a
Mac, `Start-Process FILE` on Windows). Say what they are looking at and that
the iPhone will round the corners. Ask: **"Use this as your app's icon?"**
Change it (another crop, a colour, a new drawing) until they say yes.

## 4. Put it in the app

1. The icon set is `App/Assets.xcassets/AppIcon.appiconset/` in the app
   folder. Its `Contents.json` names the file (`"filename" : "AppIcon.png"`).
   Copy the new picture over that file, keeping the name. Never rename it,
   never add a second one, and leave `Contents.json` as it is.
2. Then carry on as the check says (`${CLAUDE_PLUGIN_ROOT}/skills/check/SKILL.md`):
   save, send, and wait. The report shows the icon beside the screenshot, so
   show them both when it arrives. The icon reaches their phone with the next
   release.
