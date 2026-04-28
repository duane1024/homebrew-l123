#!/usr/bin/env bash
# Bump Formula/l123.rb to a new tagged release.
# Assumes the tag (vX.Y.Z) has already been pushed to github.com/duane1024/l123.
#
# Usage: ./bump.sh 1.0.1

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "usage: $0 <new-version>   (e.g. 1.0.1)" >&2
  exit 1
fi

new="$1"
formula="Formula/l123.rb"
url="https://github.com/duane1024/l123/archive/refs/tags/v${new}.tar.gz"

tmp="$(mktemp -t l123-bump.XXXXXX.tar.gz)"
trap 'rm -f "$tmp"' EXIT

echo "fetching $url" >&2
curl -fsSL -o "$tmp" "$url"
sha="$(shasum -a 256 "$tmp" | awk '{print $1}')"
echo "sha256 = $sha" >&2

# Replace url and sha256 lines. macOS sed needs `-i ''`.
sed -i '' \
  -e "s|^  url \".*\"|  url \"${url}\"|" \
  -e "s|^  sha256 \".*\"|  sha256 \"${sha}\"|" \
  "$formula"

git add "$formula"
git commit -m "l123 ${new}"
echo "committed. push when ready: git push" >&2
