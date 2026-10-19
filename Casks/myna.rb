cask "myna" do
  version "0.11.8"
  sha256 "768e559baf480f4acf9c24f176ea4d8677efc0a02a9dd7c8d0538c96e087d82b"

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
