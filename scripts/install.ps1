param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath,

    [ValidateSet("copy", "link")]
    [string]$Mode = "copy"
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Split-Path -Parent $ScriptDir

if (-not (Test-Path -LiteralPath $ProjectPath)) {
    throw "Project path does not exist: $ProjectPath"
}

$SkillSrc = Join-Path $RepoRoot "skills\engineering-gate\SKILL.md"
$RuleSrc = Join-Path $RepoRoot "rules\project\engineering-gate.md"
$UserRuleSrc = Join-Path $RepoRoot "rules\user\engineering-gate-global.md"

$SkillDstDir = Join-Path $ProjectPath ".agents\skills\engineering-gate"
$RuleDstDir = Join-Path $ProjectPath ".trae\rules"
$SkillDst = Join-Path $SkillDstDir "SKILL.md"
$RuleDst = Join-Path $RuleDstDir "engineering-gate.md"

New-Item -ItemType Directory -Force -Path $SkillDstDir | Out-Null
New-Item -ItemType Directory -Force -Path $RuleDstDir | Out-Null

if ($Mode -eq "link") {
    if (Test-Path -LiteralPath $SkillDst) { Remove-Item -LiteralPath $SkillDst -Force }
    if (Test-Path -LiteralPath $RuleDst) { Remove-Item -LiteralPath $RuleDst -Force }
    New-Item -ItemType SymbolicLink -Path $SkillDst -Target $SkillSrc | Out-Null
    New-Item -ItemType SymbolicLink -Path $RuleDst -Target $RuleSrc | Out-Null
}
else {
    Copy-Item -LiteralPath $SkillSrc -Destination $SkillDst -Force
    Copy-Item -LiteralPath $RuleSrc -Destination $RuleDst -Force
}

Write-Host "Installed engineering gate into project:"
Write-Host "  Skill: $SkillDst"
Write-Host "  Rule : $RuleDst"
Write-Host ""
Write-Host "Next step:"
Write-Host "  Copy the content of the following file into Trae > Settings > Rules > User Rules"
Write-Host "  $UserRuleSrc"
