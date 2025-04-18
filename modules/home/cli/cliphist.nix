_: {
  services.cliphist = {
    enable = true;
    allowImages = false;
    extraOptions = [
      "-max-dedupe-search"
      "10"
      "-max-items"
      "500"
    ];
  };
}
