cask "agent-tracker" do
  version "0.12.1"
  sha256 "f2ea527b5995ec5d5a9d5e2e8789a26624dc21175725c20c9c03734521795cc0"

  url "https://github.com/ThinkVelta/agent-tracker/releases/download/v#{version}/AgentTracker-#{version}.zip",
      verified: "github.com/ThinkVelta/agent-tracker/"
  name "Agent Tracker"
  desc "Menu bar app showing which AI coding session needs you"
  homepage "https://github.com/ThinkVelta/agent-tracker"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Bare symbol rather than ">= :sonoma". The symbol already means "that release
  # or newer": `brew info` reports "Required: macOS >= 14" for both spellings.
  # The string form is worse than untidy, because under HOMEBREW_DEVELOPER=1 it
  # does not warn, it fails to load: "Error: Calling string comparison format
  # for `depends_on macos:` is deprecated!". CI sets that variable, so the
  # string form would break every check here.
  depends_on macos: :sonoma

  app "AgentTracker.app"

  uninstall quit: "com.thinkvelta.agent-tracker"

  zap trash: [
    "~/.agent-tracker",
    "~/Library/Preferences/com.thinkvelta.agent-tracker.plist",
  ]

  # Releases are Developer ID signed and notarized (since v0.3.1), so
  # Gatekeeper opens them without a first-launch block, and the stable
  # signature is why the Accessibility permission survives an upgrade.
  caveats do
    <<~EOS
      Agent Tracker needs Accessibility permission to focus a session's
      terminal window. Its first-run window walks you through granting it, and
      the permission survives updates because every release carries the same
      Developer ID signature.
    EOS
  end
end
