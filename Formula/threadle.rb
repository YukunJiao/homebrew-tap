class Threadle < Formula
  desc "High-performance system for large, complex, multilayer network datasets"
  homepage "https://github.com/carlnordlund/Threadle"
  url "https://github.com/carlnordlund/Threadle/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "b67b0a03dc7ea5d6b19fd35bd6627efbdcacc969c5120e5605d60d013fff3c00"
  license "MIT"

  bottle do
    root_url "https://github.com/YukunJiao/homebrew-tap/releases/download/threadle-1.3.0"
    rebuild 1
    sha256 cellar: :any, arm64_tahoe:  "73d89b47fead43ca44810442b94214ace2724b5cddb109227e0743c39e5624cf"
    sha256 cellar: :any, x86_64_linux: "4bdf923c591a70f13199e88eb66da073cba6684546572f7c9148637c78f2eabc"
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
           "#{formula_opt_lib("libunwind")}:#{formula_opt_lib("icu4c@78")}:#{formula_opt_lib("zlib-ng-compat")}",
           bin/"threadle"
  end

  test do
    assert_match "Threadle CLI Console", pipe_output(bin/"threadle", "exit\n")
  end
end
