class GetCompanyModel {
  List<Data>? data;

  GetCompanyModel({this.data});

  GetCompanyModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? status;
  Null? sort;
  UploadedBy? owner;
  String? createdOn;
  UploadedBy? modifiedBy;
  String? modifiedOn;
  String? name;
  Logo? logo;
  String? email;
  String? whatsapp;
  String? website;
  List<Employee>? employee;
  List<Users>? users;

  Data(
      {this.id,
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
        this.users});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    sort = json['sort'];
    owner =
    json['owner'] != null ? new UploadedBy.fromJson(json['owner']) : null;
    createdOn = json['created_on'];
    modifiedBy = json['modified_by'] != null
        ? new UploadedBy.fromJson(json['modified_by'])
        : null;
    modifiedOn = json['modified_on'];
    name = json['name'];
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    email = json['email'];
    whatsapp = json['whatsapp'];
    website = json['website'];
    if (json['employee'] != null) {
      employee = <Employee>[];
      json['employee'].forEach((v) {
        employee!.add(new Employee.fromJson(v));
      });
    }
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['sort'] = this.sort;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    data['created_on'] = this.createdOn;
    if (this.modifiedBy != null) {
      data['modified_by'] = this.modifiedBy!.toJson();
    }
    data['modified_on'] = this.modifiedOn;
    data['name'] = this.name;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    data['email'] = this.email;
    data['whatsapp'] = this.whatsapp;
    data['website'] = this.website;
    if (this.employee != null) {
      data['employee'] = this.employee!.map((v) => v.toJson()).toList();
    }
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Owner {
  int? id;
  String? status;
  Role? role;
  String? firstName;
  String? lastName;
  String? email;
  String? token;

  String? theme;

  String? passwordResetToken;
  Companies? companies;
  String? timezone;
  String? locale;

  Avatar? avatar;
  String? company;
  String? title;
  bool? emailNotifications;
  String? lastAccessOn;
  String? lastPage;
  List<EmployeeInfo>? employeeInfo;

  Owner(
      {this.id,
        this.status,
        this.role,
        this.firstName,
        this.lastName,
        this.email,
        this.token,

        this.theme,

        this.passwordResetToken,
        this.companies,
        this.timezone,
        this.locale,

        this.avatar,
        this.company,
        this.title,
        this.emailNotifications,
        this.lastAccessOn,
        this.lastPage,
        this.employeeInfo});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    token = json['token'];

    theme = json['theme'];

    passwordResetToken = json['password_reset_token'];
    companies = json['companies'] != null
        ? new Companies.fromJson(json['companies'])
        : null;
    timezone = json['timezone'];
    locale = json['locale'];

    avatar =
    json['avatar'] != null ? new Avatar.fromJson(json['avatar']) : null;
    company = json['company'];
    title = json['title'];
    emailNotifications = json['email_notifications'];
    lastAccessOn = json['last_access_on'];
    lastPage = json['last_page'];
    if (json['employee_info'] != null) {
      employeeInfo = <EmployeeInfo>[];
      json['employee_info'].forEach((v) {
        employeeInfo!.add(new EmployeeInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['token'] = this.token;

    data['theme'] = this.theme;

    data['password_reset_token'] = this.passwordResetToken;
    if (this.companies != null) {
      data['companies'] = this.companies!.toJson();
    }
    data['timezone'] = this.timezone;
    data['locale'] = this.locale;
    if (this.avatar != null) {
      data['avatar'] = this.avatar!.toJson();
    }
    data['company'] = this.company;
    data['title'] = this.title;
    data['email_notifications'] = this.emailNotifications;
    data['last_access_on'] = this.lastAccessOn;
    data['last_page'] = this.lastPage;
    if (this.employeeInfo != null) {
      data['employee_info'] =
          this.employeeInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Role {
  int? id;
  String? name;
  String? description;
  List<Null>? ipWhitelist;
  Null? externalId;
  Null? moduleListing;
  Null? collectionListing;
  bool? enforce2fa;

  Role(
      {this.id,
        this.name,
        this.description,
        this.ipWhitelist,
        this.externalId,
        this.moduleListing,
        this.collectionListing,
        this.enforce2fa});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    if (json['ip_whitelist'] != null) {
      ipWhitelist = <Null>[];
      json['ip_whitelist'].forEach((v) {
      });
    }
    externalId = json['external_id'];
    moduleListing = json['module_listing'];
    collectionListing = json['collection_listing'];
    enforce2fa = json['enforce_2fa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.ipWhitelist != null) {

    }
    data['external_id'] = this.externalId;
    data['module_listing'] = this.moduleListing;
    data['collection_listing'] = this.collectionListing;
    data['enforce_2fa'] = this.enforce2fa;
    return data;
  }
}

class Companies {
  int? id;
  String? status;
  Null? sort;
  int? owner;
  String? createdOn;
  int? modifiedBy;
  String? modifiedOn;
  String? name;
  int? logo;
  String? email;
  String? whatsapp;
  String? website;

  Companies(
      {this.id,
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
        this.website});

  Companies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    sort = json['sort'];
    owner = json['owner'];
    createdOn = json['created_on'];
    modifiedBy = json['modified_by'];
    modifiedOn = json['modified_on'];
    name = json['name'];
    logo = json['logo'];
    email = json['email'];
    whatsapp = json['whatsapp'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['sort'] = this.sort;
    data['owner'] = this.owner;
    data['created_on'] = this.createdOn;
    data['modified_by'] = this.modifiedBy;
    data['modified_on'] = this.modifiedOn;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['email'] = this.email;
    data['whatsapp'] = this.whatsapp;
    data['website'] = this.website;
    return data;
  }
}

class Avatar {
  int? id;
  String? storage;
  String? privateHash;
  String? filenameDisk;
  String? filenameDownload;
  String? title;
  String? type;
  int? uploadedBy;
  String? uploadedOn;
  String? charset;
  int? filesize;
  int? width;
  int? height;
  int? duration;
  Null? embed;
  Null? folder;
  String? description;
  String? location;
  List<Null>? tags;
  String? checksum;
  Null? metadata;
  Data? data;

  Avatar(
      {this.id,
        this.storage,
        this.privateHash,
        this.filenameDisk,
        this.filenameDownload,
        this.title,
        this.type,
        this.uploadedBy,
        this.uploadedOn,
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
        this.data});

  Avatar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storage = json['storage'];
    privateHash = json['private_hash'];
    filenameDisk = json['filename_disk'];
    filenameDownload = json['filename_download'];
    title = json['title'];
    type = json['type'];
    uploadedBy = json['uploaded_by'];
    uploadedOn = json['uploaded_on'];
    charset = json['charset'];
    filesize = json['filesize'];
    width = json['width'];
    height = json['height'];
    duration = json['duration'];
    embed = json['embed'];
    folder = json['folder'];
    description = json['description'];
    location = json['location'];
    if (json['tags'] != null) {
      tags = <Null>[];
      json['tags'].forEach((v) {

      });
    }
    checksum = json['checksum'];
    metadata = json['metadata'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['storage'] = this.storage;
    data['private_hash'] = this.privateHash;
    data['filename_disk'] = this.filenameDisk;
    data['filename_download'] = this.filenameDownload;
    data['title'] = this.title;
    data['type'] = this.type;
    data['uploaded_by'] = this.uploadedBy;
    data['uploaded_on'] = this.uploadedOn;
    data['charset'] = this.charset;
    data['filesize'] = this.filesize;
    data['width'] = this.width;
    data['height'] = this.height;
    data['duration'] = this.duration;
    data['embed'] = this.embed;
    data['folder'] = this.folder;
    data['description'] = this.description;
    data['location'] = this.location;
    if (this.tags != null) {

    }
    data['checksum'] = this.checksum;
    data['metadata'] = this.metadata;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}



class Thumbnails {
  String? key;
  String? url;
  String? relativeUrl;
  String? dimension;
  int? width;
  int? height;

  Thumbnails(
      {this.key,
        this.url,
        this.relativeUrl,
        this.dimension,
        this.width,
        this.height});

  Thumbnails.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    url = json['url'];
    relativeUrl = json['relative_url'];
    dimension = json['dimension'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['url'] = this.url;
    data['relative_url'] = this.relativeUrl;
    data['dimension'] = this.dimension;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class EmployeeInfo {
  int? id;
  String? status;
  Null? sort;
  int? owner;
  String? createdOn;
  int? modifiedBy;
  String? modifiedOn;
  String? phone1;
  String? phone2;
  String? whatsapp;
  String? email;
  String? address;
  int? user;
  int? company;

  EmployeeInfo(
      {this.id,
        this.status,
        this.sort,
        this.owner,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
        this.phone1,
        this.phone2,
        this.whatsapp,
        this.email,
        this.address,
        this.user,
        this.company});

  EmployeeInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    sort = json['sort'];
    owner = json['owner'];
    createdOn = json['created_on'];
    modifiedBy = json['modified_by'];
    modifiedOn = json['modified_on'];
    phone1 = json['phone_1'];
    phone2 = json['phone_2'];
    whatsapp = json['whatsapp'];
    email = json['email'];
    address = json['address'];
    user = json['user'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['sort'] = this.sort;
    data['owner'] = this.owner;
    data['created_on'] = this.createdOn;
    data['modified_by'] = this.modifiedBy;
    data['modified_on'] = this.modifiedOn;
    data['phone_1'] = this.phone1;
    data['phone_2'] = this.phone2;
    data['whatsapp'] = this.whatsapp;
    data['email'] = this.email;
    data['address'] = this.address;
    data['user'] = this.user;
    data['company'] = this.company;
    return data;
  }
}

class Logo {
  int? id;
  String? storage;
  String? privateHash;
  String? filenameDisk;
  String? filenameDownload;
  String? title;
  String? type;
  UploadedBy? uploadedBy;
  String? uploadedOn;
  String? charset;
  int? filesize;
  int? width;
  int? height;
  int? duration;
  Null? embed;
  Null? folder;
  String? description;
  String? location;
  List<Null>? tags;
  String? checksum;
  Null? metadata;
  Data? data;

  Logo(
      {this.id,
        this.storage,
        this.privateHash,
        this.filenameDisk,
        this.filenameDownload,
        this.title,
        this.type,
        this.uploadedBy,
        this.uploadedOn,
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
        this.data});

  Logo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storage = json['storage'];
    privateHash = json['private_hash'];
    filenameDisk = json['filename_disk'];
    filenameDownload = json['filename_download'];
    title = json['title'];
    type = json['type'];
    uploadedBy = json['uploaded_by'] != null
        ? new UploadedBy.fromJson(json['uploaded_by'])
        : null;
    uploadedOn = json['uploaded_on'];
    charset = json['charset'];
    filesize = json['filesize'];
    width = json['width'];
    height = json['height'];
    duration = json['duration'];
    embed = json['embed'];
    folder = json['folder'];
    description = json['description'];
    location = json['location'];
    if (json['tags'] != null) {
      tags = <Null>[];
      json['tags'].forEach((v) {

      });
    }
    checksum = json['checksum'];
    metadata = json['metadata'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['storage'] = this.storage;
    data['private_hash'] = this.privateHash;
    data['filename_disk'] = this.filenameDisk;
    data['filename_download'] = this.filenameDownload;
    data['title'] = this.title;
    data['type'] = this.type;
    if (this.uploadedBy != null) {
      data['uploaded_by'] = this.uploadedBy!.toJson();
    }
    data['uploaded_on'] = this.uploadedOn;
    data['charset'] = this.charset;
    data['filesize'] = this.filesize;
    data['width'] = this.width;
    data['height'] = this.height;
    data['duration'] = this.duration;
    data['embed'] = this.embed;
    data['folder'] = this.folder;
    data['description'] = this.description;
    data['location'] = this.location;
    if (this.tags != null) {

    }
    data['checksum'] = this.checksum;
    data['metadata'] = this.metadata;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UploadedBy {
  int? id;
  String? status;
  int? role;
  String? firstName;
  String? lastName;
  String? email;
  String? token;
  Null? externalId;
  String? theme;
  Null? n2faSecret;
  String? passwordResetToken;
  int? companies;
  String? timezone;
  String? locale;
  Null? localeOptions;
  int? avatar;
  Null? company;
  Null? title;
  bool? emailNotifications;
  String? lastAccessOn;
  String? lastPage;

  UploadedBy(
      {this.id,
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
        this.lastPage});

  UploadedBy.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['role'] = this.role;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['token'] = this.token;
    data['external_id'] = this.externalId;
    data['theme'] = this.theme;
    data['2fa_secret'] = this.n2faSecret;
    data['password_reset_token'] = this.passwordResetToken;
    data['companies'] = this.companies;
    data['timezone'] = this.timezone;
    data['locale'] = this.locale;
    data['locale_options'] = this.localeOptions;
    data['avatar'] = this.avatar;
    data['company'] = this.company;
    data['title'] = this.title;
    data['email_notifications'] = this.emailNotifications;
    data['last_access_on'] = this.lastAccessOn;
    data['last_page'] = this.lastPage;
    return data;
  }
}

class Employee {
  int? id;
  String? status;
  Null? sort;
  UploadedBy? owner;
  String? createdOn;
  UploadedBy? modifiedBy;
  String? modifiedOn;
  String? phone1;
  String? phone2;
  String? whatsapp;
  String? email;
  String? address;
  UploadedBy? user;
  Companies? company;

  Employee(
      {this.id,
        this.status,
        this.sort,
        this.owner,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
        this.phone1,
        this.phone2,
        this.whatsapp,
        this.email,
        this.address,
        this.user,
        this.company});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    sort = json['sort'];
    owner =
    json['owner'] != null ? new UploadedBy.fromJson(json['owner']) : null;
    createdOn = json['created_on'];
    modifiedBy = json['modified_by'] != null
        ? new UploadedBy.fromJson(json['modified_by'])
        : null;
    modifiedOn = json['modified_on'];
    phone1 = json['phone_1'];
    phone2 = json['phone_2'];
    whatsapp = json['whatsapp'];
    email = json['email'];
    address = json['address'];
    user = json['user'] != null ? new UploadedBy.fromJson(json['user']) : null;
    company = json['company'] != null
        ? new Companies.fromJson(json['company'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['sort'] = this.sort;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    data['created_on'] = this.createdOn;
    if (this.modifiedBy != null) {
      data['modified_by'] = this.modifiedBy!.toJson();
    }
    data['modified_on'] = this.modifiedOn;
    data['phone_1'] = this.phone1;
    data['phone_2'] = this.phone2;
    data['whatsapp'] = this.whatsapp;
    data['email'] = this.email;
    data['address'] = this.address;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}

class Users {
  int? id;
  String? status;
  Role? role;
  String? firstName;
  String? lastName;
  String? email;
  String? token;
  String? externalId;
  String? theme;
  Null? n2faSecret;
  String? passwordResetToken;
  Companies? companies;
  String? timezone;
  String? locale;
  Null? localeOptions;
  Avatar? avatar;
  Null? company;
  Null? title;
  bool? emailNotifications;
  String? lastAccessOn;
  String? lastPage;
  List<EmployeeInfo>? employeeInfo;

  Users(
      {this.id,
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
        this.employeeInfo});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    token = json['token'];
    externalId = json['external_id'];
    theme = json['theme'];
    n2faSecret = json['2fa_secret'];
    passwordResetToken = json['password_reset_token'];
    companies = json['companies'] != null
        ? new Companies.fromJson(json['companies'])
        : null;
    timezone = json['timezone'];
    locale = json['locale'];
    localeOptions = json['locale_options'];
    avatar =
    json['avatar'] != null ? new Avatar.fromJson(json['avatar']) : null;
    company = json['company'];
    title = json['title'];
    emailNotifications = json['email_notifications'];
    lastAccessOn = json['last_access_on'];
    lastPage = json['last_page'];
    if (json['employee_info'] != null) {
      employeeInfo = <EmployeeInfo>[];
      json['employee_info'].forEach((v) {
        employeeInfo!.add(new EmployeeInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['token'] = this.token;
    data['external_id'] = this.externalId;
    data['theme'] = this.theme;
    data['2fa_secret'] = this.n2faSecret;
    data['password_reset_token'] = this.passwordResetToken;
    if (this.companies != null) {
      data['companies'] = this.companies!.toJson();
    }
    data['timezone'] = this.timezone;
    data['locale'] = this.locale;
    data['locale_options'] = this.localeOptions;
    if (this.avatar != null) {
      data['avatar'] = this.avatar!.toJson();
    }
    data['company'] = this.company;
    data['title'] = this.title;
    data['email_notifications'] = this.emailNotifications;
    data['last_access_on'] = this.lastAccessOn;
    data['last_page'] = this.lastPage;
    if (this.employeeInfo != null) {
      data['employee_info'] =
          this.employeeInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


