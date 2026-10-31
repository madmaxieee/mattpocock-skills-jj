# The canonical install block

The personal fork uses the following local installation instructions. Copy this block verbatim into the top-level README.

## Local personal fork

This checkout is the jj-aware personal fork. Install its promoted skills locally:

```bash
bash scripts/link-personal-skills.sh
```

Run this from the checkout. It links `engineering/` and `productivity/` into `~/.agents/skills` and `~/.claude/skills`. To choose a destination, pass its path as an argument. Existing conflicting installations are reported without replacing them; move those aside and rerun. Disable any upstream plugin subscription separately to avoid duplicate skills.

The links use this checkout directly, so local edits are immediately available. Update the checkout with `jj git fetch`, inspect upstream changes, and integrate them with jj; there are no automatic plugin updates for this fork. Restart the agent session to refresh skill discovery. Re-run the linker after adding or renaming skills; remove obsolete links after removing skills.

Run `/setup-matt-pocock-skills` once per project to configure its tracker and docs. The upstream marketplace manifests are retained for reference; they do not publish or install this personal fork.
