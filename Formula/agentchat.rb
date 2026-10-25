# Rendered by scripts/build-release.py; do not edit the copy in the tap by hand.
class Agentchat < Formula
  desc "Run claude, codex or any CLI under AgentChat for remote control and Agent messaging"
  homepage "https://getagentchat.com"
  version "0.5.4"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://getagentchat.com/downloads/agentchat/0.5.4/agentchat-0.5.4-aarch64-apple-darwin.tar.gz"
      sha256 "c1b32a2b95951cde30645ef159e8dc18bdb204664c7730feabf2df6aefb33588"
    end
  end

  on_linux do
    on_arm do
      url "https://getagentchat.com/downloads/agentchat/0.5.4/agentchat-0.5.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "655b13b1418ec91f8c3c15ba9b8c9837275d40955a12cc63ce8324e7ee684e94"
    end
    on_intel do
      url "https://getagentchat.com/downloads/agentchat/0.5.4/agentchat-0.5.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6436147e14b3a2e9a5a1b356f90dd406cbcd86844eef874ced5ec8218797e423"
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
