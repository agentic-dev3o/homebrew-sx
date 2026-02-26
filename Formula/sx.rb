# typed: false
# frozen_string_literal: true

class Sx < Formula
  desc "Sandbox shell sessions with macOS Seatbelt"
  homepage "https://github.com/agentic-dev3o/sandbox-shell"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/agentic-dev3o/sandbox-shell/releases/download/v1.0.1/sx-1.0.1-aarch64-apple-darwin.tar.gz"
    sha256 "93a0d3d736b2407d9cf806fa8e5e3dbcca78a417b2eb6c3449006ec16f74c47a"
  else
    url "https://github.com/agentic-dev3o/sandbox-shell/releases/download/v1.0.1/sx-1.0.1-x86_64-apple-darwin.tar.gz"
    sha256 "c8dd03bd92e9ea41bc450d20f5eece7c9682ed449ae976dca098faf9ffb03969"
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
