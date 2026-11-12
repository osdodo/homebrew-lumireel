#!/bin/bash
# Usage: ./update-cask.sh <version>   e.g. ./update-cask.sh 0.1.0
set -euo pipefail

VERSION=${1:?Usage: $0 <version>}
CASK="Casks/lumireel.rb"
BASE="https://github.com/osdodo/lumireel/releases/download/v${VERSION}"

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

# Plain curl works once the repository is public; `gh` covers the private-repo case.
sha() {
  local file="lumireel-${VERSION}-macos-$1.dmg"
  if ! curl -fsSL "$BASE/$file" -o "$tmp/$file" 2>/dev/null; then
    gh release download "v$VERSION" --repo osdodo/lumireel --pattern "$file" --dir "$tmp" --clobber
  fi
  shasum -a 256 "$tmp/$file" | awk '{print $1}'
}
ARM_SHA=$(sha arm64)
INTEL_SHA=$(sha x86_64)

sed -i '' "s/version \".*\"/version \"$VERSION\"/" "$CASK"
sed -i '' "s/arm:   \"[0-9a-f]*\"/arm:   \"$ARM_SHA\"/" "$CASK"
sed -i '' "s/intel: \"[0-9a-f]*\"/intel: \"$INTEL_SHA\"/" "$CASK"

echo "Updated $CASK to $VERSION (arm64 $ARM_SHA, x86_64 $INTEL_SHA)"
