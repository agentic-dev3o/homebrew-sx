# typed: false
# frozen_string_literal: true

class Sx < Formula
  desc "Sandbox shell sessions with macOS Seatbelt"
  homepage "https://github.com/agentic-dev3o/sandbox-shell"
  version "0.2.5"
  license "MIT"

  on_arm do
    url "https://github.com/agentic-dev3o/sandbox-shell/releases/download/v0.2.5/sx-0.2.5-aarch64-apple-darwin.tar.gz"
    sha256 "5c1857892aa9d5ae3f4b9780505091bb0c638d30cc6ac814a06d37e15b73b5ea"
  end

  on_intel do
    url "https://github.com/agentic-dev3o/sandbox-shell/releases/download/v0.2.5/sx-0.2.5-x86_64-apple-darwin.tar.gz"
    sha256 "ba95f6ad2c7be883bf8e1dfc588d859e5d2c372eb88bd73e3e1a59aaec04c172"
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
