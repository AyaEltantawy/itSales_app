class UserModel {
  Data? data;
  bool? public;

  UserModel({this.data, this.public});

  UserModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    public = json['public'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['public'] = this.public;
    return data;
  }
}

class Data {
  String? token;
  User? user;

  Data({this.token, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? status;
  String? role;
  String? firstName;
  String? lastName;
  String? email;
  String? timezone;
  String? locale;
  Null? localeOptions;
  String? avatar;
  Null? company;
  Null? title;
  Null? externalId;
  String? theme;
  Null? n2faSecret;
  String? passwordResetToken;
  String? companies;

  User(
      {this.id,
        this.status,
        this.role,
        this.firstName,
        this.lastName,
        this.email,
        this.timezone,
        this.locale,
        this.localeOptions,
        this.avatar,
        this.company,
        this.title,
        this.externalId,
        this.theme,
        this.n2faSecret,
        this.passwordResetToken,
        this.companies});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    role = json['role'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    timezone = json['timezone'];
    locale = json['locale'];
    localeOptions = json['locale_options'];
    avatar = json['avatar'];
    company = json['company'];
    title = json['title'];
    externalId = json['external_id'];
    theme = json['theme'];
    n2faSecret = json['2fa_secret'];
    passwordResetToken = json['password_reset_token'];
    companies = json['companies'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['role'] = this.role;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['timezone'] = this.timezone;
    data['locale'] = this.locale;
    data['locale_options'] = this.localeOptions;
    data['avatar'] = this.avatar;
    data['company'] = this.company;
    data['title'] = this.title;
    data['external_id'] = this.externalId;
    data['theme'] = this.theme;
    data['2fa_secret'] = this.n2faSecret;
    data['password_reset_token'] = this.passwordResetToken;
    data['companies'] = this.companies;
    return data;
  }
}
