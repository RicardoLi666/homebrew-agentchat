# Rendered by scripts/build-release.py; do not edit the copy in the tap by hand.
class Agentchat < Formula
  desc "Run claude, codex or any CLI under AgentChat for remote control and Agent messaging"
  homepage "https://getagentchat.com"
  version "0.6.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://getagentchat.com/downloads/agentchat/0.6.0/agentchat-0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "c209abb94e3391427947bc72bd0008982735e0aff94ec2fdd490f4ba282b08a8"
    end
  end

  on_linux do
    on_arm do
      url "https://getagentchat.com/downloads/agentchat/0.6.0/agentchat-0.6.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a5c2285c1e7ef13042afe886708cafc08686c8b2632773423bf42c82de479dd7"
    end
    on_intel do
      url "https://getagentchat.com/downloads/agentchat/0.6.0/agentchat-0.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8509d32bc3c4a6683df857009a804ed3d4d3853732d73ec85f20acf979ba8f4c"
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
