import 'package:flutter_learning/network/model/error.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response.g.dart';

@JsonSerializable()
class Response {
  Response({this.success, this.result, this.error, this.networkError});

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);

  bool? success;
  String? result;
  Error? error;
  String? networkError = '';

  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}
