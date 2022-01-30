import 'package:json_annotation/json_annotation.dart';

part 'itemresponse.g.dart';

@JsonSerializable()
class ItemResponse{
  int id;
  String title;


  ItemResponse({required this.id, required this.title});

  factory ItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ItemResponseToJson(this);
}