// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_employee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddUserRequestModel _$AddUserRequestModelFromJson(Map<String, dynamic> json) =>
    AddUserRequestModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      role: json['role'] as String?,
      companies: (json['companies'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AddUserRequestModelToJson(
        AddUserRequestModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'role': instance.role,
      'companies': instance.companies,
    };

EditUserRequestModel _$EditUserRequestModelFromJson(
        Map<String, dynamic> json) =>
    EditUserRequestModel(
      email: json['email'] as String?,
      status: json['status'] as String?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      role: json['role'] as String?,
      avatar: (json['avatar'] as num?)?.toInt(),
      password: json['password'] as String?,
    );

Map<String, dynamic> _$EditUserRequestModelToJson(
        EditUserRequestModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'status': instance.status,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'role': instance.role,
      'password': instance.password,
      'avatar': instance.avatar,
    };

AddUserModel _$AddUserModelFromJson(Map<String, dynamic> json) => AddUserModel(
      data: json['data'] == null
          ? null
          : DataUserResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddUserModelToJson(AddUserModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

AllUsersModel _$AllUsersModelFromJson(Map<String, dynamic> json) =>
    AllUsersModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllUsersModelToJson(AllUsersModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

DataUser _$DataUserFromJson(Map<String, dynamic> json) => DataUser(
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
      n2faSecret: json['n2faSecret'] as String?,
      passwordResetToken: json['passwordResetToken'] as String?,
      timezone: json['timezone'] as String?,
      locale: json['locale'] as String?,
      locale_options: json['locale_options'] as String?,
      avatar: json['avatar'] == null
          ? null
          : Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
      companies: json['companies'] == null
          ? null
          : Company.fromJson(json['companies'] as Map<String, dynamic>),
      title: json['title'] as String?,
      email_notifications: json['email_notifications'] as bool?,
      last_accessOn: json['last_accessOn'] as String?,
      last_page: json['last_page'] as String?,
      employee_info: (json['employee_info'] as List<dynamic>?)
          ?.map((e) => EmployeeInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataUserToJson(DataUser instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'role': instance.role,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'token': instance.token,
      'external_id': instance.external_id,
      'theme': instance.theme,
      'n2faSecret': instance.n2faSecret,
      'passwordResetToken': instance.passwordResetToken,
      'timezone': instance.timezone,
      'locale': instance.locale,
      'locale_options': instance.locale_options,
      'avatar': instance.avatar,
      'companies': instance.companies,
      'title': instance.title,
      'email_notifications': instance.email_notifications,
      'last_accessOn': instance.last_accessOn,
      'last_page': instance.last_page,
      'employee_info': instance.employee_info,
    };

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
      sort: json['sort'] as String?,
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

EmployeeInfo _$EmployeeInfoFromJson(Map<String, dynamic> json) => EmployeeInfo(
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
      sort: json['sort'] as String?,
      owner: (json['owner'] as num?)?.toInt(),
      created_on: json['created_on'] as String?,
      modified_by: (json['modified_by'] as num?)?.toInt(),
      modified_on: json['modified_on'] as String?,
      phone_1: json['phone_1'] as String?,
      phone_2: json['phone_2'] as String?,
      whatsapp: json['whatsapp'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      user: (json['user'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EmployeeInfoToJson(EmployeeInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'sort': instance.sort,
      'owner': instance.owner,
      'created_on': instance.created_on,
      'modified_by': instance.modified_by,
      'modified_on': instance.modified_on,
      'phone_1': instance.phone_1,
      'phone_2': instance.phone_2,
      'whatsapp': instance.whatsapp,
      'email': instance.email,
      'address': instance.address,
      'user': instance.user,
    };

DataUserResponse _$DataUserResponseFromJson(Map<String, dynamic> json) =>
    DataUserResponse(
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
      role: (json['role'] as num?)?.toInt(),
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      email: json['email'] as String?,
      token: json['token'] as String?,
      external_id: json['external_id'] as String?,
      theme: json['theme'] as String?,
      n2faSecret: json['n2faSecret'] as String?,
      passwordResetToken: json['passwordResetToken'] as String?,
      timezone: json['timezone'] as String?,
      locale: json['locale'] as String?,
      locale_options: json['locale_options'] as String?,
      avatar: (json['avatar'] as num?)?.toInt(),
      companies: json['companies'],
      title: json['title'] as String?,
      email_notifications: json['email_notifications'] as bool?,
      last_accessOn: json['last_accessOn'] as String?,
      last_page: json['last_page'] as String?,
    );

Map<String, dynamic> _$DataUserResponseToJson(DataUserResponse instance) =>
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
      'n2faSecret': instance.n2faSecret,
      'passwordResetToken': instance.passwordResetToken,
      'timezone': instance.timezone,
      'locale': instance.locale,
      'locale_options': instance.locale_options,
      'avatar': instance.avatar,
      'companies': instance.companies,
      'title': instance.title,
      'email_notifications': instance.email_notifications,
      'last_accessOn': instance.last_accessOn,
      'last_page': instance.last_page,
    };

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      ipWhitelist: (json['ipWhitelist'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      external_id: json['external_id'] as String?,
      module_listing: json['module_listing'] as String?,
      collection_listing: json['collection_listing'] as String?,
      enforce2fa: json['enforce2fa'] as bool?,
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'ipWhitelist': instance.ipWhitelist,
      'external_id': instance.external_id,
      'module_listing': instance.module_listing,
      'collection_listing': instance.collection_listing,
      'enforce2fa': instance.enforce2fa,
    };

Avatar _$AvatarFromJson(Map<String, dynamic> json) => Avatar(
      id: (json['id'] as num?)?.toInt(),
      storage: json['storage'] as String?,
      private_hash: json['private_hash'] as String?,
      filename_disk: json['filename_disk'] as String?,
      filename_download: json['filename_download'] as String?,
      title: json['title'] as String?,
      type: json['type'] as String?,
      uploaded_by: (json['uploaded_by'] as num?)?.toInt(),
      uploaded_on: json['uploaded_on'] as String?,
      charset: json['charset'] as String?,
      filesize: (json['filesize'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      embed: json['embed'] as String?,
      folder: json['folder'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      checksum: json['checksum'] as String?,
      metadata: json['metadata'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AvatarToJson(Avatar instance) => <String, dynamic>{
      'id': instance.id,
      'storage': instance.storage,
      'private_hash': instance.private_hash,
      'filename_disk': instance.filename_disk,
      'filename_download': instance.filename_download,
      'title': instance.title,
      'type': instance.type,
      'uploaded_by': instance.uploaded_by,
      'uploaded_on': instance.uploaded_on,
      'charset': instance.charset,
      'filesize': instance.filesize,
      'width': instance.width,
      'height': instance.height,
      'duration': instance.duration,
      'embed': instance.embed,
      'folder': instance.folder,
      'description': instance.description,
      'location': instance.location,
      'tags': instance.tags,
      'checksum': instance.checksum,
      'metadata': instance.metadata,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      full_url: json['full_url'] as String?,
      url: json['url'] as String?,
      asset_url: json['asset_url'] as String?,
      thumbnails: (json['thumbnails'] as List<dynamic>?)
          ?.map((e) => Thumbnails.fromJson(e as Map<String, dynamic>))
          .toList(),
      embed: json['embed'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'full_url': instance.full_url,
      'url': instance.url,
      'asset_url': instance.asset_url,
      'thumbnails': instance.thumbnails,
      'embed': instance.embed,
    };

Thumbnails _$ThumbnailsFromJson(Map<String, dynamic> json) => Thumbnails(
      key: json['key'] as String?,
      url: json['url'] as String?,
      relative_url: json['relative_url'] as String?,
      dimension: json['dimension'] as String?,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ThumbnailsToJson(Thumbnails instance) =>
    <String, dynamic>{
      'key': instance.key,
      'url': instance.url,
      'relative_url': instance.relative_url,
      'dimension': instance.dimension,
      'width': instance.width,
      'height': instance.height,
    };

AddEmployeeRequestModel _$AddEmployeeRequestModelFromJson(
        Map<String, dynamic> json) =>
    AddEmployeeRequestModel(
      status: json['status'] as String?,
      phone_1: json['phone_1'] as String?,
      phone_2: json['phone_2'] as String?,
      whatsapp: json['whatsapp'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      user: json['user'] as String?,
    );

Map<String, dynamic> _$AddEmployeeRequestModelToJson(
        AddEmployeeRequestModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'phone_1': instance.phone_1,
      'phone_2': instance.phone_2,
      'whatsapp': instance.whatsapp,
      'email': instance.email,
      'address': instance.address,
      'user': instance.user,
    };

AddEmployeeModel _$AddEmployeeModelFromJson(Map<String, dynamic> json) =>
    AddEmployeeModel(
      data: json['data'] == null
          ? null
          : DataEmployee.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddEmployeeModelToJson(AddEmployeeModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

DataEmployee _$DataEmployeeFromJson(Map<String, dynamic> json) => DataEmployee(
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
      sort: json['sort'] as String?,
      owner: (json['owner'] as num?)?.toInt(),
      created_on: json['created_on'] as String?,
      modified_by: (json['modified_by'] as num?)?.toInt(),
      modified_on: json['modified_on'] as String?,
      phone_1: json['phone_1'] as String?,
      phone_2: json['phone_2'] as String?,
      whatsapp: json['whatsapp'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      user: (json['user'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DataEmployeeToJson(DataEmployee instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'sort': instance.sort,
      'owner': instance.owner,
      'created_on': instance.created_on,
      'modified_by': instance.modified_by,
      'modified_on': instance.modified_on,
      'phone_1': instance.phone_1,
      'phone_2': instance.phone_2,
      'whatsapp': instance.whatsapp,
      'email': instance.email,
      'address': instance.address,
      'user': instance.user,
    };

GetEmployeeModel _$GetEmployeeModelFromJson(Map<String, dynamic> json) =>
    GetEmployeeModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataEmployee.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetEmployeeModelToJson(GetEmployeeModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

GetOneUserModel _$GetOneUserModelFromJson(Map<String, dynamic> json) =>
    GetOneUserModel(
      data: json['data'] == null
          ? null
          : DataGetUser.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetOneUserModelToJson(GetOneUserModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

DataGetUser _$DataGetUserFromJson(Map<String, dynamic> json) => DataGetUser(
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
      password_resetToken: json['password_resetToken'] as String?,
      time_zone: json['time_zone'] as String?,
      locale: json['locale'] as String?,
      locale_options: json['locale_options'] as String?,
      avatar: json['avatar'] == null
          ? null
          : Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
      companies: json['companies'] as String?,
      title: json['title'] as String?,
      email_notifications: json['email_notifications'] as bool?,
      last_accessOn: json['last_accessOn'] as String?,
      last_page: json['last_page'] as String?,
    );

Map<String, dynamic> _$DataGetUserToJson(DataGetUser instance) =>
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
      'password_resetToken': instance.password_resetToken,
      'time_zone': instance.time_zone,
      'locale': instance.locale,
      'locale_options': instance.locale_options,
      'avatar': instance.avatar,
      'companies': instance.companies,
      'title': instance.title,
      'email_notifications': instance.email_notifications,
      'last_accessOn': instance.last_accessOn,
      'last_page': instance.last_page,
    };
