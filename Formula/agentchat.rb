# Rendered by scripts/build-release.py; do not edit the copy in the tap by hand.
class Agentchat < Formula
  desc "Run claude, codex or any CLI under AgentChat for remote control and Agent messaging"
  homepage "https://getagentchat.com"
  version "0.5.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://getagentchat.com/downloads/agentchat/0.5.2/agentchat-0.5.2-aarch64-apple-darwin.tar.gz"
      sha256 "f64b3f1eb80e3edf03f7a529543774d7157d4f4c30e7cb5abd78e7d119f028b9"
    end
  end

  on_linux do
    on_arm do
      url "https://getagentchat.com/downloads/agentchat/0.5.2/agentchat-0.5.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d873599926577a5a03320e3871b9d628430db937ece8d4af00a1508d84ef7df5"
    end
    on_intel do
      url "https://getagentchat.com/downloads/agentchat/0.5.2/agentchat-0.5.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e0fe6ebd4dbdd1f880ecd68c5588516ea85ce29100a466e81c14978e4641df62"
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
