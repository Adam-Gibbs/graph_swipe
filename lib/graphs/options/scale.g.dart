// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scale _$ScaleFromJson(Map<String, dynamic> json) {
  return Scale(
    json['id'] as String,
    json['position'] as String,
    display: json['display'] as bool,
    displayLabel: json['displayLabel'] as bool,
    label: json['label'] as String,
    stacked: json['stacked'] as bool,
  );
}

Map<String, dynamic> _$ScaleToJson(Scale instance) => <String, dynamic>{
      'id': instance.id,
      'position': instance.position,
      'display': instance.display,
      'displayLabel': instance.displayLabel,
      'label': instance.label,
      'stacked': instance.stacked,
    };
