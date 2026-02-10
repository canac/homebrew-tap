class Chron < Formula
  desc "Easily run scripts on a schedule"
  homepage "https://github.com/canac/chron"
  url "https://github.com/canac/chron/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "239c2b3954f3162a8add01f9bb12fdae9ebe9a2501de8c20e58a8d53283450f7"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/canac/homebrew-tap/releases/download/chron-0.5.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "560c5b6a4d014afaeac02ddd6553fab72c494da0b14ea62714e4306e60253435"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7cb7371e1feb777d63ac284f58bf3f672d3278e76e13213a1436f7b821f47e30"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0ef2c9a93f258010a0444a16f08ac3272859715796cd491a973fa6b607315b47"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e792e4854ab0919bc76703039adb094058ca65b6a55966b60050c0a711e60985"
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
