import 'country_names.dart';

class Country {
  bool isSelected;
  final String image;
  final int id;
  List<RelatedNames> relatedNames;

  Country({
    required this.image,
    required this.isSelected,
    required this.id,
    required this.relatedNames,
  });
}
