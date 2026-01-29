# typed: false
# frozen_string_literal: true

class Sx < Formula
  desc "Sandbox shell sessions with macOS Seatbelt"
  homepage "https://github.com/agentic-dev3o/sandbox-shell"
  license "MIT"

  on_arm do
    url "https://github.com/agentic-dev3o/sandbox-shell/releases/download/v0.2.7/sx-0.2.7-aarch64-apple-darwin.tar.gz"
    sha256 "546aeed550b6d79b521beadf2b41a66b493cd8b6ef007a6d4d9c9c1c6f527e2a"
  end

  on_intel do
    url "https://github.com/agentic-dev3o/sandbox-shell/releases/download/v0.2.7/sx-0.2.7-x86_64-apple-darwin.tar.gz"
    sha256 "3f20cd82c71a4f97179b5fe7434d900f93abc2618bc22983e9ccb43aa35126a0"
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
