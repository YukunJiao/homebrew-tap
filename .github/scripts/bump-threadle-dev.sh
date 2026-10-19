#!/usr/bin/env bash
# Point Formula/threadle-dev.rb at the newest upstream dev-x.y[.z] branch.
# Prints the new branch name, or nothing if the formula is already current.
set -euo pipefail

formula="Formula/threadle-dev.rb"
upstream="carlnordlund/Threadle"

current=$(sed -nE 's/.*branch: "([^"]+)".*/\1/p' "$formula")
latest=$(gh api --paginate "repos/$upstream/branches" --jq '.[].name' |
  grep -E '^dev-[0-9]+(\.[0-9]+)*$' | sort -V | tail -1)

[[ -n "$latest" && "$latest" != "$current" ]] || exit 0
# Only move forward, never back to an older dev branch.
[[ "$(printf '%s\n%s\n' "$current" "$latest" | sort -V | tail -1)" == "$latest" ]] || exit 0

sed -i.bak -E "s/branch: \"$current\"/branch: \"$latest\"/" "$formula" && rm "$formula.bak"
echo "$latest"
