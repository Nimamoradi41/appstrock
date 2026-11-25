$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

# Keep the web icon as the single source for every platform.
$projectRoot = Split-Path -Parent $PSScriptRoot
$source = [System.Drawing.Image]::FromFile((Join-Path $projectRoot 'web/icons/Icon-512.png'))

function New-IconPng([int]$Size, [double]$ContentScale = 1) {
    # Opaque white also satisfies the iOS App Store icon requirements.
    $bitmap = [System.Drawing.Bitmap]::new($Size, $Size, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $stream = [System.IO.MemoryStream]::new()
    $attributes = [System.Drawing.Imaging.ImageAttributes]::new()
    try {
        $graphics.Clear([System.Drawing.Color]::White)
        $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
        $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $attributes.SetWrapMode([System.Drawing.Drawing2D.WrapMode]::TileFlipXY)
        $contentSize = [int][Math]::Round($Size * $ContentScale)
        $offset = [int][Math]::Floor(($Size - $contentSize) / 2)
        $rectangle = [System.Drawing.Rectangle]::new($offset, $offset, $contentSize, $contentSize)
        $graphics.DrawImage($source, $rectangle, 0, 0, $source.Width, $source.Height, [System.Drawing.GraphicsUnit]::Pixel, $attributes)
        $bitmap.Save($stream, [System.Drawing.Imaging.ImageFormat]::Png)
        return ,$stream.ToArray()
    } finally {
        $attributes.Dispose()
        $stream.Dispose()
        $graphics.Dispose()
        $bitmap.Dispose()
    }
}

function Save-Icon([string]$Path, [int]$Size, [double]$ContentScale = 1) {
    [System.IO.File]::WriteAllBytes((Join-Path $projectRoot $Path), (New-IconPng $Size $ContentScale))
}

try {
    $androidSizes = @{ mdpi = 48; hdpi = 72; xhdpi = 96; xxhdpi = 144; xxxhdpi = 192 }
    foreach ($density in $androidSizes.Keys) {
        Save-Icon "android/app/src/main/res/mipmap-$density/ic_launcher.png" $androidSizes[$density]
    }

    foreach ($platform in @('ios', 'macos')) {
        $catalog = "$platform/Runner/Assets.xcassets/AppIcon.appiconset"
        $contents = Get-Content -Raw (Join-Path $projectRoot "$catalog/Contents.json") | ConvertFrom-Json
        foreach ($entry in $contents.images) {
            $size = [double]($entry.size.Split('x')[0]) * [double]($entry.scale.TrimEnd('x'))
            Save-Icon "$catalog/$($entry.filename)" ([int]$size)
        }
    }

    Save-Icon 'web/favicon.png' 32
    Save-Icon 'web/icons/Icon-180.png' 180
    Save-Icon 'web/icons/Icon-192.png' 192
    # Keep all artwork inside the central safe area for circular/squircle masks.
    Save-Icon 'web/icons/Icon-maskable-192.png' 192 0.7
    Save-Icon 'web/icons/Icon-maskable-512.png' 512 0.7

    # ICO contains a separate image for each common Windows display size.
    $sizes = @(16, 24, 32, 48, 64, 128, 256)
    $frames = @($sizes | ForEach-Object { ,(New-IconPng $_) })
    $iconStream = [System.IO.MemoryStream]::new()
    $writer = [System.IO.BinaryWriter]::new($iconStream)
    try {
        $writer.Write([uint16]0)
        $writer.Write([uint16]1)
        $writer.Write([uint16]$sizes.Count)
        $offset = 6 + 16 * $sizes.Count
        for ($i = 0; $i -lt $sizes.Count; $i++) {
            $dimension = if ($sizes[$i] -eq 256) { 0 } else { $sizes[$i] }
            $writer.Write([byte]$dimension)
            $writer.Write([byte]$dimension)
            $writer.Write([byte]0)
            $writer.Write([byte]0)
            $writer.Write([uint16]1)
            $writer.Write([uint16]24)
            $writer.Write([uint32]$frames[$i].Length)
            $writer.Write([uint32]$offset)
            $offset += $frames[$i].Length
        }
        foreach ($frame in $frames) { $writer.Write([byte[]]$frame) }
        $writer.Flush()
        [System.IO.File]::WriteAllBytes((Join-Path $projectRoot 'windows/runner/resources/app_icon.ico'), $iconStream.ToArray())
    } finally {
        $writer.Dispose()
        $iconStream.Dispose()
    }
} finally {
    $source.Dispose()
}

Write-Output 'Updated Android, iOS, macOS, Windows and web icons from web/icons/Icon-512.png.'
