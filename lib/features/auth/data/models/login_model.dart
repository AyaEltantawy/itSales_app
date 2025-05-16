import 'package:json_annotation/json_annotation.dart';

import '../../../addEmployee/data/models/add_employee_model.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  DataLoginModel? data;
  bool? public;

  LoginModel({this.data, this.public});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

@JsonSerializable()
class DataLoginModel {
  String? token;
  User? user;

  DataLoginModel({this.token, this.user});

  factory DataLoginModel.fromJson(Map<String, dynamic> json) =>
      _$DataLoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataLoginModelToJson(this);
}

@JsonSerializable()
class User {
  String? id;
  String? status;
  String? role;
  String? first_name;
  String? last_name;
  String? email;
  String? time_zone;
  String? locale;

  // String? locale_options;
  // String? avatar;
  // String? company;
  // String? title;
  // String? externalId;
  String? theme;

  // String? n2fa_secret;
  String? password_reset_token;

  User(
      {this.id,
      this.status,
      this.role,
      this.first_name,
      this.last_name,
      this.email,
      this.time_zone,
      this.locale,
      this.theme,
     required String password});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class SalesModel {
  String? email;
  String? password;

  SalesModel(
      {this.email,
      this.password,
    });

  factory SalesModel.fromJson(Map<String, dynamic> json) =>
      _$SalesModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesModelToJson(this);
}

@JsonSerializable()
class GetUserInfo {
  DataInfoLogin? data;

  GetUserInfo({this.data});

  factory GetUserInfo.fromJson(Map<String, dynamic> json) =>
      _$GetUserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserInfoToJson(this);
}

@JsonSerializable()
class DataInfoLogin {
  int? id;
  String? status;
  Role? role;
  String? first_name;
  String? last_name;
  String? email;
  String? token;
  String? external_id;
  String? theme;
  String? n2fa_secret;
  String? password_reset_token;
  String? time_zone;
  String? locale;
  String? locale_options;
  Avatar? avatar;
  String? company;
  String? title;
  bool? email_notifications;
  String? last_accessOn;
  String? last_page;

  DataInfoLogin(
      {this.id,
      this.status,
      this.role,
      this.first_name,
      this.last_name,
      this.email,
      this.token,
      this.external_id,
      this.theme,
      this.n2fa_secret,
      this.password_reset_token,
      this.time_zone,
      this.locale,
      this.locale_options,
      this.avatar,
      this.company,
      this.title,
      this.email_notifications,
      this.last_accessOn,
      this.last_page});

  factory DataInfoLogin.fromJson(Map<String, dynamic> json) =>
      _$DataInfoLoginFromJson(json);

  Map<String, dynamic> toJson() => _$DataInfoLoginToJson(this);
}
