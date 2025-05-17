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
      password: json['password'] as String,
    )..password_reset_token = json['password_reset_token'] as String?;

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
      'password': instance.password,
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
          : DataInfoLogin.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetUserInfoToJson(GetUserInfo instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

DataInfoLogin _$DataInfoLoginFromJson(Map<String, dynamic> json) =>
    DataInfoLogin(
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
      companies: json['companies'] == null
          ? null
          : Company.fromJson(json['companies'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataInfoLoginToJson(DataInfoLogin instance) =>
    <String, dynamic>{
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
      'companies': instance.companies,
    };

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
      sort: json['sort'],
      owner: (json['owner'] as num?)?.toInt(),
      created_on: json['created_on'] as String?,
      modified_by: (json['modified_by'] as num?)?.toInt(),
      modified_on: json['modified_on'] as String?,
      name: json['name'] as String?,
      logo: (json['logo'] as num?)?.toInt(),
      email: json['email'] as String?,
      whatsapp: json['whatsapp'] as String?,
      website: json['website'] as String?,
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'sort': instance.sort,
      'owner': instance.owner,
      'created_on': instance.created_on,
      'modified_by': instance.modified_by,
      'modified_on': instance.modified_on,
      'name': instance.name,
      'logo': instance.logo,
      'email': instance.email,
      'whatsapp': instance.whatsapp,
      'website': instance.website,
    };
