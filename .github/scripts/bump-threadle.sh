#!/usr/bin/env bash
# Update Formula/threadle.rb to the latest upstream release.
# Prints the new version, or nothing if the formula is already current.
set -euo pipefail

formula="Formula/threadle.rb"
upstream="carlnordlund/Threadle"

current=$(sed -nE 's|.*/archive/refs/tags/v([^"]+)\.tar\.gz".*|\1|p' "$formula")
tag=$(gh api "repos/$upstream/releases/latest" --jq .tag_name)
latest=${tag#v}

[[ -n "$latest" && "$latest" != "$current" ]] || exit 0
[[ "$(printf '%s\n%s\n' "$current" "$latest" | sort -V | tail -1)" == "$latest" ]] || exit 0

url="https://github.com/$upstream/archive/refs/tags/$tag.tar.gz"
sha=$(curl -fsSL "$url" | { sha256sum 2>/dev/null || shasum -a 256; } | cut -d' ' -f1)

# New url and sha256; drop the old bottle block so test-bot builds fresh bottles.
python3 - "$formula" "$url" "$sha" <<'PY'
import re, sys
path, url, sha = sys.argv[1:]
s = open(path).read()
s = re.sub(r'^  url ".*"$', f'  url "{url}"', s, count=1, flags=re.M)
s = re.sub(r'^  sha256 ".*"$', f'  sha256 "{sha}"', s, count=1, flags=re.M)
s = re.sub(r'^  bottle do\n.*?^  end\n\n', '', s, count=1, flags=re.M | re.S)
open(path, "w").write(s)
PY
echo "$latest"
