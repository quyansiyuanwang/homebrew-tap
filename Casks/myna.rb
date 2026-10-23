cask "myna" do
  version "0.16.3"
  sha256 "db9d95ed50df16d892d4afde8764e1059a93e3a76a7c1f1f56ea71ad8f93aeb7"

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
      Grant Microphone, Accessibility and Screen Recording permissions when
      prompted (Accessibility and Screen Recording are required for computer
      use), then set your API key in Settings. The configuration is stored at ~/.config/myna/config.json.
    EOS
  end

  zap trash: [
    "~/.config/myna",
    "~/Library/Preferences/com.local.myna.plist",
  ]
end
