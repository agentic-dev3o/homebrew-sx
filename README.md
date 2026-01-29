# Homebrew Tap for sx

This is a [Homebrew](https://brew.sh) tap for [sx](https://github.com/agentic-dev3o/sandbox-shell), a CLI that wraps shell sessions in macOS Seatbelt sandboxes.

## Requirements

- macOS (sx uses macOS Seatbelt, which is not available on Linux)
- Homebrew

## Installation

```bash
brew tap agentic-dev3o/sx
brew install sx
```

## Upgrading

```bash
brew upgrade sx
```

## Uninstalling

```bash
brew uninstall sx
brew untap agentic-dev3o/sx
```

## Troubleshooting

### Build fails

Ensure you have Xcode Command Line Tools installed:

```bash
xcode-select --install
```

### Issues

Report issues at: https://github.com/agentic-dev3o/sandbox-shell/issues
