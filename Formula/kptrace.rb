require 'formula'

class Kptrace < Formula
  homepage 'https://github.com/toonetown/kptrace/'
  head 'https://github.com/toonetown/kptrace.git', :branch => 'master'

  skip_clean 'bin'

  def install
    bin.install "kptrace";
  end
end
