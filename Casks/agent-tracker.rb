cask "agent-tracker" do
  version "0.1.0"
  sha256 "e9bb3f103849ba538bfaa2dd9d0ee3b0ba4e1a84e0e5fac9366049d3b350be27"

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

  # Releases are signed with a self-signed certificate rather than a Developer
  # ID one, so Gatekeeper always asks on first launch. There is no install flag
  # that avoids it: Homebrew 6 rejects `--no-quarantine` outright and ignores it
  # in HOMEBREW_CASK_OPTS, which is why the caveats below give the two routes
  # that do work. What the certificate buys is a stable code signature, which is
  # why the Accessibility permission survives an upgrade.
  caveats do
    <<~EOS
      Agent Tracker needs Accessibility permission to focus a session's terminal
      window. Its first-run window walks you through granting it.

      This build is signed but not notarized, and Homebrew always quarantines a
      cask, so macOS will ask on first launch. Either open System Settings >
      Privacy & Security, find the message naming AgentTracker, and click
      "Open Anyway", or clear the attribute yourself:

        xattr -d com.apple.quarantine /Applications/AgentTracker.app

      Only the first launch needs this. Updates keep your Accessibility grant,
      because every release carries the same code signature.
    EOS
  end
end
