# Rendered by scripts/build-release.py; do not edit the copy in the tap by hand.
class Agentchat < Formula
  desc "Run claude, codex or any CLI under AgentChat for remote control and Agent messaging"
  homepage "https://getagentchat.com"
  version "0.5.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://getagentchat.com/downloads/agentchat/0.5.1/agentchat-0.5.1-aarch64-apple-darwin.tar.gz"
      sha256 "752c8727629ee204fc18b5f725f153a6975da7338ea2396cd51eca062ea00aa6"
    end
  end

  on_linux do
    on_arm do
      url "https://getagentchat.com/downloads/agentchat/0.5.1/agentchat-0.5.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fe05c3f5c8ae99c15737d68d592a213670e0a1ff9b3d715290ca7d76a145b1bb"
    end
    on_intel do
      url "https://getagentchat.com/downloads/agentchat/0.5.1/agentchat-0.5.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c9ec3358be3d5a06b795c8bbbd99ce7eca00a774a7ee7a59bf4cb2b2099638ec"
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
