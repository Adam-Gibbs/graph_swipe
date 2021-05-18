// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_set_bar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataSetBar _$DataSetBarFromJson(Map<String, dynamic> json) {
  return DataSetBar(
    json['label'] as String,
    transparency: (json['transparency'] as num).toDouble(),
    borderColour:
        (json['borderColour'] as List<dynamic>).map((e) => e as int).toList(),
    borderWidth: json['borderWidth'] as int,
    yAxis: json['yAxis'] as String,
    xAxis: json['xAxis'] as String,
  )
    ..data = DataList.fromJson(json['data'] as Map<String, dynamic>)
    ..mainColour =
        (json['mainColour'] as List<dynamic>).map((e) => e as int).toList()
    ..borderTransparency = (json['borderTransparency'] as num).toDouble();
}

Map<String, dynamic> _$DataSetBarToJson(DataSetBar instance) =>
    <String, dynamic>{
      'data': instance.data,
      'label': instance.label,
      'mainColour': instance.mainColour,
      'transparency': instance.transparency,
      'borderColour': instance.borderColour,
      'borderTransparency': instance.borderTransparency,
      'borderWidth': instance.borderWidth,
      'yAxis': instance.yAxis,
      'xAxis': instance.xAxis,
    };
