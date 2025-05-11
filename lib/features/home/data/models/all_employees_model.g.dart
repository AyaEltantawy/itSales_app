// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_employees_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllEmployeeModel _$AllEmployeeModelFromJson(Map<String, dynamic> json) =>
    AllEmployeeModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataAllEmployee.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllEmployeeModelToJson(AllEmployeeModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

DataAllEmployee _$DataAllEmployeeFromJson(Map<String, dynamic> json) =>
    DataAllEmployee(
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
      owner: (json['owner'] as num?)?.toInt(),
      created_on: json['created_on'] as String?,
      modified_by: (json['modified_by'] as num?)?.toInt(),
      modified_on: json['modified_on'] as String?,
      phone_1: json['phone_1'] as String?,
      phone_2: json['phone_2'] as String?,
      whatsapp: json['whatsapp'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      user: (json['user'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DataAllEmployeeToJson(DataAllEmployee instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'owner': instance.owner,
      'created_on': instance.created_on,
      'modified_by': instance.modified_by,
      'modified_on': instance.modified_on,
      'phone_1': instance.phone_1,
      'phone_2': instance.phone_2,
      'whatsapp': instance.whatsapp,
      'email': instance.email,
      'address': instance.address,
      'user': instance.user,
    };
