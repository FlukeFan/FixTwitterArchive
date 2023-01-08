param (
    [Parameter(Mandatory)]$unzippedArchiveFolder
)

$ErrorActionPreference = "Stop"

$likesFile = Join-Path $unzippedArchiveFolder 'data' 'like.js'
$likesJs = Get-Content -Raw -Path $likesFile
$equalsLocation = $likesJs.IndexOf('=') + 1
$assignment = $likesJs.Substring(0, $equalsLocation)
$likesJson = $likesJs.Substring($equalsLocation)
$likes = ConvertFrom-Json $likesJson
Write-Host "Found like.js with $($likes.count) Tweets"

$fixCount = 0
ForEach ($like in $likes) {
    if ($null -eq $like.like.fullText) {
        $like.like | Add-Member -MemberType NoteProperty -Name 'fullText' -Value '<i>Full text is not available</i>'
        $fixCount++
    }
}

Write-Host "Fixed ${fixCount} Tweets"

$fixedJson = ConvertTo-Json $likes
$fixedJs = $assignment + $fixedJson

$renamedLikesFile = $likesFile + ".backup.$(Get-Date -format 'yyyy-MM-dd_HH-mm-ss')"
Write-Host "Renaming like.js to ${renamedLikesFile}"
Rename-Item -Path $likesFile -NewName $renamedLikesFile
Set-Content -Path $likesFile -Value $fixedJs
