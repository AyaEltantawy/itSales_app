


import 'package:json_annotation/json_annotation.dart';

part 'notifications_model.g.dart';


@JsonSerializable()
class GetNotificationForUserModel {
  List<DataNotificationUser>? data;

  GetNotificationForUserModel({this.data});

  factory GetNotificationForUserModel.fromJson(Map<String, dynamic> json) => _$GetNotificationForUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetNotificationForUserModelToJson(this);

}


@JsonSerializable()
class DataNotificationUser {
  int? id;
  String? status;
  String? sort;
  int? owner;
  String? created_on;
  int? modified_by;
  String? modified_on;
  String? message;
  int? user;
  String? title;
  bool? is_read;

  DataNotificationUser({this.id,
    this.status,
    this.sort,
    this.owner,
    this.created_on,
    this.modified_by,
    this.modified_on,
    this.message,
    this.user,
    this.title,
    this.is_read});



  factory DataNotificationUser.fromJson(Map<String, dynamic> json) => _$DataNotificationUserFromJson(json);

  Map<String, dynamic> toJson() => _$DataNotificationUserToJson(this);

}

@JsonSerializable()
class PostNotificationModel {
  DataNotificationUser? data;

  PostNotificationModel({this.data});


  factory PostNotificationModel.fromJson(Map<String, dynamic> json) => _$PostNotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostNotificationModelToJson(this);

}


@JsonSerializable()
class GetAllNotificationModel {
  List<DataNotificationUser>? data;

  GetAllNotificationModel({this.data});

  factory GetAllNotificationModel.fromJson(Map<String, dynamic> json) => _$GetAllNotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllNotificationModelToJson(this);

}


@JsonSerializable()
class LocationModel {
  DataLocationModel? data;

  LocationModel({this.data});


  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

}

@JsonSerializable()
class GetLocationModel {
 List<DataLocationModel>? data;

  GetLocationModel({this.data});


  factory GetLocationModel.fromJson(Map<String, dynamic> json) => _$GetLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetLocationModelToJson(this);

}


@JsonSerializable()
class LocationRequestModel {
  String? status;
  String? latitude;
  String? longitude;
  String? address;
  String? map_url;
  String? task;

  LocationRequestModel({this.status,
    this.latitude,
    this.longitude,
    this.address,
    this.map_url,
    this.task});


  factory LocationRequestModel.fromJson(Map<String, dynamic> json) => _$LocationRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationRequestModelToJson(this);

}

@JsonSerializable()
class DataLocationModel {
  int? id;
  String? status;
  String? sort;
  int? owner;
  String? created_on;
  int? modified_by;
  String? modified_on;
  String? latitude;
  String? longitude;
  String? address;
  String? map_url;
  int? task;

  DataLocationModel({this.id,
    this.status,
    this.sort,
    this.owner,
    this.created_on,
    this.modified_by,
    this.modified_on,
    this.latitude,
    this.longitude,
    this.address,
    this.map_url,
    this.task});

  factory DataLocationModel.fromJson(Map<String, dynamic> json) => _$DataLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataLocationModelToJson(this);


}
