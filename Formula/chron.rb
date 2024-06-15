class Chron < Formula
  desc "Easily run scripts on a schedule"
  homepage "https://github.com/canac/chron"
  url "https://github.com/canac/chron/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "22fbb3074f0d3debc51505e2e4df1686b21ce48c053b99db4db08ed7eeaedad6"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/chron-0.3.0"
    sha256 cellar: :any_skip_relocation, monterey:     "692b4da82dee8893fe341e6c335e7e2ae23cd884203eff4a0cad98e95f6a06b9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "389a04077fcc78f6dd9f6603117b04f42d860e9576cede07f0d6f042a29b463d"
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

    assert_predicate file1, :exist?
    assert_predicate file2, :exist?
  end
end
