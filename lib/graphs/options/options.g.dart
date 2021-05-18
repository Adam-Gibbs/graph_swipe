// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Options _$OptionsFromJson(Map<String, dynamic> json) {
  return Options(
    json['title'] as String,
    ScaleGroups.fromJson(json['scales'] as Map<String, dynamic>),
    displayTitle: json['displayTitle'] as bool,
    legendPosition: json['legendPosition'] as String,
    legendDisplay: json['legendDisplay'] as bool,
    dataLabels: json['dataLabels'] as bool,
    roundedBars: json['roundedBars'] as bool,
  );
}

Map<String, dynamic> _$OptionsToJson(Options instance) => <String, dynamic>{
      'title': instance.title,
      'displayTitle': instance.displayTitle,
      'legendPosition': instance.legendPosition,
      'legendDisplay': instance.legendDisplay,
      'dataLabels': instance.dataLabels,
      'roundedBars': instance.roundedBars,
      'scales': instance.scales,
    };
