---
name: code-reviewer
description: Review Flutter changes for correctness, regressions, and project-fit issues before merge.
---

# Run the review

From the repository root, select the review target requested by the user:

- For working-tree changes, use `--uncommitted`.
- For a branch comparison, use `--base <branch>`.
- For one commit, use `--commit <sha>`.

Run exactly one appropriate review command using this shape:

```bash
codex exec -s read-only review \
  --uncommitted \
  --model gpt-5.6-sol \
  --config 'model_reasoning_effort="high"' \
  --commentary \
  'Review this Flutter project. Follow AGENTS.md and the official Flutter and Dart AI rules linked there. Focus on concrete bugs, regressions, unsafe async or lifecycle behavior, missing tests, accessibility problems, and material maintainability issues. Do not modify files. Return prioritized findings with file and line references.'
```

Replace only the target flag when reviewing a base branch or commit. Keep the model as `gpt-5.6-sol`, reasoning effort as `high`, sandbox as `read-only`, and the run ephemeral. Never add `--dangerously-bypass-approval-and-sandbox`.

# Report findings

Report prioritized findings with file and line references, and keep the review focused on concrete issues.
