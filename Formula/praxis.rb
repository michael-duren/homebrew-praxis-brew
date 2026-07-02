class Praxis < Formula
  desc "Orchestrates context files that coding agents read (CLAUDE.md, AGENTS.md, ...)"
  homepage "https://github.com/michael-duren/praxis"
  version "1.0.0"
  license "GPL-3.0-or-later"

  # praxis's release workflow already cross-compiles and checksums binaries
  # for every platform Homebrew targets, so `brew install` just fetches the
  # right one instead of pulling in the Go toolchain to build from source.
  on_macos do
    on_arm do
      url "https://github.com/michael-duren/praxis/releases/download/v#{version}/praxis-v#{version}-darwin-arm64"
      sha256 "fe72d63029ddd6d9f43b162c095072f9e2e185b88dd496f45eb731a1cdddf981"
    end
    on_intel do
      url "https://github.com/michael-duren/praxis/releases/download/v#{version}/praxis-v#{version}-darwin-amd64"
      sha256 "0ffa9fedcce8e109dfdcef87ef17055b2f66b5fbad35916e505fd7958a82f621"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/michael-duren/praxis/releases/download/v#{version}/praxis-v#{version}-linux-arm64"
      sha256 "e28be21b91c68c6af62e03d9a3c552c89cf609fa9486fb0a3dff61cf324fb2cb"
    end
    on_intel do
      url "https://github.com/michael-duren/praxis/releases/download/v#{version}/praxis-v#{version}-linux-amd64"
      sha256 "f5998d8f5d91df6bb4b731da49eb408c4d6c37f69f6662780db0d2c8adec560e"
    end
  end

  # No prebuilt binary exists for main, so --HEAD builds from source. The
  # templ-generated code is checked in, so no extra codegen tooling needed.
  head do
    url "https://github.com/michael-duren/praxis.git", branch: "main"
    depends_on "go" => :build
  end

  def install
    if build.head?
      system "go", "build", "-trimpath", "-ldflags", "-s -w -X main.version=head",
             "-o", bin/"praxis", "./cmd/praxis"
    else
      # GitHub release assets are plain files served over HTTP, which
      # carries no Unix file mode, so the download arrives non-executable.
      bin.install Dir["praxis-*"].first => "praxis"
      chmod "+x", bin/"praxis"
    end
  end

  test do
    out = shell_output("#{bin}/praxis version")
    assert_match build.head? ? "praxis head" : "praxis v#{version}", out
  end
end
