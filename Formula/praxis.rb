class Praxis < Formula
  desc "Orchestrates context files that coding agents read (CLAUDE.md, AGENTS.md, ...)"
  homepage "https://github.com/michael-duren/praxis"
  url "https://github.com/michael-duren/praxis/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "6adb8a28d21397bbde3807ee586674c89a25467d6d4ac09fd4722cb0cb2cc1ee"
  license "GPL-3.0-or-later"
  head "https://github.com/michael-duren/praxis.git", branch: "main"

  depends_on "go" => :build

  def install
    # templ-generated code is checked into the repo, so no extra codegen
    # tooling is needed at build time (see README's "go install" section).
    system "go", "build", "-trimpath", "-ldflags", "-s -w -X main.version=v#{version}",
           "-o", bin/"praxis", "./cmd/praxis"
  end

  test do
    assert_match "praxis v#{version}", shell_output("#{bin}/praxis version")
  end
end
