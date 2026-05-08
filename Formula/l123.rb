class L123 < Formula
  desc "Terminal clone of Lotus 1-2-3 Release 3.4a"
  homepage "https://github.com/duane1024/l123"
  url "https://github.com/duane1024/l123/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "ddd1032347a6df62d59efa4466b195db84227a5ac27041a729fb13882d1c1538"
  license "MIT"
  head "https://github.com/duane1024/l123.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/l123")
    man1.install "crates/l123/man/l123.1"
  end

  test do
    assert_match "l123 #{version}", shell_output("#{bin}/l123 --version")
    assert_predicate man1/"l123.1", :exist?
  end
end
