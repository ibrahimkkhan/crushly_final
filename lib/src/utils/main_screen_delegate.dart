
abstract class MainScreenDelegate {
  void iconClicked(MainScreenIcon mainScreenIcon);

  void openChatPage(
    bool originallySecret,
    String otherName,
    final String otherID,
    final bool isFromFolloweePage,
    bool presentlySecret,
    String otherImage,
  );
}

enum MainScreenIcon { PROFILE, HOME, MESSAGES }
