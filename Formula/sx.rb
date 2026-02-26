# typed: false
# frozen_string_literal: true

class Sx < Formula
  desc "Sandbox shell sessions with macOS Seatbelt"
  homepage "https://github.com/agentic-dev3o/sandbox-shell"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/agentic-dev3o/sandbox-shell/releases/download/v1.0.0/sx-1.0.0-aarch64-apple-darwin.tar.gz"
    sha256 "b54d03d792159b26fb75ddb07fba9a5d3e53d41f6a78e2fd29dac54f6ece67b0"
  else
    url "https://github.com/agentic-dev3o/sandbox-shell/releases/download/v1.0.0/sx-1.0.0-x86_64-apple-darwin.tar.gz"
    sha256 "0539922917bdaae98a2546d74645532b04706c13316e2d6624ff939087e018f3"
  end

  depends_on :macos

  def install
    bin.install "sx"
    (share/"sx").install Dir["shell/*"]
  end

  def caveats
    <<~EOS
      sx restricts filesystem and network access using macOS Seatbelt.

      Quick start:
        sx -- echo "sandboxed"              # Run in sandbox
        sx rust -- cargo build              # Use rust profile
        sx online -- npm install            # Allow network

      Shell integration (optional, add to your shell config):
        # Zsh (~/.zshrc)
        source #{share}/sx/sx.zsh

        # Bash (~/.bashrc)
        source #{share}/sx/sx.bash

        # Fish
        cp #{share}/sx/sx.fish ~/.config/fish/conf.d/

      Provides: prompt indicator, tab completion, aliases (sxo, sxl, sxr, sxc)

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
