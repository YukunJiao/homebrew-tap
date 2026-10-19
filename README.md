# YukunJiao Homebrew Tap

Homebrew formulae maintained by [@YukunJiao](https://github.com/YukunJiao).

| Formula | Description |
| --- | --- |
| [`threadle`](Formula/threadle.rb) | CLI for [Threadle](https://github.com/carlnordlund/Threadle), a high-performance system for large, complex, multilayer network datasets |

## Install Threadle

**Recommended: one command**

```bash
brew install yukunjiao/tap/threadle
```

Using the full name taps this repository and trusts the `threadle` formula automatically.

**Alternative: tap and trust first**

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

## Uninstall

```bash
brew uninstall threadle
brew untap yukunjiao/tap
```

## Issues

- Problems with installing through Homebrew: open an issue in [this repository](https://github.com/YukunJiao/homebrew-tap/issues).
- Problems with Threadle itself: report them [upstream](https://github.com/carlnordlund/Threadle/issues).
