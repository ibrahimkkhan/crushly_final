import 'User.dart';
import 'recommendation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_recommendations.g.dart';

@JsonSerializable()
class BaseRecommendations {
  final List<Recommendation> recommendations;

  BaseRecommendations(this.recommendations);

  factory BaseRecommendations.fromJson(Map<String, dynamic> json) =>
      _$BaseRecommendationsFromJson(json);
}
