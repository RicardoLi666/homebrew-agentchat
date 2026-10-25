# Rendered by scripts/build-release.py; do not edit the copy in the tap by hand.
class Agentchat < Formula
  desc "Run claude, codex or any CLI under AgentChat for remote control and Agent messaging"
  homepage "https://getagentchat.com"
  version "0.5.8"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://getagentchat.com/downloads/agentchat/0.5.8/agentchat-0.5.8-aarch64-apple-darwin.tar.gz"
      sha256 "b9e1cd90f662edcf82616c0e6c82109f4ef03a4d44f94de39084e405df73a9b6"
    end
  end

  on_linux do
    on_arm do
      url "https://getagentchat.com/downloads/agentchat/0.5.8/agentchat-0.5.8-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2984dc2e98445b52d0fc397275ba99d2d766f6d46699fd2c8a1eff0685cdb71c"
    end
    on_intel do
      url "https://getagentchat.com/downloads/agentchat/0.5.8/agentchat-0.5.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f2c1eb41431d7bdfac7d6c5b8f05fc9e0d6f566133d0e4c0f3bc14569e8c7df2"
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
