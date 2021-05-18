// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line_graph.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LineGraph _$LineGraphFromJson(Map<String, dynamic> json) {
  return LineGraph(
    (json['xLabels'] as List<dynamic>).map((e) => e as String).toList(),
  )
    ..dataSets = (json['dataSets'] as List<dynamic>)
        .map((e) => DataSet.fromJson(e as Map<String, dynamic>))
        .toList()
    ..options = Options.fromJson(json['options'] as Map<String, dynamic>)
    ..type = json['type'] as String;
}

Map<String, dynamic> _$LineGraphToJson(LineGraph instance) => <String, dynamic>{
      'dataSets': instance.dataSets,
      'options': instance.options,
      'type': instance.type,
      'xLabels': instance.xLabels,
    };
