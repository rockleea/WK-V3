param(
    [Parameter(Mandatory = $true)]
    [string]$Path,
    [string]$Version = $env:GITHUB_SHA
)

$textExtensions = @('.html', '.css')
$root = (Resolve-Path -LiteralPath $Path).Path

Get-ChildItem -LiteralPath $root -Recurse -File |
    Where-Object { $textExtensions -contains $_.Extension.ToLowerInvariant() } |
    ForEach-Object {
        $content = [System.IO.File]::ReadAllText($_.FullName)
        if ($_.Extension -ieq '.html') {
            $updated = [regex]::Replace(
                $content,
                '(?i)(?<prefix>\b(?:href|src|action|poster)\s*=\s*["''])/(?!/|WK-V3/)',
                '${prefix}/WK-V3/'
            )
            if ($Version) {
                $updated = [regex]::Replace(
                    $updated,
                    '(?i)(?<prefix>\bsrc\s*=\s*["''][^"'']*/assets/[^"''?]+\.js)(?<suffix>["''])',
                    { param($match) $match.Groups['prefix'].Value + '?v=' + [uri]::EscapeDataString($Version) + $match.Groups['suffix'].Value }
                )
            }
        } else {
            $updated = [regex]::Replace(
                $content,
                '(?i)(?<prefix>url\(\s*["'']?)/(?!/|WK-V3/)',
                '${prefix}/WK-V3/'
            )
        }

        if ($updated -cne $content) {
            [System.IO.File]::WriteAllText(
                $_.FullName,
                $updated,
                [System.Text.UTF8Encoding]::new($false)
            )
        }
    }