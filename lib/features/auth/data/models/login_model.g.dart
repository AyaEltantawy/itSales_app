// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      data: json['data'] == null
          ? null
          : DataLoginModel.fromJson(json['data'] as Map<String, dynamic>),
      public: json['public'] as bool?,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'public': instance.public,
    };

DataLoginModel _$DataLoginModelFromJson(Map<String, dynamic> json) =>
    DataLoginModel(
      token: json['token'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataLoginModelToJson(DataLoginModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      status: json['status'] as String?,
      role: json['role'] as String?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      email: json['email'] as String?,
      time_zone: json['time_zone'] as String?,
      locale: json['locale'] as String?,
      theme: json['theme'] as String?,
      password_reset_token: json['password_reset_token'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'role': instance.role,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'time_zone': instance.time_zone,
      'locale': instance.locale,
      'theme': instance.theme,
      'password_reset_token': instance.password_reset_token,
    };

SalesModel _$SalesModelFromJson(Map<String, dynamic> json) => SalesModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$SalesModelToJson(SalesModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

GetUserInfo _$GetUserInfoFromJson(Map<String, dynamic> json) => GetUserInfo(
      data: json['data'] == null
          ? null
          : DataInfo.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetUserInfoToJson(GetUserInfo instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

DataInfo _$DataInfoFromJson(Map<String, dynamic> json) => DataInfo(
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
      role: json['role'] == null
          ? null
          : Role.fromJson(json['role'] as Map<String, dynamic>),
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      email: json['email'] as String?,
      token: json['token'] as String?,
      external_id: json['external_id'] as String?,
      theme: json['theme'] as String?,
      n2fa_secret: json['n2fa_secret'] as String?,
      password_reset_token: json['password_reset_token'] as String?,
      time_zone: json['time_zone'] as String?,
      locale: json['locale'] as String?,
      locale_options: json['locale_options'] as String?,
      avatar: json['avatar'] == null
          ? null
          : Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
      company: json['company'] as String?,
      title: json['title'] as String?,
      email_notifications: json['email_notifications'] as bool?,
      last_accessOn: json['last_accessOn'] as String?,
      last_page: json['last_page'] as String?,
    );

Map<String, dynamic> _$DataInfoToJson(DataInfo instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'role': instance.role,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'token': instance.token,
      'external_id': instance.external_id,
      'theme': instance.theme,
      'n2fa_secret': instance.n2fa_secret,
      'password_reset_token': instance.password_reset_token,
      'time_zone': instance.time_zone,
      'locale': instance.locale,
      'locale_options': instance.locale_options,
      'avatar': instance.avatar,
      'company': instance.company,
      'title': instance.title,
      'email_notifications': instance.email_notifications,
      'last_accessOn': instance.last_accessOn,
      'last_page': instance.last_page,
    };
