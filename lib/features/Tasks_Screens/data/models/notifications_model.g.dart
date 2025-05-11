// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNotificationForUserModel _$GetNotificationForUserModelFromJson(
        Map<String, dynamic> json) =>
    GetNotificationForUserModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataNotificationUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetNotificationForUserModelToJson(
        GetNotificationForUserModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

DataNotificationUser _$DataNotificationUserFromJson(
        Map<String, dynamic> json) =>
    DataNotificationUser(
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
      sort: json['sort'] as String?,
      owner: (json['owner'] as num?)?.toInt(),
      created_on: json['created_on'] as String?,
      modified_by: (json['modified_by'] as num?)?.toInt(),
      modified_on: json['modified_on'] as String?,
      message: json['message'] as String?,
      user: (json['user'] as num?)?.toInt(),
      title: json['title'] as String?,
      is_read: json['is_read'] as bool?,
    );

Map<String, dynamic> _$DataNotificationUserToJson(
        DataNotificationUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'sort': instance.sort,
      'owner': instance.owner,
      'created_on': instance.created_on,
      'modified_by': instance.modified_by,
      'modified_on': instance.modified_on,
      'message': instance.message,
      'user': instance.user,
      'title': instance.title,
      'is_read': instance.is_read,
    };

PostNotificationModel _$PostNotificationModelFromJson(
        Map<String, dynamic> json) =>
    PostNotificationModel(
      data: json['data'] == null
          ? null
          : DataNotificationUser.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostNotificationModelToJson(
        PostNotificationModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

GetAllNotificationModel _$GetAllNotificationModelFromJson(
        Map<String, dynamic> json) =>
    GetAllNotificationModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataNotificationUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllNotificationModelToJson(
        GetAllNotificationModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      data: json['data'] == null
          ? null
          : DataLocationModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

GetLocationModel _$GetLocationModelFromJson(Map<String, dynamic> json) =>
    GetLocationModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataLocationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetLocationModelToJson(GetLocationModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

LocationRequestModel _$LocationRequestModelFromJson(
        Map<String, dynamic> json) =>
    LocationRequestModel(
      status: json['status'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      address: json['address'] as String?,
      map_url: json['map_url'] as String?,
      task: json['task'] as String?,
    );

Map<String, dynamic> _$LocationRequestModelToJson(
        LocationRequestModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'map_url': instance.map_url,
      'task': instance.task,
    };

DataLocationModel _$DataLocationModelFromJson(Map<String, dynamic> json) =>
    DataLocationModel(
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
      sort: json['sort'] as String?,
      owner: (json['owner'] as num?)?.toInt(),
      created_on: json['created_on'] as String?,
      modified_by: (json['modified_by'] as num?)?.toInt(),
      modified_on: json['modified_on'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      address: json['address'] as String?,
      map_url: json['map_url'] as String?,
      task: (json['task'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DataLocationModelToJson(DataLocationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'sort': instance.sort,
      'owner': instance.owner,
      'created_on': instance.created_on,
      'modified_by': instance.modified_by,
      'modified_on': instance.modified_on,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'map_url': instance.map_url,
      'task': instance.task,
    };
