// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_graphs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouriteGraphs _$FavouriteGraphsFromJson(Map<String, dynamic> json) {
  return FavouriteGraphs()
    ..graphs = (json['graphs'] as List<dynamic>)
        .map((e) => Graph.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$FavouriteGraphsToJson(FavouriteGraphs instance) =>
    <String, dynamic>{
      'graphs': instance.graphs,
    };
