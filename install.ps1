#requires -Version 5
# Installs this repo's multi-agent setup into the user's global ~/.claude.
# The repo's .claude/ maps 1:1 onto ~/.claude/.
# Usage (from the repo root): pwsh ./install.ps1

$ErrorActionPreference = 'Stop'

$src        = $PSScriptRoot
$dest       = Join-Path $HOME '.claude'
$agentsDest = Join-Path $dest 'agents'
$claudeDest = Join-Path $dest 'CLAUDE.md'

New-Item -ItemType Directory -Force $agentsDest | Out-Null

# Global CLAUDE.md is overwritten; back up an existing one so nothing is lost.
if (Test-Path $claudeDest) {
    Copy-Item $claudeDest "$claudeDest.bak" -Force
    Write-Host "Backed up existing CLAUDE.md -> CLAUDE.md.bak"
}

Copy-Item (Join-Path $src '.claude/CLAUDE.md')   $claudeDest -Force
Copy-Item (Join-Path $src '.claude/agents/*.md') $agentsDest -Force

Write-Host "Installed delegation rules -> $claudeDest"
Write-Host "Installed subagents        -> $agentsDest"
Write-Host "Per-project: copy AGENTS.md into a project's root to apply the operator spec there."
