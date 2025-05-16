
import 'package:json_annotation/json_annotation.dart';

import '../../../../addEmployee/data/models/add_employee_model.dart';
import '../../../data/models/login_model.dart';



part 'register_model.g.dart';


@JsonSerializable()

class RegisterModel {
  DataRegisterModel? data;
  bool? public;

  RegisterModel({this.data, this.public});
  factory RegisterModel.fromJson(Map<String, dynamic> json) => _$RegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);


}

@JsonSerializable()
class DataRegisterModel {
  String? token;
  User? user;

  DataRegisterModel({this.token, this.user});
  factory DataRegisterModel.fromJson(Map<String, dynamic> json) => _$DataRegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataRegisterModelToJson(this);

}

@JsonSerializable()

 // Make sure this points to the correct generated file

@JsonSerializable()
class User {
  final String? password;
  final String? id;
  final String? status;
  final String? role;
  final String? first_name;
  final String? last_name;
  final String? email;
  //final String? time_zone;
  final String? locale;
  final String? theme;




  User({this.password,
    this.id,
    this.status,
    this.role,
    this.first_name,
    this.last_name,
    this.email,
   // this.time_zone,
    this.locale,
    this.theme,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

}
@JsonSerializable()
class GetUserRegisterInfo {
  DataInfo? data;

  GetUserRegisterInfo({this.data});

  factory GetUserRegisterInfo.fromJson(Map<String, dynamic> json) =>
      _$GetUserRegisterInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserRegisterInfoToJson(this as GetUserRegisterInfo);
}
@JsonSerializable()
class DataInfo {
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


  String? locale;
  String? locale_options;
  Avatar? avatar;
  String? company;
  String? title;
  bool? email_notifications;
  String? last_accessOn;
  String? last_page;

  DataInfo(
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


        this.locale,
        this.locale_options,
        this.avatar,
        this.company,
        this.title,
        this.email_notifications,
        this.last_accessOn,
        this.last_page});

  factory DataInfo.fromJson(Map<String, dynamic> json) => _$DataInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DataInfoToJson(this);

}