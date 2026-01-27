class Stressman < Formula
  desc "Distributed stress testing orchestration platform"
  homepage "https://github.com/IzumaNetworks/stressman"
  version "0.1.48"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/IzumaNetworks/stressman/releases/download/v0.1.48/stressman-darwin-arm64.tar.gz"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    end
    on_intel do
      url "https://github.com/IzumaNetworks/stressman/releases/download/v0.1.48/stressman-darwin-amd64.tar.gz"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/IzumaNetworks/stressman/releases/download/v0.1.48/stressman-linux-arm64.tar.gz"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    end
    on_intel do
      url "https://github.com/IzumaNetworks/stressman/releases/download/v0.1.48/stressman-linux-amd64.tar.gz"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    end
  end

  def install
    if OS.mac?
      if Hardware::CPU.arm?
        bin.install "stressman-darwin-arm64" => "stressman"
        bin.install "stressagent-darwin-arm64" => "stressagent"
      else
        bin.install "stressman-darwin-amd64" => "stressman"
        bin.install "stressagent-darwin-amd64" => "stressagent"
      end
    else
      if Hardware::CPU.arm?
        bin.install "stressman-linux-arm64" => "stressman"
        bin.install "stressagent-linux-arm64" => "stressagent"
      else
        bin.install "stressman-linux-amd64" => "stressman"
        bin.install "stressagent-linux-amd64" => "stressagent"
      end
    end

    # Install config directory
    (etc/"stressman").mkpath
    (var/"stressman").mkpath
    (var/"log/stressman").mkpath
  end

  def caveats
    <<~EOS
      To start the stressman server:
        stressman server

      To connect with TUI from anywhere:
        stressman tui --server=<host>:9842 --token=<token>

      Configuration file location:
        #{etc}/stressman/stressman.yaml
    EOS
  end

  service do
    run [opt_bin/"stressman", "server", "--config", etc/"stressman/stressman.yaml"]
    keep_alive true
    log_path var/"log/stressman/stressman.log"
    error_log_path var/"log/stressman/stressman.log"
    working_dir var/"stressman"
  end

  test do
    assert_match "stressman", shell_output("#{bin}/stressman version")
  end
end
