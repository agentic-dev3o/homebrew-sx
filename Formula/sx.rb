# typed: false
# frozen_string_literal: true

class Sx < Formula
  desc "Sandbox shell sessions with macOS Seatbelt"
  homepage "https://github.com/agentic-dev3o/sandbox-shell"
  url "https://github.com/agentic-dev3o/sandbox-shell/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "8d84a2348adad888110c3c557704406e16672e21c359ea75100a85e4913c7928"
  license "MIT"
  head "https://github.com/agentic-dev3o/sandbox-shell.git", branch: "main"

  depends_on "rust" => :build
  depends_on :macos

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
