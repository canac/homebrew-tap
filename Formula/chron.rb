class Chron < Formula
  desc "Easily run scripts on a schedule"
  homepage "https://github.com/canac/chron"
  url "https://github.com/canac/chron/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "fb9ddf851607b942d9c0e3315705d4c69ab89b9580c904062b45871d95b54abe"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/chron-0.3.4"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "25abb7321052d8858e4de0d98152eb3b62e542174683c8915577ebdcc964649f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1fee34d2ae1f16049d3c79e0ec12490001594b59dee547582ef10f7a39881ac2"
    sha256 cellar: :any_skip_relocation, ventura:       "9e29b301b651fe91522c222da277acf98349ff97a4f1369d310bfac27bb68b4f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "67814ecd7231d9de8d863c71d673ce4261b9b8acd10d2f91b0c5a9111a6d5c5b"
  end

  depends_on "rust" => :build
  depends_on "canac/tap/mailbox"

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
      [startup.file1]
      command = "touch '#{file1}'"
      keepAlive = false

      [scheduled.file2]
      command = "touch '#{file2}'"
      schedule = "* * * * * * *"
    EOS

    fork do
      exec bin/"chron", testpath/"chronfile.toml"
    end
    sleep 2

    assert_path_exists file1
    assert_path_exists file2
  end
end
