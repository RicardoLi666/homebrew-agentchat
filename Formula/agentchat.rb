# Rendered by scripts/build-release.py; do not edit the copy in the tap by hand.
class Agentchat < Formula
  desc "Run claude, codex or any CLI under AgentChat for remote control and Agent messaging"
  homepage "https://getagentchat.com"
  version "0.5.5"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://getagentchat.com/downloads/agentchat/0.5.5/agentchat-0.5.5-aarch64-apple-darwin.tar.gz"
      sha256 "7d83c84f9bf48f5a7447d4a40d5ac64ca73c5eee9e93a343b58d7227b1bbb4e3"
    end
  end

  on_linux do
    on_arm do
      url "https://getagentchat.com/downloads/agentchat/0.5.5/agentchat-0.5.5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3e3f077a3df9dc8e16dc5cc5d2259cc1ff70670c9335d05d79cddfdd0f7c314c"
    end
    on_intel do
      url "https://getagentchat.com/downloads/agentchat/0.5.5/agentchat-0.5.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "48c344d57e4f14ef7de5d5ec8282d8a690ef417b55521dd47ed7d84ad5c52122"
    end
  end

  def install
    libexec.install "bin", "licenses", "RELEASE.json"
    bin.install_symlink libexec/"bin/agentchat"
    bin.install_symlink libexec/"bin/agentchat" => "ac"
    bin.install_symlink libexec/"bin/agentctl"
  end

  # No `service do`: `ac runtime install-service` owns the one background service (plan D2).
  def caveats
    <<~EOS
      Start the background service once:
        ac runtime install-service
      After `brew upgrade agentchat`:
        ac runtime restart
      Then connect your account:
        ac login
    EOS
  end

  test do
    assert_equal "agentchat #{version}", shell_output("#{bin}/agentchat --version").strip
    assert_equal "agentd #{version}", shell_output("#{libexec}/bin/agentd --version").strip
  end
end
