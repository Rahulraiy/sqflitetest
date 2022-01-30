part of 'itemresponse.dart';


ItemResponse _$ItemResponseFromJson(Map<String, dynamic> json) =>
    ItemResponse(
      id: json['id'] as int,
      title: json['title'] as String,
    );

Map<String, dynamic> _$ItemResponseToJson(ItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,

    };