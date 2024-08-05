class Chron < Formula
  desc "Easily run scripts on a schedule"
  homepage "https://github.com/canac/chron"
  url "https://github.com/canac/chron/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "0498d315f33f72592790ce867c3962254bf2468fabbf786b946b6aedb4fdc2cb"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/chron-0.3.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "a3814823a78009d5a6bc7f5db28e56ad7fac026356563dae84b2ab112a0989e0"
    sha256 cellar: :any_skip_relocation, ventura:      "82bf59fcc259ea7988e98ee81f26a999e949ee50dba68799cb2b99a369776a9b"
    sha256 cellar: :any_skip_relocation, monterey:     "8372e3b9dacb61fe259c7cc242d07618e8979d46eb16154ca8aeab51fc02af86"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "16ff042801c87201134e55db0adf88d1530a5c35a3405e54724df02644cf1ac8"
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
