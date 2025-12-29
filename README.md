# Izuma Networks Homebrew Tap

Homebrew formulae for Izuma Networks software.

## Installation

```bash
brew tap IzumaNetworks/tap
```

## Available Formulae

### stressman

Distributed stress testing orchestration platform.

```bash
# Install
brew install IzumaNetworks/tap/stressman

# Start server as a service
brew services start stressman

# Or run manually
stressman server

# Connect TUI from anywhere
stressman tui --server=<host>:9842 --token=<token>
```

## License

Apache-2.0
