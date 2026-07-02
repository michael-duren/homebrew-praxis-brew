# praxis-brew

Homebrew tap for [praxis](https://github.com/michael-duren/praxis).

## Install

```sh
brew tap michael-duren/praxis-brew
brew install praxis
```

Or in one line:

```sh
brew install michael-duren/praxis-brew/praxis
```

This installs the prebuilt binary from the matching praxis GitHub release
(no Go toolchain required). `brew install --HEAD praxis` builds from the
`main` branch instead, which does require Go.

## Updating the formula for a new release

`praxis` releases (via `make release VERSION=vX.Y.Z` in the praxis repo)
publish binaries and a `SHA256SUMS` manifest for every platform this
formula targets. To bump the formula after a new praxis tag:

```sh
version=X.Y.Z
curl -sL "https://github.com/michael-duren/praxis/releases/download/v${version}/SHA256SUMS"
```

Update `version` and the four `sha256` values (darwin-arm64, darwin-amd64,
linux-arm64, linux-amd64) in `Formula/praxis.rb` to match, then:

```sh
brew install ./Formula/praxis.rb
brew test praxis
brew audit --strict praxis
```
