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

Releases are signed but not notarized, so Gatekeeper asks on first launch. To
skip that, install with:

```sh
brew install --cask --no-quarantine agent-tracker
```

## Why a tap rather than homebrew-cask

Homebrew's main cask repository requires a project to clear a notability bar
before it will accept a submission, and a self-submitted cask needs more than a
third-party one. A tap works from day one, needs nobody's approval, and gives
exactly the same `brew install` experience.

## Updating

Casks here are bumped automatically by the source repository's release workflow
when a new version is tagged. Nothing to do by hand.

## License

[MIT](LICENSE)
