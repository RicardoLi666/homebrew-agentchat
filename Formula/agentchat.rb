# Rendered by scripts/build-release.py; do not edit the copy in the tap by hand.
class Agentchat < Formula
  desc "Run claude, codex or any CLI under AgentChat for remote control and Agent messaging"
  homepage "https://getagentchat.com"
  version "0.5.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://getagentchat.com/downloads/agentchat/0.5.0/agentchat-0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "f2a13ee90baab2cb698fa1bdab3bf0b0073df38831b545f679d1f236a5abec0c"
    end
  end

  on_linux do
    on_arm do
      url "https://getagentchat.com/downloads/agentchat/0.5.0/agentchat-0.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "175e32b5f888a6fbfca694c9ce6350f3b7a6f993f6f8b9e2c9c574a73468dbbb"
    end
    on_intel do
      url "https://getagentchat.com/downloads/agentchat/0.5.0/agentchat-0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6c80b1acf9d138faf61824343894b31de846615de15f6476cd6a92443429470d"
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
