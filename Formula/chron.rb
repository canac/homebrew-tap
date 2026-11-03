class Chron < Formula
  desc "Easily run scripts on a schedule"
  homepage "https://github.com/canac/chron"
  url "https://github.com/canac/chron/archive/refs/tags/v0.6.3.tar.gz"
  sha256 "d9208636c537bbdf834acff8f57db12fb9364698e54d335403829c01d7fb9989"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/chron-0.6.3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "9f79c720d09071cde96ed25608206c302a2a47111b65de0363c8337655590e9b"
    sha256 cellar: :any,                 x86_64_linux: "10320e64d623cd72133d977f70ea6891a2963058ce5c2e03253f002d7187bc30"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    man1.install "man/man1/chron.1"
    bash_completion.install "contrib/completions/chron.bash" => "chron"
    zsh_completion.install "contrib/completions/_chron"
    fish_completion.install "contrib/completions/chron.fish"
  end

  test do
    file1 = testpath/"file1.txt"
    file2 = testpath/"file2.txt"

    (testpath/"chronfile.toml").write <<~EOS
      [jobs.file1]
      command = "touch '#{file1}'"

      [jobs.file2]
      command = "touch '#{file2}'"
      schedule = "* * * * * * *"
    EOS

    fork do
      exec bin/"chron", "run", testpath/"chronfile.toml"
    end
    sleep 2

    assert_path_exists file1
    assert_path_exists file2
  end
end
