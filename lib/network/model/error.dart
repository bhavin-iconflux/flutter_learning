

import 'package:json_annotation/json_annotation.dart';
part 'error.g.dart';
@JsonSerializable()
class Error{
  Error({this.statusCode,this.error,this.message,this.errorId,this.rootErrorId});

  int? statusCode;
  String? error;
  String? message;
  @JsonKey(name: 'error_id')
  String? errorId;
  @JsonKey(name: 'root_error_id')
  String? rootErrorId;

  factory Error.fromJson(Map<String, dynamic> json) =>
      _$ErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}