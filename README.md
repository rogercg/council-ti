<div align="center">

# 🏛️ The IT Council

**A board of 6 AI specialists that stress-tests your technical decisions before they ship.**

Skeptic · Senior · PO · Manager · QA · Custodian — plus a Lead who synthesizes one verdict and *one* next action.

Works in **Claude Code · Kiro · Cursor · GitHub Copilot · any `AGENTS.md` tool**. One source of truth, one command to install.

</div>

---

## Why

One AI reviewing your plan gives you one opinion — usually an agreeable one. Real decisions die
in the room where a skeptical engineer, a security lead, and a project manager attack them from
angles the author never considered.

The IT Council is that room. Six lenses, each answering *only* from its specialty, plus a Lead
who refuses to average them — because the risk lives in the **divergences**, not the consensus.
It's built for the moment before you present a proposal, start a refactor, or merge something
that could break production.

## What makes it different

- **Adversarial by design.** The Skeptic goes first and hunts for hidden cost and evadable
  enforcement. The Custodian can **veto**. Agreement is cheap; the Council is built to find where
  the lenses *disagree*.
- **Vertical + lateral thinking.** Every member does a deep pass in its specialty *and* one
  lateral pass — Inversion, Pre-mortem, Second-order, Analogy, Chesterton's Fence, or Devil's
  advocate. No member is allowed to be predictable.
- **The L-move.** Before the verdict, the Lead escapes the frame *every* lens shared: "we all
  assumed X — what if the real problem is Y?" Then generates three plays nobody proposed and
  discards them on the spot. The one that survives becomes a lateral alternative.
- **Zero verbosity, enforced.** Max 5 bullets per lens. "No findings" is a valid answer. The
  output is a verdict, an impact/effort table, the top 3 risks, and **one** next action — never a
  list of ten.
- **Evidence over opinion.** Every claim carries `file:line`, a metric, or a reproducible command.

## Install

```bash
git clone https://github.com/<you>/council-ti.git && cd council-ti

# pick your tool:
./install.sh claude    /path/to/your/repo   # Claude Code  → /it-council
./install.sh kiro      /path/to/your/repo   # Kiro         → #it-council
./install.sh cursor    /path/to/your/repo   # Cursor       → @it-council
./install.sh copilot   /path/to/your/repo   # Copilot      → /it-council
./install.sh agents-md /path/to/your/repo   # Codex/Gemini/Zed via AGENTS.md
```

Windows: `powershell -ExecutionPolicy Bypass -File install.ps1 <tool> <path>`.
No terminal? Paste `adapters/<tool>*.md` then `core/it-council.md` into the file for your tool.

## Use

```
/it-council  Should we migrate the payments module to the new gateway this quarter?
```

The Council reads what it needs, runs the six lenses, plays the L-move, and returns:

```
## IT Council verdict: GO-CONDITIONAL
Agreement: … · Divergences (risk lives here): …
Impact/Effort: | Item | Impact | Effort | Test cost | Sequence |
Top 3 risks: … · Skeptic's unanswered objections: …
The L-move: … · Lateral alternative: …
Lead's honest read: … · One next action: … by <date> · Kill criteria: …
```

See [`examples/`](examples/) for a full run.

## The 7 lenses

| Lens | Asks |
|---|---|
| 🧨 **Skeptic** | Hidden cost, friction, evadable enforcement, "who pays for this?" |
| 🏗️ **Senior** | Is the alternative idiomatic, incremental, reversible? (cross-service) |
| 🎯 **PO** | What does the business gain, and when? Where's the gold-plating? |
| 📊 **Manager** | Impact/effort, sequence, team capacity, regression cost per release |
| 🧪 **QA** | Regression risk, what to automate first, behavior vs implementation |
| 🔐 **Custodian** | Secrets, PII, authz, cloud exposure, compliance — **can veto** |
| ⚖️ **Lead** | Synthesizes without averaging; verdict + **one** action |

## How it's built

```
core/it-council.md   ← the canonical prompt (the single source of truth)
adapters/*.md        ← per-tool frontmatter only (no content)
install.sh / .ps1    ← assemble adapter + core into your repo
```

Edit the Council = edit `core/` and re-run install. Adapters carry no content, so every tool
stays in sync automatically. To add a tool, add one adapter.

## Contributing

New lenses, new lateral tools, new tool adapters, better examples — all welcome. See
[CONTRIBUTING.md](CONTRIBUTING.md).

## License

[MIT](LICENSE). Use it, fork it, ship it.

---

<div align="center">
<sub>A companion project: <a href="https://github.com/&lt;you&gt;/council">The Council</a> — same board format, aimed at whether an idea makes money.</sub>
</div>
