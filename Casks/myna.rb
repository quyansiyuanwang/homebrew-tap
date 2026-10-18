cask "myna" do
  version "0.11.5"
  sha256 "8ed5c29465b0377a1cabb22dc0f691ba55285b5f877c70faa9a51d07a0b8d641"

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
