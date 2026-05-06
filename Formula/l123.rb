class L123 < Formula
  desc "Terminal clone of Lotus 1-2-3 Release 3.4a"
  homepage "https://github.com/duane1024/l123"
  url "https://github.com/duane1024/l123/archive/refs/tags/v1.1.3.tar.gz"
  sha256 "e66a7e20d74e550a15b4f9ff9667fafe0d1fba225f1a087ccee5c2ebb8491246"
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
