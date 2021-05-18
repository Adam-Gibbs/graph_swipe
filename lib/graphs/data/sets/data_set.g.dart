// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataSet _$DataSetFromJson(Map<String, dynamic> json) {
  return DataSet(
    json['label'] as String,
    transparency: (json['transparency'] as num).toDouble(),
  )
    ..data = DataList.fromJson(json['data'] as Map<String, dynamic>)
    ..mainColour =
        (json['mainColour'] as List<dynamic>).map((e) => e as int).toList();
}

Map<String, dynamic> _$DataSetToJson(DataSet instance) => <String, dynamic>{
      'data': instance.data,
      'label': instance.label,
      'mainColour': instance.mainColour,
      'transparency': instance.transparency,
    };
