// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scale_groups.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScaleGroups _$ScaleGroupsFromJson(Map<String, dynamic> json) {
  return ScaleGroups()
    ..xScales = (json['xScales'] as List<dynamic>)
        .map((e) => Scale.fromJson(e as Map<String, dynamic>))
        .toList()
    ..yScales = (json['yScales'] as List<dynamic>)
        .map((e) => Scale.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$ScaleGroupsToJson(ScaleGroups instance) =>
    <String, dynamic>{
      'xScales': instance.xScales,
      'yScales': instance.yScales,
    };
