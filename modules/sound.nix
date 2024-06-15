{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  sound.enable = false;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
}
