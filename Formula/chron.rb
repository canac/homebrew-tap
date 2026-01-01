class Chron < Formula
  desc "Easily run scripts on a schedule"
  homepage "https://github.com/canac/chron"
  url "https://github.com/canac/chron/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "239c2b3954f3162a8add01f9bb12fdae9ebe9a2501de8c20e58a8d53283450f7"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/chron-0.5.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2d999852bf5d8d12d76ff82b360614656e5f5ef77a85580b4f44238db062fb2a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1be28e45bb642975b1c3c16cbfd30a6b285f03428a3fefd110d67bb62ba4d24e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ebfe9048f6c9180b74f4efb39636b3fb598db0012d83d1155a22ec0d6221cf1e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b3f8a5ac0c1d9c2c9272cfaf9b7b5c692564b4a7a9ac51d7e096b8703d568aee"
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
