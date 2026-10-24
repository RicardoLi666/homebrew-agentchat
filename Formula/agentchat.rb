# Rendered by scripts/build-release.py; do not edit the copy in the tap by hand.
class Agentchat < Formula
  desc "Run claude, codex or any CLI under AgentChat for remote control and Agent messaging"
  homepage "https://getagentchat.com"
  version "0.5.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://getagentchat.com/downloads/agentchat/0.5.3/agentchat-0.5.3-aarch64-apple-darwin.tar.gz"
      sha256 "fea8393f0767e5028f2351dc71f487994dc6cbd05d4aa4107568f2b6dc4e136a"
    end
  end

  on_linux do
    on_arm do
      url "https://getagentchat.com/downloads/agentchat/0.5.3/agentchat-0.5.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2af94946e2c960947047a54a378715c0273dd8263b8b082a0c68672be1155340"
    end
    on_intel do
      url "https://getagentchat.com/downloads/agentchat/0.5.3/agentchat-0.5.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a70c55ac37fdecb8c211e29abfecf143cdd0daa1a417754c9057ea8cfef00a12"
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
