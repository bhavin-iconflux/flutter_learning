// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Error _$ErrorFromJson(Map<String, dynamic> json) => Error(
      statusCode: json['statusCode'] as int?,
      error: json['error'] as String?,
      message: json['message'] as String?,
      errorId: json['error_id'] as String?,
      rootErrorId: json['root_error_id'] as String?,
    );

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
      'statusCode': instance.statusCode,
      'error': instance.error,
      'message': instance.message,
      'error_id': instance.errorId,
      'root_error_id': instance.rootErrorId,
    };
