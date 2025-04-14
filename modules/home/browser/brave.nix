_: {
  programs.brave = {
    enable = true;
    commandLineArgs = ["--enable-features=TouchpadOverscrollHistoryNavigation" "--disable-experiments"];
    extensions = [
      # dark reader
      "eimadpbcbfnmbkopoojfekhnkhdbieeh"
      # enhancer for youtube
      "ponfpcnoihfmfllpaingbgckeeldkhle"
      # sponsor block
      "mnjggcdmjocbbbhaepdhchncahnbgone"
      # return youtube dislike button
      "gebbhagfogifgggkldgodflihgfeippi"
    ];
  };
}
