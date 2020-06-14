class CarlaGit < Formula
  desc "Audio plugin host supporting LADSPA, LV2, VST2/3, SF2 and more"
  homepage "https://kxstudio.linuxaudio.org/Applications:Carla"
  url "https://github.com/falkTX/Carla/archive/@VERSION@.zip"
  sha256 "adcfbf85bef896ce9228480b000b24a328b1dea647ea6b81e8724d471f1d0ffc"
  head "https://github.com/falkTX/Carla.git"
  version "0.1.1"

  bottle do
    cellar :any
    sha256 "0149197353ef0d86c25623d77688a0f3ce045263d76213e7174a3107d10222ea" => :catalina
    sha256 "097ebd9b6fbb10cbcf46cd10b58f8305159ef090d68ae8d89049f0c0b8998d9c" => :mojave
    sha256 "51ee66c8406766f33784fe139c292bad745ff43581164168f30f5ffa77171a06" => :high_sierra
  end

  depends_on "pkg-config" => :build
  depends_on "fluid-synth"
  depends_on "liblo"
  depends_on "libmagic"
  depends_on "pyqt"
  depends_on "python@3.8"

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"

    inreplace bin/"carla", "PYTHON=$(which python3 2>/dev/null)",
                           "PYTHON=#{Formula["python@3.8"].opt_bin}/python3"
    system "cp", "#{lib}/carla/carla-discovery-native",
      "#{bin}/"
  end

  test do
    system bin/"carla", "--version"
    system lib/"carla/carla-discovery-native", "internal", ":all"
  end
end
