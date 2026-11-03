param(
    [Parameter(Mandatory = $true)]
    [string]$Path
)

$textExtensions = @('.html', '.css', '.js', '.json', '.xml', '.txt', '.svg')
$root = (Resolve-Path -LiteralPath $Path).Path

Get-ChildItem -LiteralPath $root -Recurse -File |
    Where-Object { $textExtensions -contains $_.Extension.ToLowerInvariant() } |
    ForEach-Object {
        $content = [System.IO.File]::ReadAllText($_.FullName)
        $updated = [regex]::Replace($content, '(?<=["''(])/(?!/|[?#])', '/WK-V3/')

        if ($updated -cne $content) {
            [System.IO.File]::WriteAllText(
                $_.FullName,
                $updated,
                [System.Text.UTF8Encoding]::new($false)
            )
        }
    }