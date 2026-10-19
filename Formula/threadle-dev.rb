class ThreadleDev < Formula
  desc "Development build of Threadle, tracking the upstream dev branch"
  homepage "https://github.com/carlnordlund/Threadle"
  license "MIT"
  # Upstream names its dev branch after the next release; update this when a
  # new dev-x.y branch is opened.
  head "https://github.com/carlnordlund/Threadle.git", branch: "dev-1.3.1"

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

    # Same runtime pin as the stable threadle formula (see the comment there).
    system "dotnet", "publish", "Threadle.CLIconsole",
           "-c", "Release",
           "-r", rid,
           "--self-contained", "true",
           "-p:PublishSingleFile=true",
           "-p:RuntimeFrameworkVersion=10.0.13",
           "-o", "publish"

    # Installed as threadle-dev so it can sit next to the stable threadle.
    bin.install "publish/threadle" => "threadle-dev"

    return unless OS.linux?

    system "patchelf", "--set-rpath",
           "#{formula_opt_lib("libunwind")}:#{formula_opt_lib("icu4c@78")}:#{formula_opt_lib("zlib-ng-compat")}",
           bin/"threadle-dev"
  end

  test do
    assert_match "Threadle CLI Console", pipe_output(bin/"threadle-dev", "exit\n")
  end
end
