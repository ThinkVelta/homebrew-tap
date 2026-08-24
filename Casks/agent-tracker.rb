cask "agent-tracker" do
  version "0.7.0"
  sha256 "305a7e7f02cc9905d0a3468f46912dd36833bc6a6865e58964c60629701d0484"

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

      FIRST LAUNCH IS BLOCKED, AND THE DIALOG'S DEFAULT BUTTON DELETES THE APP.

      This build is signed but not yet notarized, and Homebrew always
      quarantines a cask, so macOS refuses the first launch with "Apple could
      not verify AgentTracker is free of malware", offering "Move to Trash"
      (highlighted) and "Done".

      Click Done. Never Move to Trash. Then open System Settings > Privacy &
      Security, scroll to Security, and click "Open Anyway" next to the message
      naming AgentTracker. Launch it again and it opens normally from then on.

      To skip that entirely, clear the quarantine attribute before the first
      launch. This switches off a real Gatekeeper check for this app, so only
      do it if you are comfortable with that:

        xattr -dr com.apple.quarantine -- /Applications/AgentTracker.app

      Only the first launch needs this. Updates keep your Accessibility grant,
      because every release carries the same code signature.
    EOS
  end
end
