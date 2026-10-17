class Threadle < Formula
  desc "High-performance system for large, complex, multilayer network datasets"
  homepage "https://github.com/carlnordlund/Threadle"
  url "https://github.com/carlnordlund/Threadle/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "b67b0a03dc7ea5d6b19fd35bd6627efbdcacc969c5120e5605d60d013fff3c00"
  license "MIT"

  bottle do
    root_url "https://github.com/YukunJiao/homebrew-tap/releases/download/threadle-1.2.0"
    sha256 cellar: :any, arm64_tahoe:  "5c5f4607669f9c709be56479a42992b81b740cd18b3cce94a583fd002a64af53"
    sha256               x86_64_linux: "87b69457125f26ae9b5f17eaf9d5b14798758c4df2cd56e45398fcd7814e4cc6"
  end

  depends_on "dotnet" => :build
  depends_on "brotli"

  on_linux do
    depends_on "patchelf" => :build
    depends_on "icu4c@78"
    depends_on "libunwind"
    depends_on "zlib-ng-compat"
  end

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

    return unless OS.linux?

    system "patchelf", "--set-rpath",
           "#{Formula["libunwind"].opt_lib}:#{Formula["icu4c@78"].opt_lib}:#{Formula["zlib-ng-compat"].opt_lib}",
           bin/"threadle"
  end

  test do
    assert_match "Threadle CLI Console", pipe_output(bin/"threadle", "exit\n")
  end
end
