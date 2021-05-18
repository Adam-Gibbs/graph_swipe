// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_pair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataPair _$DataPairFromJson(Map<String, dynamic> json) {
  return DataPair(
    (json['pair'] as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
  )..value = (json['value'] as num).toDouble();
}

Map<String, dynamic> _$DataPairToJson(DataPair instance) => <String, dynamic>{
      'value': instance.value,
      'pair': instance.pair,
    };
