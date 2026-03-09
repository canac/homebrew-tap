class Chron < Formula
  desc "Easily run scripts on a schedule"
  homepage "https://github.com/canac/chron"
  url "https://github.com/canac/chron/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "5816fd8b85190a5413e1656cdb7a091f6260bbef1db97709a027ae19b0f3fd1d"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/chron-0.6.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "44500eaca73434089e8e0df538c4ea86406c4c5396d7a0ff900a3a5d090ba21a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "42ed8ea1fb84f25438b0de486fa00553ccae9fbba57be86566ab8998c37949d8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "01baa829fae81a9211ba331eb0fcfca8a959e4bbdc2249d053f723191659a826"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e18a43c850d0cca5997104a908f27786375d3d522edcb0813257601d7d5191bf"
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
