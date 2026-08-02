# Velta's Homebrew tap

Casks for [Velta](https://thinkvelta.ai)'s open-source tools.

```sh
brew tap ThinkVelta/tap
```

## Available

### [Agent Tracker](https://github.com/ThinkVelta/agent-tracker)

A macOS menu bar app that tells you which AI coding session is waiting on you.

```sh
brew install --cask agent-tracker
```

Releases are signed but not notarized, and Homebrew always quarantines a cask,
so macOS asks on first launch. Clear it in **System Settings > Privacy &
Security > Open Anyway**, or do it yourself:

```sh
xattr -d com.apple.quarantine /Applications/AgentTracker.app
```

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
