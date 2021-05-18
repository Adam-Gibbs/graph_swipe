// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graph.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Graph _$GraphFromJson(Map<String, dynamic> json) {
  return Graph(
    json['type'] as String,
    (json['xLabels'] as List<dynamic>).map((e) => e as String).toList(),
  )
    ..dataSets = (json['dataSets'] as List<dynamic>)
        .map((e) => DataSet.fromJson(e as Map<String, dynamic>))
        .toList()
    ..options = Options.fromJson(json['options'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GraphToJson(Graph instance) => <String, dynamic>{
      'dataSets': instance.dataSets,
      'options': instance.options,
      'type': instance.type,
      'xLabels': instance.xLabels,
    };
