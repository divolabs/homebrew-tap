# Typebird Homebrew tap

The Homebrew tap for [Typebird](https://typebird.app) — three AI buttons
(Improve Writing, Translate, Tone Check) on the text you have selected,
anywhere on your Mac.

```sh
brew install --cask typebird-app/tap/typebird
```

Naming the tap inline is deliberate, not shorthand: Homebrew 6 refuses to load
a cask from an untrusted third-party tap unless the tap is named in the command
itself, so the familiar two-step form needs a trust step in between —

```sh
brew tap typebird-app/tap
brew trust typebird-app/tap
brew install --cask typebird
```

— and the one-liner above skips it. Either way you end up with the same cask.

Typebird is a menu-bar app: after installing, launch it once, grant
Accessibility in System Settings → Privacy & Security → Accessibility, then
select text anywhere and press ⌃⌥T.

Requires macOS 14 (Sonoma) or later on Apple silicon.

## What this tap ships

One cask, [`Casks/typebird.rb`](Casks/typebird.rb), pointing at the same
notarized `.dmg` that <https://typebird.app/download> serves. Typebird is
distributed directly rather than through the Mac App Store, and updates itself
with [Sparkle](https://sparkle-project.org) — so `brew upgrade` and the app's
own updater are two doors onto one release.

`version` and `sha256` are written by the release pipeline in the
[main repository](https://github.com/andrewtsarow/typebird)
(`scripts/macos.sh --release --deploy`), which publishes the build and then
pushes the bump here. They are not meant to be edited by hand.

## Issues

Bug reports and feature requests for the app itself belong at
<https://typebird.app/support>. Open an issue here only for problems with the
cask — a bad checksum, a failed download, a wrong dependency.
