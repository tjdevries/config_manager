param (
    $baseDir = ".",

    $depth = 1,

    $cmd = "status"
)

$gitFolderName = ".git"

function Go () {

    $gitFolders = Get-ChildItem -Path $baseDir -Depth $depth -Recurse -Force | Where-Object { $_.Mode -match "h" -and $_.FullName -like "*\$gitFolderName" }

    ForEach ($gitFolder in $gitFolders) {

      $folder = $gitFolder.FullName -replace $gitFolderName, ""

      Write-Host "Performing git $cmd in folder: '$folder'..." -foregroundColor "green"

      Push-Location $folder

      & git $cmd

      Pop-Location
    }
}

function Main() {
  Go
}

Main
