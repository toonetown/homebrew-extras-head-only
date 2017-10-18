require 'formula'

class AnsiColor < Formula
  homepage 'https://github.com/ali5ter/ansi-color/'
  head 'https://github.com/ali5ter/ansi-color.git', :branch => 'master'

  skip_clean 'bin'

  def install
    bin.install "ansi-color/color";
    man1.install "ansi-color/color.1";
  end
end
