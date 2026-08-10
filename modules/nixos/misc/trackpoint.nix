{ config, lib, ... }:

{
  config = lib.mkIf config.host.feature.disableTrackpointDot {
    environment.etc."libinput/local-overrides.quirks".text = ''
      [Disable Trackpoint Movement]
      MatchName=*TrackPoint*
      AttrEventCode=-REL_X;-REL_Y;
    '';
  };
}
