# typed: false
# frozen_string_literal: true

class Sx < Formula
  desc "Sandbox shell sessions with macOS Seatbelt"
  homepage "https://github.com/agentic-dev3o/sx"
  url "https://github.com/agentic-dev3o/sx/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "PLACEHOLDER_SHA256_WILL_BE_UPDATED_BY_RELEASE_WORKFLOW"
  license "MIT"
  head "https://github.com/agentic-dev3o/sx.git", branch: "main"

  # macOS only - Seatbelt is not available on Linux
  depends_on :macos

  # Rust toolchain for building from source
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
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

      Documentation: https://github.com/agentic-dev3o/sx
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
