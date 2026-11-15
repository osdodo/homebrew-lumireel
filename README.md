# Homebrew Tap for lumireel

Homebrew tap for [lumireel](https://github.com/osdodo/lumireel).

## Installation

Homebrew 7 and later require trusting the tap before installing:

```bash
brew trust osdodo/lumireel
brew install --cask osdodo/lumireel/lumireel
```

The app is ad-hoc signed, not notarized. The cask removes the quarantine
attribute after install so Gatekeeper does not report it as damaged. If you
installed the app another way (e.g. the DMG) and macOS blocks it:

```bash
xattr -dr com.apple.quarantine /Applications/lumireel.app
```

## Updating the cask

After a `vX.Y.Z` release is published on osdodo/lumireel:

```bash
./update-cask.sh X.Y.Z
git commit -am "lumireel X.Y.Z"
```
