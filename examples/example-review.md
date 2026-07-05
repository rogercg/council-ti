# Example run

**Prompt:**

```
/it-council  Should we consolidate our 10 duplicated money-formatting helpers into one
             shared utility this sprint?
```

**Output:**

```
## IT Council verdict: GO-CONDITIONAL

Agreement: the duplication is real and a maintenance liability; a single helper is the right
end-state; the change is small in lines but high in blast radius (money on screen).

Divergences (risk lives here):
- QA vs Manager: Manager sizes it "S, one sprint"; QA says it's S to write, L to verify —
  each of the 10 copies may round differently at the edges (USD, negatives, null, thousands).

Impact/Effort (Manager):
| Item | Impact | Effort | Test cost | Sequence |
| Consolidate 10 → 1 helper | Med | S | High (golden tests) | after golden tests exist |

Top 3 risks:
1. [QA] A rounding divergence in copy #7 reaches production; the ratchet celebrates "-9 copies"
   while hiding the regression the consolidation introduced.
2. [Senior] Callers pass locale/currency inconsistently — the unified API must not force a
   rewrite of every call site.
3. [Skeptic] "One sprint" ignores writing the golden suite; the estimate is optimistic.

Skeptic's unanswered objections (→ FAQ):
- "Who owns the canonical helper after this? If it's a bottleneck, teams will fork it again."

The L-move: everyone assumed we must consolidate *now*. What if the real problem is that there's
no golden test proving the 10 behave the same — so we can't safely consolidate *anything* yet?
  - Play: ship a golden test suite first, consolidate next sprint → SURVIVES.
  - Play: leave duplication, add a lint rule banning new copies → partial, doesn't fix existing.
  - Play: codemod all call sites blindly → discarded, that's the regression.

Lateral alternative: capture the current output of all 10 copies over ~40 boundary amounts as
golden values THIS sprint; consolidate against them next sprint. Correctness-preserving by
construction.

Lead's honest read: the consolidation is right but the sequencing is backwards. Golden tests are
the deliverable this sprint; the merge is a formality once they exist.

The one next action: write a golden-value table for the 10 helpers over boundary amounts — by
Friday.

Success / kill criteria: if the 10 helpers don't produce identical output on the boundary set,
that divergence is a bug to document as a decision — not a merge to rush.
```
