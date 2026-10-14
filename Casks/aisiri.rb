cask "aisiri" do
  version "0.3.1"
  sha256 "696860d7c9b4dca2fda5dcb441bbc4b4d8eeaed2db9a2ab5b7bffddb6dd788f0"

  url "https://github.com/quyansiyuanwang/macos-ai-assistant/releases/download/v#{version}/AiSiri-v#{version}.zip"
  name "AiSiri"
  desc "Native macOS menu bar AI assistant with a Swift agent runtime"
  homepage "https://github.com/quyansiyuanwang/macos-ai-assistant"

  depends_on macos: :ventura
  quarantine false

  app "AiSiri.app"

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
