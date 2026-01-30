# typed: false
# frozen_string_literal: true

class Sx < Formula
  desc "Sandbox shell sessions with macOS Seatbelt"
  homepage "https://github.com/agentic-dev3o/sandbox-shell"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/agentic-dev3o/sandbox-shell/releases/download/v0.2.8/sx-0.2.8-aarch64-apple-darwin.tar.gz"
    sha256 "638589809ff7dd49accf7e8eca8a2f2f71c59b6d9d6feb3db9bd8dd3c1ef5879"
  else
    url "https://github.com/agentic-dev3o/sandbox-shell/releases/download/v0.2.8/sx-0.2.8-x86_64-apple-darwin.tar.gz"
    sha256 "a6d923a269d8e2c64fc264907a8e096d220f7269e77de5518b80d3c991e0d7fd"
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
