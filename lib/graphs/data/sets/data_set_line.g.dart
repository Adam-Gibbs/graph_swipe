// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_set_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataSetLine _$DataSetLineFromJson(Map<String, dynamic> json) {
  return DataSetLine(
    json['label'] as String,
    transparency: (json['transparency'] as num).toDouble(),
    lineColour:
        (json['lineColour'] as List<dynamic>).map((e) => e as int).toList(),
    fill: json['fill'] as bool,
    stepped: json['stepped'] as bool,
    dashed: json['dashed'] as bool,
    curved: json['curved'] as bool,
    showLine: json['showLine'] as bool,
    pointStyle: json['pointStyle'] as String,
    pointRadius: json['pointRadius'] as int,
    yAxis: json['yAxis'] as String,
    xAxis: json['xAxis'] as String,
  )
    ..data = DataList.fromJson(json['data'] as Map<String, dynamic>)
    ..mainColour =
        (json['mainColour'] as List<dynamic>).map((e) => e as int).toList();
}

Map<String, dynamic> _$DataSetLineToJson(DataSetLine instance) =>
    <String, dynamic>{
      'data': instance.data,
      'label': instance.label,
      'mainColour': instance.mainColour,
      'transparency': instance.transparency,
      'lineColour': instance.lineColour,
      'fill': instance.fill,
      'stepped': instance.stepped,
      'dashed': instance.dashed,
      'curved': instance.curved,
      'showLine': instance.showLine,
      'pointStyle': instance.pointStyle,
      'pointRadius': instance.pointRadius,
      'yAxis': instance.yAxis,
      'xAxis': instance.xAxis,
    };
