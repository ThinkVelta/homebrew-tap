#!/usr/bin/env python3
"""Fail if a cask's caveats tell users to run a flag that does not exist.

No brew check reads caveats prose, so this is the one defect class the standard
tooling cannot see. This tap shipped exactly that bug: caveats instructing
`brew install --cask --no-quarantine`, which Homebrew 6 rejects outright and
also ignores via HOMEBREW_CASK_OPTS.

Reads the rendered caveats rather than the cask source, so a source comment
explaining that a flag is fake does not trip it.

Usage: brew info --json=v2 --cask <token> | check-caveats.py <token>
"""

import json
import sys

# Flags that read like install advice but are not real. Add to this as we find
# more; every entry should be one somebody could plausibly write.
DEAD_FLAGS = ("--no-quarantine",)


def main() -> int:
    token = sys.argv[1] if len(sys.argv) > 1 else "cask"
    try:
        casks = json.load(sys.stdin).get("casks") or []
    except json.JSONDecodeError as exc:
        print(f"::error::{token}: could not parse `brew info --json=v2` output: {exc}")
        return 1

    if not casks:
        print(f"::error::{token}: `brew info --json=v2` returned no cask.")
        return 1

    caveats = casks[0].get("caveats") or ""
    named = [flag for flag in DEAD_FLAGS if flag in caveats]
    if named:
        print(
            f"::error::{token}: caveats tell users to run {', '.join(named)}, "
            "which Homebrew rejects. Point them at System Settings or "
            "`xattr -d com.apple.quarantine` instead."
        )
        return 1

    print(f"{token}: caveats name no dead flags")
    return 0


if __name__ == "__main__":
    sys.exit(main())
