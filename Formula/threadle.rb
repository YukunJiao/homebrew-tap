class Threadle < Formula
  desc "High-performance system for large, complex, multilayer network datasets"
  homepage "https://threadle.dev"
  url "https://github.com/carlnordlund/Threadle/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "b127da2d9bf0683b310e1ed249953fc69976362bcf0d025c311c5debb99e50fd"
  license "MIT"

  depends_on "dotnet" => :build

  def install
    ENV["DOTNET_CLI_TELEMETRY_OPTOUT"] = "1"
    ENV["DOTNET_NOLOGO"] = "1"
    ENV["DOTNET_SKIP_FIRST_TIME_EXPERIENCE"] = "1"

    rid = if OS.mac?
      Hardware::CPU.arm? ? "osx-arm64" : "osx-x64"
    else
      Hardware::CPU.arm? ? "linux-arm64" : "linux-x64"
    end

    system "dotnet", "publish", "Threadle.CLIconsole",
           "-c", "Release",
           "-r", rid,
           "--self-contained", "true",
           "-p:PublishSingleFile=true",
           "-o", "publish"

    bin.install "publish/threadle"
  end

  test do
    assert_match "Threadle CLI Console", pipe_output("#{bin}/threadle", "exit\n")
  end
end
