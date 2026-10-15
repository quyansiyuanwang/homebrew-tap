cask "aisiri" do
  version "0.3.6"
  sha256 "4a76fee0241bb01088399d7b2418bd0a57908069cfd916d98b949a113ba43cb5"

  url "https://github.com/quyansiyuanwang/macos-ai-assistant/releases/download/v#{version}/AiSiri-v#{version}.zip"
  name "AiSiri"
  desc "Native macOS menu bar AI assistant with a Swift agent runtime"
  homepage "https://github.com/quyansiyuanwang/macos-ai-assistant"

  depends_on macos: :ventura

  app "AiSiri.app"

  # AiSiri is ad-hoc signed, not notarized (notarization requires a paid
  # Developer ID certificate). Strip the quarantine attribute that Homebrew
  # applies on download so the app launches without the Gatekeeper prompt.
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/AiSiri.app"],
                   print_stderr: false
  end

  caveats do
    <<~EOS
      AiSiri runs as a menu bar app (no Dock icon).
      Grant Microphone and Accessibility permissions when prompted, then set your
      API key in Settings. The configuration is stored at ~/.config/aisiri/config.json.
    EOS
  end

  zap trash: [
    "~/.config/aisiri",
    "~/Library/Preferences/com.local.aisiri.plist",
  ]
end
