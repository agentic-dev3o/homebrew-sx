# typed: false
# frozen_string_literal: true

class Sx < Formula
  desc "Sandbox shell sessions with macOS Seatbelt"
  homepage "https://github.com/agentic-dev3o/sandbox-shell"
  version "0.2.6"
  license "MIT"

  on_arm do
    url "https://github.com/agentic-dev3o/sandbox-shell/releases/download/v0.2.6/sx-0.2.6-aarch64-apple-darwin.tar.gz"
    sha256 "ca9728c81e59a4b8e37e274f21feff918229e84cc46cda346bdf076674b86848"
  end

  on_intel do
    url "https://github.com/agentic-dev3o/sandbox-shell/releases/download/v0.2.6/sx-0.2.6-x86_64-apple-darwin.tar.gz"
    sha256 "11fe64c2943a8c3e7b1e8b957f1c8aa7070e4d3d97b72afcbfe0cb08910acf6d"
  end

  depends_on :macos

  def install
    bin.install "sx"
  end

  def caveats
    <<~EOS
      sx restricts filesystem and network access using macOS Seatbelt.

      Quick start:
        sx -- echo "sandboxed command"      # Run command in sandbox
        sx rust -- cargo build              # Use rust profile
        sx online node -- npm install       # Allow network access
        sx -n -- node app.js                # Dry-run (preview sandbox rules)

      Initialize project config:
        sx --init                           # Creates .sandbox.toml

      Documentation: https://github.com/agentic-dev3o/sandbox-shell
    EOS
  end

  test do
    # Verify binary runs and shows version
    assert_match version.to_s, shell_output("#{bin}/sx --version")

    # Verify help output
    assert_match "sandbox", shell_output("#{bin}/sx --help")

    # Verify dry-run works (prints Seatbelt profile without executing)
    output = shell_output("#{bin}/sx --dry-run -- echo test")
    assert_match "deny default", output
  end
end
