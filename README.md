# Velta's Homebrew tap

Casks for [Velta](https://thinkvelta.ai)'s open-source tools.

```sh
brew tap ThinkVelta/tap
```

Homebrew 6 refuses to load casks from taps outside its own repositories until
you trust them, so each install below includes a `brew trust` line. Without it
the install stops with *"Refusing to load cask … from untrusted tap"*. That
applies to every third-party tap, and trusting is per-machine.

## Available

### [Agent Tracker](https://github.com/ThinkVelta/agent-tracker)

A macOS menu bar app that tells you which AI coding session is waiting on you.

```sh
brew trust --cask thinkvelta/tap/agent-tracker
brew install --cask agent-tracker
```

Trusting the single cask rather than the whole tap is deliberate: `brew trust
thinkvelta/tap` also works, but it covers everything added here in future,
including casks that do not exist yet.

> [!IMPORTANT]
> **The first launch is blocked, and the dialog's default button deletes the
> app.** Releases are signed but not yet notarized, and Homebrew always
> quarantines a cask, so macOS refuses with *"Apple could not verify
> AgentTracker is free of malware"*, offering **Move to Trash** (highlighted)
> and **Done**.
>
> Click **Done**. Never Move to Trash. Then open **System Settings > Privacy &
> Security**, scroll to Security, and click **Open Anyway** next to the message
> naming AgentTracker.

To skip that dialog, clear the quarantine attribute before the first launch.
This switches off a real Gatekeeper check for this app, so only do it if you are
comfortable with that:

```sh
xattr -dr com.apple.quarantine -- /Applications/AgentTracker.app
```

It must be recursive: the attribute is on every file in the bundle, not just its
root, so clearing the root alone leaves the app quarantined.

Only the first launch needs this. Updates keep your Accessibility grant, because
every release carries the same code signature.

## Why a tap rather than homebrew-cask

Homebrew's main cask repository requires a project to clear a notability bar
before it will accept a submission, and a self-submitted cask needs more than a
third-party one. A tap works from day one, needs nobody's approval, and gives
exactly the same `brew install` experience.

## Updating

Tagging a release in the source repository updates the cask here, as long as
that repository holds a `TAP_GITHUB_TOKEN` with write access to this one. When
it does not, the release still succeeds and prints the version and digest to
set, and someone edits the cask by hand.

## License

[MIT](LICENSE)
