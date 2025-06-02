import 'package:json_annotation/json_annotation.dart';

part 'add_employee_model.g.dart';

@JsonSerializable()
class AddUserRequestModel {
  String? email;
  String? password;
  String? status;
  String? first_name;
  String? last_name;

  String? role;

  int? companies;

  AddUserRequestModel(
      {this.email,
      this.password,
      this.status,
      this.first_name,
      this.last_name,
      this.role,
      this.companies});

  factory AddUserRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AddUserRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddUserRequestModelToJson(this);
}

@JsonSerializable()
class EditUserRequestModel {
  String? email;
  String? status;
  String? first_name;
  String? last_name;
  String? role;
  String? password;
  int? avatar;
  int? companies;

  EditUserRequestModel(
      {this.email,
      this.status,
      this.first_name,
      this.last_name,
      this.role,
      this.avatar,
      this.password,
      this.companies});

  factory EditUserRequestModel.fromJson(Map<String, dynamic> json) =>
      _$EditUserRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditUserRequestModelToJson(this);
}

@JsonSerializable()
class AddUserModel {
  DataUserResponse? data;

  AddUserModel({this.data});

  factory AddUserModel.fromJson(Map<String, dynamic> json) =>
      _$AddUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddUserModelToJson(this);
}

@JsonSerializable()
class AllUsersModel {
  List<DataUser>? data;

  AllUsersModel({this.data});

  factory AllUsersModel.fromJson(Map<String, dynamic> json) =>
      _$AllUsersModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllUsersModelToJson(this);
}

@JsonSerializable()
class DataUser {
  int? id;
  String? status;
  dynamic? role;
  String? first_name;
  String? last_name;
  String? email;
  String? token;
  String? external_id;
  String? theme;
  String? n2faSecret;
  String? passwordResetToken;
  String? timezone;
  String? locale;
  String? locale_options;
  Avatar? avatar;
  dynamic? companies; // <-- Added
  String? title;
  bool? email_notifications;
  String? last_accessOn;
  String? last_page;
  List<EmployeeInfo>? employee_info;

  DataUser({
    this.id,
    this.status,
    this.role,
    this.first_name,
    this.last_name,
    this.email,
    this.token,
    this.external_id,
    this.theme,
    this.n2faSecret,
    this.passwordResetToken,
    this.timezone,
    this.locale,
    this.locale_options,
    this.avatar,
    this.companies, // <-- Added
    this.title,
    this.email_notifications,
    this.last_accessOn,
    this.last_page,
    this.employee_info,
  });

  factory DataUser.fromJson(Map<String, dynamic> json) =>
      _$DataUserFromJson(json);

  Map<String, dynamic> toJson() => _$DataUserToJson(this);
}

@JsonSerializable()
class Company {
  int? id;
  String? status;
  String? sort;
  int? owner;
  String? created_on;
  int? modified_by;
  String? modified_on;
  String? name;
  int? logo;
  String? email;
  String? whatsapp;
  String? website;

  Company({
    this.id,
    this.status,
    this.sort,
    this.owner,
    this.created_on,
    this.modified_by,
    this.modified_on,
    this.name,
    this.logo,
    this.email,
    this.whatsapp,
    this.website,
  });

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}

@JsonSerializable()
class EmployeeInfo {
  int? id;
  String? status;
  String? sort;
  int? owner;
  String? created_on;
  int? modified_by;
  String? modified_on;
  String? phone_1;
  String? phone_2;
  String? whatsapp;
  String? email;
  String? address;
  int? user;

  EmployeeInfo({
    this.id,
    this.status,
    this.sort,
    this.owner,
    this.created_on,
    this.modified_by,
    this.modified_on,
    this.phone_1,
    this.phone_2,
    this.whatsapp,
    this.email,
    this.address,
    this.user,
  });

  factory EmployeeInfo.fromJson(Map<String, dynamic> json) =>
      _$EmployeeInfoFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeInfoToJson(this);
}

@JsonSerializable()
class DataUserResponse {
  int? id;
  String? status;
  int? role;
  String? first_name;
  String? last_name;
  String? email;
  String? token;
  String? external_id;
  String? theme;
  String? n2faSecret;
  String? passwordResetToken;
  String? timezone;
  String? locale;
  String? locale_options;
  int? avatar;
  dynamic? companies;
  String? title;
  bool? email_notifications;
  String? last_accessOn;
  String? last_page;

  DataUserResponse({
    this.id,
    this.status,
    this.role,
    this.first_name,
    this.last_name,
    this.email,
    this.token,
    this.external_id,
    this.theme,
    this.n2faSecret,
    this.passwordResetToken,
    this.timezone,
    this.locale,
    this.locale_options,
    this.avatar,
    this.companies,
    this.title,
    this.email_notifications,
    this.last_accessOn,
    this.last_page,
  });

  factory DataUserResponse.fromJson(Map<String, dynamic> json) =>
      _$DataUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataUserResponseToJson(this);
}

@JsonSerializable()
class Role {
  int? id;
  String? name;
  String? description;
  List<String>? ipWhitelist;
  String? external_id;
  String? module_listing;
  String? collection_listing;
  bool? enforce2fa;

  Role({
    this.id,
    this.name,
    this.description,
    this.ipWhitelist,
    this.external_id,
    this.module_listing,
    this.collection_listing,
    this.enforce2fa,
  });

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}

@JsonSerializable()
class Avatar {
  int? id;
  String? storage;
  String? private_hash;
  String? filename_disk;
  String? filename_download;
  String? title;
  String? type;
  int? uploaded_by;
  String? uploaded_on;
  String? charset;
  int? filesize;
  int? width;
  int? height;
  int? duration;
  String? embed;
  String? folder;
  String? description;
  String? location;
  List<String>? tags;
  String? checksum;
  String? metadata;
  Data? data;

  Avatar({
    this.id,
    this.storage,
    this.private_hash,
    this.filename_disk,
    this.filename_download,
    this.title,
    this.type,
    this.uploaded_by,
    this.uploaded_on,
    this.charset,
    this.filesize,
    this.width,
    this.height,
    this.duration,
    this.embed,
    this.folder,
    this.description,
    this.location,
    this.tags,
    this.checksum,
    this.metadata,
    this.data,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);

  Map<String, dynamic> toJson() => _$AvatarToJson(this);
}

@JsonSerializable()
class Data {
  String? full_url;
  String? url;
  String? asset_url;
  List<Thumbnails>? thumbnails;
  String? embed;

  Data({
    this.full_url,
    this.url,
    this.asset_url,
    this.thumbnails,
    this.embed,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Thumbnails {
  String? key;
  String? url;
  String? relative_url;
  String? dimension;
  int? width;
  int? height;

  Thumbnails({
    this.key,
    this.url,
    this.relative_url,
    this.dimension,
    this.width,
    this.height,
  });

  factory Thumbnails.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailsFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailsToJson(this);
}

@JsonSerializable()
class AddEmployeeRequestModel {
  String? status;
  String? phone_1;
  String? phone_2;
  String? whatsapp;
  String? email;
  String? address;
  String? user;

  AddEmployeeRequestModel({
    this.status,
    this.phone_1,
    this.phone_2,
    this.whatsapp,
    this.email,
    this.address,
    this.user,
  });

  factory AddEmployeeRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AddEmployeeRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddEmployeeRequestModelToJson(this);
}

@JsonSerializable()
class AddEmployeeModel {
  DataEmployee? data;

  AddEmployeeModel({this.data});

  factory AddEmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$AddEmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddEmployeeModelToJson(this);
}

@JsonSerializable()
class DataEmployee {
  int? id;
  String? status;
  String? sort;
  int? owner;
  String? created_on;
  int? modified_by;
  String? modified_on;
  String? phone_1;
  String? phone_2;
  String? whatsapp;
  String? email;
  String? address;
  int? user;

  DataEmployee({
    this.id,
    this.status,
    this.sort,
    this.owner,
    this.created_on,
    this.modified_by,
    this.modified_on,
    this.phone_1,
    this.phone_2,
    this.whatsapp,
    this.email,
    this.address,
    this.user,
  });

  factory DataEmployee.fromJson(Map<String, dynamic> json) =>
      _$DataEmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$DataEmployeeToJson(this);
}

@JsonSerializable()
class GetEmployeeModel {
  List<DataEmployee>? data;

  GetEmployeeModel({this.data});

  factory GetEmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$GetEmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetEmployeeModelToJson(this);
}

@JsonSerializable()
class GetOneUserModel {
  DataGetUser? data;

  GetOneUserModel({this.data});

  factory GetOneUserModel.fromJson(Map<String, dynamic> json) =>
      _$GetOneUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetOneUserModelToJson(this);
}

@JsonSerializable()
class DataGetUser {
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
  String? password_resetToken;
  String? time_zone;
  String? locale;
  String? locale_options;
  Avatar? avatar;
  String? companies;
  String? title;
  bool? email_notifications;
  String? last_accessOn;
  String? last_page;

  DataGetUser({
    this.id,
    this.status,
    this.role,
    this.first_name,
    this.last_name,
    this.email,
    this.token,
    this.external_id,
    this.theme,
    this.n2fa_secret,
    this.password_resetToken,
    this.time_zone,
    this.locale,
    this.locale_options,
    this.avatar,
    this.companies,
    this.title,
    this.email_notifications,
    this.last_accessOn,
    this.last_page,
  });

  factory DataGetUser.fromJson(Map<String, dynamic> json) =>
      _$DataGetUserFromJson(json);

  Map<String, dynamic> toJson() => _$DataGetUserToJson(this);
}
