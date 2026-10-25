# Rendered by scripts/build-release.py; do not edit the copy in the tap by hand.
class Agentchat < Formula
  desc "Run claude, codex or any CLI under AgentChat for remote control and Agent messaging"
  homepage "https://getagentchat.com"
  version "0.5.7"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://getagentchat.com/downloads/agentchat/0.5.7/agentchat-0.5.7-aarch64-apple-darwin.tar.gz"
      sha256 "f6e4b1cdfd9d824c8ecf6120501c8d9ee0b72db3af9449269f240844f78da97c"
    end
  end

  on_linux do
    on_arm do
      url "https://getagentchat.com/downloads/agentchat/0.5.7/agentchat-0.5.7-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "34bd28ace8155d747713ac2f9aed4a38919b50eeda525bc7e7cd86a4bc05b4e9"
    end
    on_intel do
      url "https://getagentchat.com/downloads/agentchat/0.5.7/agentchat-0.5.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "01689ebd74f09d20b3d61853880b6f3bea062eb47ab21bf7092bbd80dc52d9df"
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
