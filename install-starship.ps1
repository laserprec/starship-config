Function Test-CommandExists {

    Param ($command)

    $oldPreference = $ErrorActionPreference

    $ErrorActionPreference = 'stop'

    try { if (Get-Command $command) { RETURN $true } }

    Catch { Write-Host "$command does not exist"; RETURN $false }

    Finally { $ErrorActionPreference = $oldPreference }

} #end function test-CommandExists

Function Install-Choco {
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

$starship_home = "~/.config"

if (-not (Test-Path $starship_home)) { mkdir $starship_home }

# Install choco & Starship
if (-not (Test-CommandExists "choco")) {
    Write-Output ">>>> Installing Choco >>>>"
    Install-Choco
}

if (-not (Test-CommandExists "starship")) {
    Write-Output ">>>> Installing starship >>>>"
    choco install starship
}

Write-Output ">>>> Setting up starship in '$PROFILE' >>>>"

Write-Output "### starship config ###" >> $PROFILE
Write-Output "Invoke-Expression (&starship init powershell)" >> $PROFILE