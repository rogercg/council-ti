#!/usr/bin/env sh
# Install The IT Council into a target repo, for your AI tool of choice.
# Usage: ./install.sh <plugin|claude|kiro|cursor|copilot|agents-md> <target-repo-path>
# Single source of truth: core/it-council.md — adapters only add each tool's frontmatter.
set -e
TOOL="$1"; DEST="$2"; HERE="$(cd "$(dirname "$0")" && pwd)"
CORE="$HERE/core/it-council.md"
[ -n "$TOOL" ] && [ -n "$DEST" ] || { echo "Usage: $0 <plugin|claude|kiro|cursor|copilot|agents-md> <target-repo-path>"; exit 1; }
[ -d "$DEST" ] || { echo "Target does not exist: $DEST"; exit 1; }

case "$TOOL" in
  plugin)
    # Regenerate the Claude plugin's agent + skill from core/ (single source of truth).
    # Run this after editing core/it-council.md, then commit. DEST is ignored (writes into this repo).
    PDIR="$HERE/plugins/it-council"
    mkdir -p "$PDIR/agents" "$PDIR/skills/it-council"
    cat "$HERE/adapters/claude-agent.md" "$CORE" > "$PDIR/agents/it-council.md"
    cat "$HERE/adapters/claude-skill.md" "$CORE" > "$PDIR/skills/it-council/SKILL.md"
    echo "OK — plugin files regenerated from core/ (commit them for /plugin install to work)" ;;
  claude)
    mkdir -p "$DEST/.claude/agents" "$DEST/.claude/skills/it-council"
    cat "$HERE/adapters/claude-agent.md" "$CORE" > "$DEST/.claude/agents/it-council.md"
    cat "$HERE/adapters/claude-skill.md" "$CORE" > "$DEST/.claude/skills/it-council/SKILL.md"
    echo "OK — Claude Code: skill /it-council + agent it-council" ;;
  kiro)
    mkdir -p "$DEST/.kiro/steering"
    cat "$HERE/adapters/kiro-steering.md" "$CORE" > "$DEST/.kiro/steering/it-council.md"
    echo "OK — Kiro: invoke with #it-council (manual steering)" ;;
  cursor)
    mkdir -p "$DEST/.cursor/rules"
    cat "$HERE/adapters/cursor-rule.md" "$CORE" > "$DEST/.cursor/rules/it-council.mdc"
    echo "OK — Cursor: it-council rule (manual @it-council)" ;;
  copilot)
    mkdir -p "$DEST/.github/prompts"
    cat "$HERE/adapters/copilot-prompt.md" "$CORE" > "$DEST/.github/prompts/it-council.prompt.md"
    echo "OK — GitHub Copilot (VS Code): invoke with /it-council in chat" ;;
  agents-md)
    { echo ""; echo "<!-- it-council:start -->"; cat "$CORE"; echo "<!-- it-council:end -->"; } >> "$DEST/AGENTS.md"
    echo "OK — AGENTS.md: read by Codex, Gemini CLI, Zed and other standard tools" ;;
  *) echo "Unsupported tool: $TOOL (use: claude|kiro|cursor|copilot|agents-md)"; exit 1 ;;
esac
