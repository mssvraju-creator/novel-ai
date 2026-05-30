$ErrorActionPreference = "Stop"

$source = "C:\Users\dex34\Downloads\ChatGPT Image May 30, 2026, 08_47_34 PM.png"
$root = Split-Path -Parent $PSScriptRoot
$assetDir = Join-Path $root "assets"

New-Item -ItemType Directory -Force -Path $assetDir | Out-Null
Add-Type -AssemblyName System.Drawing

$image = [System.Drawing.Bitmap]::FromFile($source)

function Save-Crop {
    param(
        [string]$Name,
        [int]$X,
        [int]$Y,
        [int]$Width,
        [int]$Height
    )

    $rect = [System.Drawing.Rectangle]::new($X, $Y, $Width, $Height)
    $crop = $image.Clone($rect, $image.PixelFormat)
    $path = Join-Path $assetDir $Name
    $crop.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    $crop.Dispose()
}

function Save-CleanCard {
    param(
        [string]$Name,
        [int]$X,
        [int]$Y,
        [int]$Width,
        [int]$Height,
        [int]$MaskY
    )

    $rect = [System.Drawing.Rectangle]::new($X, $Y, $Width, $Height)
    $crop = $image.Clone($rect, $image.PixelFormat)
    $graphics = [System.Drawing.Graphics]::FromImage($crop)
    $softBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(148, 2, 4, 13))
    $solidBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(246, 2, 4, 13))
    $softY = [Math]::Max(0, $MaskY - 24)
    $graphics.FillRectangle($softBrush, [System.Drawing.Rectangle]::new(0, $softY, $Width, 30))
    $graphics.FillRectangle($solidBrush, [System.Drawing.Rectangle]::new(0, $MaskY, $Width, $Height - $MaskY))
    $graphics.Dispose()
    $softBrush.Dispose()
    $solidBrush.Dispose()
    $path = Join-Path $assetDir $Name
    $crop.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    $crop.Dispose()
}

Save-Crop "hero-castle.png" 358 58 802 333
Save-CleanCard "world-fantasy.png" 30 482 277 181 112
Save-CleanCard "world-scifi.png" 322 482 260 181 112
Save-CleanCard "world-horror.png" 594 482 251 181 112
Save-CleanCard "world-romance.png" 856 482 270 181 112
Save-CleanCard "mode-manual.png" 29 718 258 207 136
Save-CleanCard "mode-assist.png" 299 718 277 207 136
Save-CleanCard "mode-partial.png" 589 718 254 207 136
Save-CleanCard "mode-auto.png" 855 718 272 207 136
Save-CleanCard "character-orion.png" 51 989 172 140 101
Save-CleanCard "character-kai.png" 234 989 167 140 101
Save-CleanCard "character-zane.png" 413 989 166 140 101
Save-CleanCard "character-dax.png" 587 989 162 140 101
Save-CleanCard "character-vex.png" 762 989 164 140 101
Save-CleanCard "character-atlas.png" 938 989 169 140 101
Save-Crop "cta-nebula.png" 29 1141 1102 144

$ctaRect = [System.Drawing.Rectangle]::new(29, 1141, 1102, 144)
$cta = $image.Clone($ctaRect, $image.PixelFormat)
$graphics = [System.Drawing.Graphics]::FromImage($cta)
$clear = [System.Drawing.Color]::FromArgb(0, 2, 4, 13)
$dark = [System.Drawing.Color]::FromArgb(255, 2, 4, 13)
$centerBrush = [System.Drawing.SolidBrush]::new($dark)
$leftFadeRect = [System.Drawing.Rectangle]::new(90, 0, 240, 144)
$rightFadeRect = [System.Drawing.Rectangle]::new(772, 0, 240, 144)
$leftFade = [System.Drawing.Drawing2D.LinearGradientBrush]::new($leftFadeRect, $clear, $dark, 0)
$rightFade = [System.Drawing.Drawing2D.LinearGradientBrush]::new($rightFadeRect, $dark, $clear, 0)
$graphics.FillRectangle($leftFade, $leftFadeRect)
$graphics.FillRectangle($centerBrush, [System.Drawing.Rectangle]::new(330, 0, 442, 144))
$graphics.FillRectangle($rightFade, $rightFadeRect)
$graphics.Dispose()
$leftFade.Dispose()
$rightFade.Dispose()
$centerBrush.Dispose()
$cta.Save((Join-Path $assetDir "cta-clean.png"), [System.Drawing.Imaging.ImageFormat]::Png)
$cta.Dispose()

$image.Dispose()
