param(
    [Parameter(Mandatory = $true)]
    [string]$Path
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