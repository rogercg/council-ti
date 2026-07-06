# Install The IT Council into a target repo (Windows PowerShell 5.1+ / pwsh).
# Usage: .\install.ps1 <claude|kiro|cursor|copilot|agents-md> <target-repo-path>
# Single source of truth: core/it-council.md — adapters only add each tool's frontmatter.
param(
    [Parameter(Mandatory = $true)][ValidateSet("plugin", "claude", "kiro", "cursor", "copilot", "agents-md")]
    [string]$Tool,
    [Parameter(Mandatory = $true)][string]$Dest
)
$ErrorActionPreference = "Stop"
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path
$Core = Join-Path $Here "core/it-council.md"
if (-not (Test-Path $Dest -PathType Container)) { Write-Error "Target does not exist: $Dest" }

function Install-File([string]$AdapterName, [string]$TargetRel) {
    $target = Join-Path $Dest $TargetRel
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $target) | Out-Null
    $adapter = Join-Path $Here "adapters/$AdapterName"
    $content = (Get-Content -Raw -Encoding UTF8 $adapter) + (Get-Content -Raw -Encoding UTF8 $Core)
    [System.IO.File]::WriteAllText($target, $content, (New-Object System.Text.UTF8Encoding $false))
}

switch ($Tool) {
    "claude" {
        Install-File "claude-agent.md" ".claude/agents/it-council.md"
        Install-File "claude-skill.md" ".claude/skills/it-council/SKILL.md"
        Write-Host "OK - Claude Code: skill /it-council + agent it-council"
    }
    "kiro" {
        Install-File "kiro-steering.md" ".kiro/steering/it-council.md"
        Write-Host "OK - Kiro: invoke with #it-council (manual steering)"
    }
    "cursor" {
        Install-File "cursor-rule.md" ".cursor/rules/it-council.mdc"
        Write-Host "OK - Cursor: it-council rule (manual @it-council)"
    }
    "copilot" {
        Install-File "copilot-prompt.md" ".github/prompts/it-council.prompt.md"
        Write-Host "OK - GitHub Copilot (VS Code): invoke with /it-council in chat"
    }
    "agents-md" {
        $target = Join-Path $Dest "AGENTS.md"
        $block = "`n<!-- it-council:start -->`n" + (Get-Content -Raw -Encoding UTF8 $Core) + "<!-- it-council:end -->`n"
        [System.IO.File]::AppendAllText($target, $block, (New-Object System.Text.UTF8Encoding $false))
        Write-Host "OK - AGENTS.md: read by Codex, Gemini CLI, Zed and other standard tools"
    }
}
