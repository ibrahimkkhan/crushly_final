import 'package:equatable/equatable.dart';

class RelatedNames extends Equatable {
  final bool isSelected;
  final String name;

  RelatedNames({
    required this.name,
    this.isSelected = false,
  });

  @override
  List<Object> get props => [name];
}
