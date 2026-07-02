# praxis-brew

Homebrew tap for [praxis](https://github.com/michael-duren/praxis).

## Install

```sh
brew tap michael-duren/praxis-brew https://github.com/michael-duren/praxis-brew
brew install praxis
```

Or in one line:

```sh
brew install michael-duren/praxis-brew/praxis
```

## Updating the formula for a new release

`praxis` releases (via `make release VERSION=vX.Y.Z` in the praxis repo)
publish prebuilt binaries, but this formula builds from source instead —
the templ-generated web templates are checked into the praxis repo, so no
extra codegen tooling is needed at build time.

To bump the formula after a new praxis tag:

```sh
url="https://github.com/michael-duren/praxis/archive/refs/tags/vX.Y.Z.tar.gz"
curl -sL "$url" | sha256sum
```

Update `url` and `sha256` in `Formula/praxis.rb` to match, then:

```sh
brew install --build-from-source ./Formula/praxis.rb
brew test praxis
brew audit --strict praxis
```
