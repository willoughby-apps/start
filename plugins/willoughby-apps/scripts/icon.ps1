# Make an iPhone app icon on Windows with nothing installed: .NET's
# System.Drawing (part of Windows PowerShell and of PowerShell 7 on Windows).
#
#   powershell -NoProfile -ExecutionPolicy Bypass -File icon.ps1 -In PICTURE -Out AppIcon.png [-Fit crop|pad] [-Background FFFFFF]
#
# Writes a 1024x1024 PNG, 8-bit RGB with no alpha channel (a 24-bit bitmap
# saved as PNG), in sRGB (System.Drawing's working colour space). `crop` keeps
# the middle square of the picture; `pad` shows all of it on a square of the
# background colour. Transparent parts of the picture land on the background.
# Prints one line: `icon WIDTHxHEIGHT from WxH (fit)`.
param(
  [Parameter(Mandatory = $true)][string]$In,
  [Parameter(Mandatory = $true)][string]$Out,
  [ValidateSet('crop', 'pad')][string]$Fit = 'crop',
  [ValidatePattern('^[0-9A-Fa-f]{6}$')][string]$Background = 'FFFFFF'
)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

$size = 1024
$src = [System.Drawing.Image]::FromFile((Resolve-Path -LiteralPath $In).Path)
try {
  $bmp = New-Object System.Drawing.Bitmap $size, $size, ([System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  try {
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $r = [Convert]::ToInt32($Background.Substring(0, 2), 16)
    $gr = [Convert]::ToInt32($Background.Substring(2, 2), 16)
    $b = [Convert]::ToInt32($Background.Substring(4, 2), 16)
    $g.Clear([System.Drawing.Color]::FromArgb(255, $r, $gr, $b))
    $w = $src.Width; $h = $src.Height
    if ($Fit -eq 'crop') {
      $side = [Math]::Min($w, $h)
      $from = New-Object System.Drawing.Rectangle ([int](($w - $side) / 2)), ([int](($h - $side) / 2)), $side, $side
      $to = New-Object System.Drawing.Rectangle 0, 0, $size, $size
    } else {
      $scale = $size / [Math]::Max($w, $h)
      $dw = [int]($w * $scale); $dh = [int]($h * $scale)
      $from = New-Object System.Drawing.Rectangle 0, 0, $w, $h
      $to = New-Object System.Drawing.Rectangle ([int](($size - $dw) / 2)), ([int](($size - $dh) / 2)), $dw, $dh
    }
    $g.DrawImage($src, $to, $from, [System.Drawing.GraphicsUnit]::Pixel)
  } finally { $g.Dispose() }
  if ([System.IO.Path]::IsPathRooted($Out)) { $outPath = [System.IO.Path]::GetFullPath($Out) }
  else { $outPath = [System.IO.Path]::GetFullPath((Join-Path (Get-Location).Path $Out)) }
  $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
  $bmp.Dispose()
  "icon ${size}x${size} from ${w}x${h} ($Fit)"
} finally { $src.Dispose() }
