class Libksba < Formula
  desc "X.509 and CMS library"
  homepage "https://www.gnupg.org/related_software/libksba/"
  url "https://gnupg.org/ftp/gcrypt/libksba/libksba-1.5.0.tar.bz2"
  sha256 "ae4af129216b2d7fdea0b5bf2a788cd458a79c983bb09a43f4d525cc87aba0ba"
  license "GPL-2.0"

  livecheck do
    url "https://gnupg.org/ftp/gcrypt/libksba/"
    regex(/href=.*?libksba[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    cellar :any
    sha256 "2f5fa25726a4d47cfb2b946fa5326c22dc0278f62922c892c3b88ff659485f4b" => :big_sur
    sha256 "14b9bc72288c2fc4061ea49261427aa9e00738a383433302ff86ae18095b2f4a" => :catalina
    sha256 "153e805e508005ebd9c8eca39b4027f35cddcc123583a421664746dda51ddbc9" => :mojave
    sha256 "ed07783410f48fe767e96ad596b570ccd0d849715af99b84f99918428953a9a5" => :high_sierra
  end

  depends_on "libgpg-error"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"

    # avoid triggering mandatory rebuilds of software that hard-codes this path
    inreplace bin/"ksba-config", prefix, opt_prefix
  end

  test do
    system "#{bin}/ksba-config", "--libs"
  end
end
