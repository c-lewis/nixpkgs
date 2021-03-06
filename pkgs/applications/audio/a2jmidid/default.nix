{ stdenv, fetchurl, makeWrapper, pkgconfig, alsaLib, dbus, jack2
, python, pythonDBus }:

stdenv.mkDerivation rec {
  name = "a2jmidid-${version}";
  version = "8";

  src = fetchurl {
    url = "http://download.gna.org/a2jmidid/${name}.tar.bz2";
    sha256 = "0pzm0qk5ilqhwz74pydg1jwrds27vm47185dakdrxidb5bv3b5ia";
  };

  buildInputs = [ makeWrapper pkgconfig alsaLib dbus jack2 python pythonDBus ];

  configurePhase = "python waf configure --prefix=$out";

  buildPhase = "python waf";

  installPhase = ''
    python waf install
    wrapProgram $out/bin/a2j_control --set PYTHONPATH $PYTHONPATH
  '';

  meta = with stdenv.lib; {
    homepage = http://home.gna.org/a2jmidid;
    description = "Daemon for exposing legacy ALSA sequencer applications in JACK MIDI system";
    license = licenses.gpl2;
    maintainers = [ maintainers.goibhniu ];
    platforms = platforms.linux;
  };
}
