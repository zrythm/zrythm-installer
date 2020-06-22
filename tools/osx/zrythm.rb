class Zrythm < Formula
  resource("fix_paths_script") do
    url "https://git.zrythm.org/cgit/zrythm-installer/plain/tools/osx/cp_and_fix_dependency_paths.sh"
    sha256 "385d934730e48516261f7f8fd927cc7a232b5c86ab63e3a4e40dda8e0bff7d57"
  end
  desc "Digital audio workstation"
  homepage "https://www.zrythm.org"
  url "https://git.zrythm.org/cgit/zrythm/snapshot/@TARBALL_FILENAME@"
  sha256 "@SHA256@"
  version "@VERSION@"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "help2man" => :build
  depends_on "libyaml"
  depends_on "gtk+3"
  depends_on "guile"
  depends_on "ffmpeg"
  depends_on "fftw"
  depends_on "libsamplerate"
  depends_on "lilv"
  depends_on "librsvg"
  depends_on "gtksourceview4"
  depends_on "graphviz"
  depends_on "rubberband"
  depends_on "sdl2"
  depends_on "rt-audio"
  depends_on "rtmidi"
  depends_on "zstd"
  depends_on "carla-git"
  depends_on "jack"
  depends_on "qjackctl"

  def install
    mkdir "build" do
      system "meson", *std_meson_args, "-Dtests=false", "-Dtrial_ver=false",
        "-Dcarla=enabled", "-Dffmpeg=enabled",
        "-Drtmidi=auto", "-Drtaudio=auto",
        "-Dfallback_version=@VERSION@",
        ".."
      system "ninja", "-v"
      system "ninja", "install", "-v"
      system "cp", "-r", "/tmp/breeze-dark", "#{share}/icons/breeze-dark"
      # copy all libs
      resource("fix_paths_script").stage do
        system "mkdir", "-p", "#{lib}/zrythm"
        system "ls", "-la"
        system "bash", "cp_and_fix_dependency_paths.sh", "#{bin}/zrythm", "/usr/local/opt", "#{lib}/zrythm", "copy", "true"
        system "bash", "cp_and_fix_dependency_paths.sh", "#{bin}/zrythm", "/usr/local/opt", "#{lib}/zrythm", "fix-in-dir", "false"
        system "bash", "cp_and_fix_dependency_paths.sh", "#{bin}/zrythm", "/usr/local/opt", "#{lib}/zrythm", "fix", "false"
      end
    end
  end

  test do
    system "#{bin}/zrythm", "--version"
  end
end
