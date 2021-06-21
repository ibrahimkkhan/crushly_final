extension StringExtension on String {
  String capitalize() {
    String fullString = this;
    String finalString = '';

    List<String> parts = fullString.split(' ');
    for (int i = 0; i < parts.length; i++) {
      String part = parts[i];
      finalString += part[0].toUpperCase() + part.substring(1);
      if (i + 1 < parts.length) {
        finalString += ' ';
      }
    }
    return finalString;
  }
}