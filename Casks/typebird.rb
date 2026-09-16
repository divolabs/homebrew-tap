# Typebird for macOS — the direct-download .dmg, wrapped as a cask.
#
# The app ships outside the Mac App Store (docs/context.md § 2.4), so this tap
# is the `brew`-shaped front door to the same artifact typebird.app serves:
# `scripts/macos.sh --release --deploy` publishes the notarized .dmg + the
# Sparkle appcast to R2, then rewrites the two lines below and pushes here.
# Don't hand-edit `version` / `sha256` — the release script owns them.
cask "typebird" do
  # "<marketing version>,<build>" — CFBundleShortVersionString + CFBundleVersion,
  # which is the pair the appcast carries and the shape `livecheck`'s :sparkle
  # strategy returns. A bare "0.1.0" here would read as perpetually out of date
  # against the feed. Only the first field appears in the filename.
  version "0.1.6,38"
  sha256 "9e0bf5e32074ba11bd4bba6a90653957ffb34b084c9cd11402e699969b0528d9"

  url "https://typebird.app/downloads/Typebird-0.1.6-38.dmg"
  name "Typebird"
  desc "Improve, translate, and tone-check the text you have selected"
  homepage "https://typebird.app/"

  # Same feed the in-app updater reads (SUFeedURL), so `brew livecheck` and
  # Sparkle can never disagree about what the newest build is.
  livecheck do
    url "https://typebird.app/appcast.xml"
    strategy :sparkle
  end

  # Sparkle updates the app in place; Homebrew should report, not fight, that.
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Typebird.app"

  # A menu-bar agent (LSUIElement), so there is no window to close — quit it by
  # bundle ID before the bundle is replaced or removed.
  uninstall quit: "app.typebird.app"

  # Mirrors `scripts/macos.sh --reset`, minus what brew cannot reach: the
  # Keychain entries (`app.typebird.deviceid`, `app.typebird.session`) and the
  # Accessibility grant survive a zap. `group.app.typebird.shared` is the App
  # Group suite the app and its extensions share.
  zap trash: [
    "~/Library/Caches/app.typebird.app",
    "~/Library/HTTPStorages/app.typebird.app",
    "~/Library/Preferences/app.typebird.app.plist",
    "~/Library/Preferences/group.app.typebird.shared.plist",
    "~/Library/Saved Application State/app.typebird.app.savedState",
  ]
end
