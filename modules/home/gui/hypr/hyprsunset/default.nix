{ ... }:

{
  services.hyprsunset = {
    enable = true;
    settings = {
      profile = [
        {
          time = "08:00";
          identity = true;
        }
        {
          time = "21:30";
          temperature = 5800;
          gamma = 0.95;
        }
      ];
    };
  };
}
