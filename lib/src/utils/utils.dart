String capitalizeNames(String name) {
  name[0].toUpperCase();
  final List<String> list = name.split(' ');
  String finalString = '';
  for (String item in list) {
    finalString += item[0].toUpperCase() + item.substring(1) + ' ';
  }
  return finalString;
}

class Fonts {
  static const String SOMANTIC_FONT = 'Somantic';
  static const String POPPINS = 'Poppins';
}
