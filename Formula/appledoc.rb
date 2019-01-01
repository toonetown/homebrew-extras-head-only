require 'formula'

class Appledoc < Formula
  desc "Objective-C API documentation generator"
  homepage "http://appledoc.gentlebytes.com/"
  head "https://github.com/tomaz/appledoc.git"

  depends_on :xcode => :build
  depends_on :macos => :lion

  def install
    xcodebuild "-workspace", "appledoc.xcworkspace",
               "-scheme", "appledoc",
               "-derivedDataPath", "/tmp",
               "-configuration", "Release",
               "clean", "install",
               "DSTROOT=build",
               "INSTALL_PATH=/bin",
               "OTHER_CFLAGS='-DCOMPILE_TIME_DEFAULT_TEMPLATE_PATH=@\"#{prefix}/Templates\"'"
    bin.install "build/bin/appledoc"
    prefix.install "Templates/"
  end

  test do
    (testpath/"test.h").write <<~EOS
      /**
       * This is a test class. It does stuff.
       *
       * Here **is** some `markdown`.
       */

      @interface X : Y

      /**
       * Does a thing.
       *
       * @returns An instance of X.
       * @param thing The thing to copy.
       */
      + (X *)thingWithThing:(X *)thing;

      @end
    EOS

    system bin/"appledoc", "--project-name", "Test",
                           "--project-company", "Homebrew",
                           "--create-html",
                           "--no-install-docset",
                           "--keep-intermediate-files",
                           "--docset-install-path", testpath,
                           "--output", testpath,
                           testpath/"test.h"
  end
end
