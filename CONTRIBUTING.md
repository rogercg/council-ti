# Contributing to The IT Council

Thanks for helping sharpen the board. A few principles keep this project coherent:

## The golden rule: one source of truth

All Council behavior lives in **`core/it-council.md`**. The `adapters/` files carry *only*
per-tool frontmatter — never content. If you change how the Council thinks, change `core/` and
nothing else, then re-run `install.sh` to regenerate.

## Good contributions

- **New lateral tools.** The lateral pass (Inversion, Pre-mortem, Second-order, Analogy,
  Chesterton's Fence, Devil's advocate) is extensible. A new thinking tool should force a member
  to see what the others can't.
- **New tool adapters.** Add a `adapters/<tool>-*.md` with the tool's frontmatter and a branch in
  `install.sh` / `install.ps1`. Keep it to frontmatter.
- **Better examples.** A real run against a real (sanitized) decision is worth more than docs.
- **Sharper lenses.** If a lens asks the wrong question or overlaps another, propose the fix.

## What to avoid

- Don't put content in adapters — it will drift.
- Don't add a lens just to have more lenses. Seven is deliberate; each must catch what the others
  miss. A new lens must justify its non-overlap.
- Don't break zero-verbosity. The Council's value is a tight verdict, not a wall of text.

## Testing a change

Run `./install.sh claude /tmp/testrepo` (create the dir first) and confirm the assembled file =
adapter frontmatter + full core, with no content lost.

## No proprietary data

This is a public, general-purpose framework. Keep examples and text free of any organization's
internal information.
