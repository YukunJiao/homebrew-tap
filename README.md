# YukunJiao Homebrew Tap

Homebrew formulae maintained by [@YukunJiao](https://github.com/YukunJiao).

| Formula | Description |
| --- | --- |
| [`threadle`](Formula/threadle.rb) | CLI for [Threadle](https://github.com/carlnordlund/Threadle), a high-performance system for large, complex, multilayer network datasets |
| [`threadle-dev`](Formula/threadle-dev.rb) | Development build of Threadle, built from the upstream dev branch |

## Install Threadle

**Recommended**

```bash
brew install yukunjiao/tap/threadle
```

Using the full name taps this repository and trusts the `threadle` formula automatically.

**Alternative**

```bash
brew tap yukunjiao/tap
brew trust yukunjiao/tap
brew install threadle
```

Then start it:

```bash
threadle
```

Type `exit` to quit the console.

## Upgrade

```bash
brew upgrade threadle
```

## Development build

For testing unreleased changes. It installs as the command `threadle-dev`, alongside the stable `threadle`. To use it from threadleR or threadlepy, give them `threadle-dev` as the Threadle command instead of `threadle`.

```bash
brew install --HEAD yukunjiao/tap/threadle-dev
```

Rebuild from the latest dev branch:

```bash
brew upgrade --fetch-HEAD threadle-dev
```

## Uninstall

```bash
brew uninstall threadle threadle-dev   # whichever you installed
brew untap yukunjiao/tap
```

## Issues

- Problems with installing through Homebrew: open an issue in [this repository](https://github.com/YukunJiao/homebrew-tap/issues).
- Problems with Threadle itself: report them [upstream](https://github.com/carlnordlund/Threadle/issues).
