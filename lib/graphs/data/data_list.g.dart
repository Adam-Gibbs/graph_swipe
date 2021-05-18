// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataList _$DataListFromJson(Map<String, dynamic> json) {
  return DataList()
    ..data = (json['data'] as List<dynamic>)
        .map((e) => Data.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$DataListToJson(DataList instance) => <String, dynamic>{
      'data': instance.data,
    };
