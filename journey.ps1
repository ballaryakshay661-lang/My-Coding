
param(
    [ValidateSet("start", "save", "status")]
    [string]$Action = "start"
)

Set-Location $PSScriptRoot

if ($Action -eq "start") {

    $days = Get-ChildItem -Directory -Name "Day-*" |
        ForEach-Object {
            if ($_ -match '^Day-(\d+)$') {
                [int]$Matches[1]
            }
        }

    $nextDay = if ($days) {
        ($days | Measure-Object -Maximum).Maximum + 1
    } else {
        1
    }

    $folder = "Day-$nextDay"

    New-Item -ItemType Directory -Name $folder | Out-Null

    @"
# $folder

## Today's Goals

## Work Completed

## Technologies Used

## What I Learned

## Problems Solved
"@ | Set-Content "$folder\README.md"

    Write-Host "Created $folder successfully!" -ForegroundColor Green

    code "$PSScriptRoot\$folder"
}

elseif ($Action -eq "save") {

    git add -A

    if ($LASTEXITCODE -ne 0) {
        throw "Git add failed"
    }

    git diff --cached --quiet

    if ($LASTEXITCODE -eq 0) {
        Write-Host "No changes to save."
        exit
    }

    $message = "Daily coding progress - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"

    git commit -m $message

    if ($LASTEXITCODE -ne 0) {
        throw "Commit failed"
    }

    git push origin main

    if ($LASTEXITCODE -ne 0) {
        throw "Push failed. Your commit is saved locally."
    }

    Write-Host "GitHub updated successfully!" -ForegroundColor Green
}

elseif ($Action -eq "status") {
    git status
    git log -5 --oneline
}
