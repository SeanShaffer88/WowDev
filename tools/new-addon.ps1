# new-addon.ps1 — scaffold a new WoW addon from the WowDev templates.
#
# Usage:
#   .\new-addon.ps1 <AddonName> <flavor> [destination-dir] [-Ace3]
#
# Flavors: retail, era, forever, tbc, wrath, cata, mop, timewalking
# Interface numbers come from tools/interface-numbers.json (checked
# 2026-11-17). WoW Forever is 16001 — never an Era number.
#
# Example:
#   .\new-addon.ps1 MyAddon forever "C:\Games\WoW\Interface\AddOns"
#   .\new-addon.ps1 MyAddon retail .\AddOns -Ace3
param(
    [Parameter(Mandatory = $true, Position = 0)] [string] $Name,
    [Parameter(Mandatory = $true, Position = 1)] [string] $Flavor,
    [Parameter(Position = 2)] [string] $Destination = ".",
    [switch] $Ace3
)

$interfaces = @{
    retail      = 120107
    era         = 11509
    forever     = 16001
    tbc         = 20506
    wrath       = 30405
    cata        = 40402
    mop         = 50504
    timewalking = 38002
}
if (-not $interfaces.ContainsKey($Flavor)) {
    Write-Error "Unknown flavor: $Flavor"
    exit 2
}
$interface = $interfaces[$Flavor]
$template = if ($Ace3) { "ace3" } else { "minimal" }

$src = Join-Path $PSScriptRoot "..\templates\$template"
$out = Join-Path $Destination $Name
if (Test-Path $out) {
    Write-Error "Refusing to overwrite existing folder: $out"
    exit 1
}

Copy-Item -Recurse $src $out

# Rename the template .toc to <AddonName>.toc (the client requires the
# .toc name to match the folder name).
Get-ChildItem "$out\*.toc" | ForEach-Object { Rename-Item $_.FullName "$Name.toc" }

$upper = $Name.ToUpper()
$lower = $Name.ToLower()

# Substitute tokens in every text file. Order matters: the longer
# tokens (with _UPPER/_LOWER suffixes) must go before {{ADDON_NAME}}.
Get-ChildItem -Recurse -File $out |
    Where-Object { $_.Extension -in ".lua", ".toc", ".xml" -or $_.Name -eq ".pkgmeta" } |
    ForEach-Object {
        $text = Get-Content -Raw $_.FullName
        $text = $text.Replace("{{ADDON_NAME_UPPER}}", $upper)
        $text = $text.Replace("{{ADDON_NAME_LOWER}}", $lower)
        $text = $text.Replace("{{ADDON_NAME}}", $Name)
        $text = $text.Replace("{{INTERFACE}}", "$interface")
        $text = $text.Replace("{{TITLE}}", $Name)
        Set-Content -NoNewline $_.FullName $text
    }

Write-Host "Created $out (flavor: $Flavor, interface: $interface, template: $template)"
Write-Host "Verify the interface number against your actual client before shipping:"
Write-Host "  in-game: /run print(select(4, GetBuildInfo()))"
