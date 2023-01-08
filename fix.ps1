param (
    [Parameter(Mandatory)]$unzippedArchiveFolder
)

$likesFile = Join-Path $unzippedArchiveFolder 'data' 'like.js'
$likesJs = Get-Content -Raw -Path $likesFile
$equalsLocation = $likesJs.IndexOf('=') + 1
#$assignment = $likesJs.Substring(0, $equalsLocation)
$likesJson = $likesJs.Substring($equalsLocation)
$likes = ConvertFrom-Json $likesJson
Write-Host "Found like.js with $($likes.count) Tweets"