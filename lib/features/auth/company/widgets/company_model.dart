import 'package:itsale/features/HomeEmployee/models/get_company_model.dart';

class CompanyModel {
  Data? data;

  CompanyModel({this.data});

  CompanyModel.fromJson(dynamic json) {
    if (json['data'] is Map<String, dynamic>) {
      data = Data.fromJson(json['data']);
    } else {
      // Handle unexpected data (e.g. if it's just an int like 4)
      data = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? status;
  dynamic sort;
  Owner? owner;
  String? createdOn;
  Owner? modifiedBy;
  String? modifiedOn;
  String? name;
  dynamic logo;
  String? email;
  String? whatsapp;
  String? website;
  List<Employee>? employee;
  List<Users>? users;

  Data({
    this.id,
    this.status,
    this.sort,
    this.owner,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn,
    this.name,
    this.logo,
    this.email,
    this.whatsapp,
    this.website,
    this.employee,
    this.users,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    sort = json['sort'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    createdOn = json['created_on'];
    modifiedBy = json['modified_by'] != null ? Owner.fromJson(json['modified_by']) : null;
    modifiedOn = json['modified_on'];
    name = json['name'];
    logo = json['logo'];
    email = json['email'];
    whatsapp = json['whatsapp'];
    website = json['website'];
    if (json['employee'] != null) {
      employee = (json['employee'] as List)
          .map((e) => Employee.fromJson(e))
          .toList();
    }
    if (json['users'] != null) {
      users = (json['users'] as List)
          .map((e) => Users.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['status'] = status;
    data['sort'] = sort;
    if (owner != null) data['owner'] = owner!.toJson();
    data['created_on'] = createdOn;
    if (modifiedBy != null) data['modified_by'] = modifiedBy!.toJson();
    data['modified_on'] = modifiedOn;
    data['name'] = name;
    data['logo'] = logo;
    data['email'] = email;
    data['whatsapp'] = whatsapp;
    data['website'] = website;
    if (employee != null) {
      data['employee'] = employee!.map((e) => e.toJson()).toList();
    }
    if (users != null) {
      data['users'] = users!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Owner {
  int? id;
  String? status;
  int? role;
  String? firstName;
  String? lastName;
  String? email;
  dynamic token;
  String? externalId;
  String? theme;
  dynamic n2faSecret;
  dynamic passwordResetToken;
  int? companies;
  String? timezone;
  dynamic locale;
  dynamic localeOptions;
  dynamic avatar;
  dynamic company;
  dynamic title;
  bool? emailNotifications;
  dynamic lastAccessOn;
  dynamic lastPage;

  Owner({
    this.id,
    this.status,
    this.role,
    this.firstName,
    this.lastName,
    this.email,
    this.token,
    this.externalId,
    this.theme,
    this.n2faSecret,
    this.passwordResetToken,
    this.companies,
    this.timezone,
    this.locale,
    this.localeOptions,
    this.avatar,
    this.company,
    this.title,
    this.emailNotifications,
    this.lastAccessOn,
    this.lastPage,
  });

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    role = json['role'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    token = json['token'];
    externalId = json['external_id'];
    theme = json['theme'];
    n2faSecret = json['2fa_secret'];
    passwordResetToken = json['password_reset_token'];
    companies = json['companies'];
    timezone = json['timezone'];
    locale = json['locale'];
    localeOptions = json['locale_options'];
    avatar = json['avatar'];
    company = json['company'];
    title = json['title'];
    emailNotifications = json['email_notifications'];
    lastAccessOn = json['last_access_on'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['status'] = status;
    data['role'] = role;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['token'] = token;
    data['external_id'] = externalId;
    data['theme'] = theme;
    data['2fa_secret'] = n2faSecret;
    data['password_reset_token'] = passwordResetToken;
    data['companies'] = companies;
    data['timezone'] = timezone;
    data['locale'] = locale;
    data['locale_options'] = localeOptions;
    data['avatar'] = avatar;
    data['company'] = company;
    data['title'] = title;
    data['email_notifications'] = emailNotifications;
    data['last_access_on'] = lastAccessOn;
    data['last_page'] = lastPage;
    return data;
  }
}

// Dummy placeholder classes for Employee and Users
// Replace with actual implementations
class Employee {
  Employee.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson() => {};
}

class Users {
  Users.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson() => {};
}
