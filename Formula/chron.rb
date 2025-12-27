class Chron < Formula
  desc "Easily run scripts on a schedule"
  homepage "https://github.com/canac/chron"
  url "https://github.com/canac/chron/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "0e7dfc11e3b09c14c2f6299fe26700cb2f213705b8a0a7e3f44be4b95aaff8a5"
  license "MIT"

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/chron-0.4.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "50d066425ca77f1b940a47f8ab315573d87dcda9e8cbf897164f26c7107b877c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "168796ae527c24820ce7b35dd8e4da9b5bb3a06aa0c6250a4acf18b9f7a981ab"
    sha256 cellar: :any_skip_relocation, ventura:       "cb8ae5acb2e8d7b440eba05f18237a7bbf38dd28256faef50ac91643a40c2f71"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d4626f9d95a14999f63e33b6c618171e0ee6a57475f5b4c13d1a56a8056c245c"
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
      [startup.file1]
      command = "touch '#{file1}'"
      keepAlive = false

      [scheduled.file2]
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
