// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterModel _$RegisterModelFromJson(Map<String, dynamic> json) =>
    RegisterModel(
      data: json['data'] == null
          ? null
          : DataRegisterModel.fromJson(json['data'] as Map<String, dynamic>),
      public: json['public'] as bool?,
    );

Map<String, dynamic> _$RegisterModelToJson(RegisterModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'public': instance.public,
    };

DataRegisterModel _$DataRegisterModelFromJson(Map<String, dynamic> json) =>
    DataRegisterModel(
      token: json['token'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataRegisterModelToJson(DataRegisterModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      password: json['password'] as String?,
      id: json['id'] as String?,
      status: json['status'] as String?,
      role: json['role'] as String?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      email: json['email'] as String?,
      locale: json['locale'] as String?,
      theme: json['theme'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'password': instance.password,
      'id': instance.id,
      'status': instance.status,
      'role': instance.role,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'locale': instance.locale,
      'theme': instance.theme,
    };

GetUserRegisterInfo _$GetUserRegisterInfoFromJson(Map<String, dynamic> json) =>
    GetUserRegisterInfo(
      data: json['data'] == null
          ? null
          : DataInfo.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetUserRegisterInfoToJson(
        GetUserRegisterInfo instance) =>
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
      'locale': instance.locale,
      'locale_options': instance.locale_options,
      'avatar': instance.avatar,
      'company': instance.company,
      'title': instance.title,
      'email_notifications': instance.email_notifications,
      'last_accessOn': instance.last_accessOn,
      'last_page': instance.last_page,
    };
