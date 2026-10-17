cask "myna" do
  version "0.7.9"
  sha256 "c0d2e56bbe20aa59392a454dd91873910a5dc0ab75acad491cada25b5da06f7e"

  url "https://github.com/quyansiyuanwang/myna/releases/download/v#{version}/Myna-v#{version}.zip"
  name "Myna"
  desc "Native macOS menu bar AI assistant with a Swift agent runtime"
  homepage "https://github.com/quyansiyuanwang/myna"

  depends_on macos: :ventura

  app "Myna.app"

  # Myna is ad-hoc signed, not notarized (notarization requires a paid
  # Developer ID certificate). Strip the quarantine attribute that Homebrew
  # applies on download so the app launches without the Gatekeeper prompt.
  #
  # `postflight_steps` cannot be used here: its context exposes `staged_path`
  # but not the installed `appdir`, so the full `postflight` DSL is required.
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/Myna.app"],
                   print_stderr: false
  end

  caveats do
    <<~EOS
      Myna runs as a menu bar app (no Dock icon).
      Grant Microphone and Accessibility permissions when prompted, then set your
      API key in Settings. The configuration is stored at ~/.config/myna/config.json.
    EOS
  end

  zap trash: [
    "~/.config/myna",
    "~/Library/Preferences/com.local.myna.plist",
  ]
end
