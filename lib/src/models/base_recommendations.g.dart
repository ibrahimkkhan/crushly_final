// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_recommendations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseRecommendations _$BaseRecommendationsFromJson(Map<String, dynamic> json) {
  return BaseRecommendations(
    (json['recommendations'] as List<dynamic>)
        .map((e) => Recommendation.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BaseRecommendationsToJson(
        BaseRecommendations instance) =>
    <String, dynamic>{
      'recommendations': instance.recommendations,
    };
