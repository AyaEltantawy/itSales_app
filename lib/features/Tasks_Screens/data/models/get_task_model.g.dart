// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserTaskModel _$GetUserTaskModelFromJson(Map<String, dynamic> json) =>
    GetUserTaskModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataUserTask.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetUserTaskModelToJson(GetUserTaskModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

DataUserTask _$DataUserTaskFromJson(Map<String, dynamic> json) => DataUserTask(
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
      sort: json['sort'] as String?,
      owner: json['owner'] == null
          ? null
          : Owner.fromJson(json['owner'] as Map<String, dynamic>),
      created_on: json['created_on'] as String?,
      modified_by: json['modified_by'] == null
          ? null
          : Owner.fromJson(json['modified_by'] as Map<String, dynamic>),
      modified_on: json['modified_on'] as String?,
      assigned_to: json['assigned_to'] == null
          ? null
          : AssignedTo.fromJson(json['assigned_to'] as Map<String, dynamic>),
      due_date: json['due_date'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      client_name: json['client_name'] as String?,
      client_phone: json['client_phone'] as String?,
      notes: json['notes'] as String?,
      task_status: json['task_status'] as String?,
      priority: json['priority'] as String?,
      start_date: json['start_date'] as String?,
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      complete_date: json['complete_date'] as String?,
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => FilesResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      cancelled_date: json['cancelled_date'] as String?,
    );

Map<String, dynamic> _$DataUserTaskToJson(DataUserTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'sort': instance.sort,
      'owner': instance.owner,
      'created_on': instance.created_on,
      'modified_by': instance.modified_by,
      'modified_on': instance.modified_on,
      'assigned_to': instance.assigned_to,
      'due_date': instance.due_date,
      'title': instance.title,
      'description': instance.description,
      'client_name': instance.client_name,
      'client_phone': instance.client_phone,
      'notes': instance.notes,
      'task_status': instance.task_status,
      'priority': instance.priority,
      'start_date': instance.start_date,
      'location': instance.location,
      'complete_date': instance.complete_date,
      'cancelled_date': instance.cancelled_date,
      'files': instance.files,
    };

AddTaskRequestModel _$AddTaskRequestModelFromJson(Map<String, dynamic> json) =>
    AddTaskRequestModel(
      status: json['status'] as String?,
      due_date: json['due_date'] as String?,
      title: json['title'] as String?,
      client_name: json['client_name'] as String?,
      client_phone: json['client_phone'] as String?,
      task_status: json['task_status'] as String?,
      priority: json['priority'] as String?,
      start_date: json['start_date'] as String?,
      complete_date: json['complete_date'] as String?,
      cancelled_date: json['cancelled_date'] as String?,
      description: json['description'] as String?,
      notes: json['notes'] as String?,
      assigned_to: json['assigned_to'] as String?,
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => Files.fromJson(e as Map<String, dynamic>))
          .toList(),
      location: (json['location'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AddTaskRequestModelToJson(
        AddTaskRequestModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'due_date': instance.due_date,
      'title': instance.title,
      'client_name': instance.client_name,
      'client_phone': instance.client_phone,
      'task_status': instance.task_status,
      'priority': instance.priority,
      'start_date': instance.start_date,
      'complete_date': instance.complete_date,
      'cancelled_date': instance.cancelled_date,
      'description': instance.description,
      'notes': instance.notes,
      'assigned_to': instance.assigned_to,
      'files': instance.files,
      'location': instance.location,
    };

Files _$FilesFromJson(Map<String, dynamic> json) => Files(
      directus_files_id: json['directus_files_id'] == null
          ? null
          : DirectusFilesIdRequest.fromJson(
              json['directus_files_id'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FilesToJson(Files instance) => <String, dynamic>{
      'directus_files_id': instance.directus_files_id,
    };

FilesResponseModel _$FilesResponseModelFromJson(Map<String, dynamic> json) =>
    FilesResponseModel(
      id: (json['id'] as num?)?.toInt(),
      directus_files_id: json['directus_files_id'] == null
          ? null
          : DirectusFilesId.fromJson(
              json['directus_files_id'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FilesResponseModelToJson(FilesResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'directus_files_id': instance.directus_files_id,
    };

DirectusFilesId _$DirectusFilesIdFromJson(Map<String, dynamic> json) =>
    DirectusFilesId(
      id: (json['id'] as num?)?.toInt(),
      storage: json['storage'] as String?,
      privateHash: json['privateHash'] as String?,
      filenameDisk: json['filenameDisk'] as String?,
      filenameDownload: json['filenameDownload'] as String?,
      title: json['title'] as String?,
      type: json['type'] as String?,
      uploadedBy: (json['uploadedBy'] as num?)?.toInt(),
      uploaded_on: json['uploaded_on'] as String?,
      charset: json['charset'] as String?,
      filesize: (json['filesize'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      description: json['description'] as String?,
      location: json['location'] as String?,
      checksum: json['checksum'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DirectusFilesIdToJson(DirectusFilesId instance) =>
    <String, dynamic>{
      'id': instance.id,
      'storage': instance.storage,
      'privateHash': instance.privateHash,
      'filenameDisk': instance.filenameDisk,
      'filenameDownload': instance.filenameDownload,
      'title': instance.title,
      'type': instance.type,
      'uploadedBy': instance.uploadedBy,
      'uploaded_on': instance.uploaded_on,
      'charset': instance.charset,
      'filesize': instance.filesize,
      'width': instance.width,
      'height': instance.height,
      'duration': instance.duration,
      'description': instance.description,
      'location': instance.location,
      'checksum': instance.checksum,
      'data': instance.data,
    };

DirectusFilesIdRequest _$DirectusFilesIdRequestFromJson(
        Map<String, dynamic> json) =>
    DirectusFilesIdRequest(
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DirectusFilesIdRequestToJson(
        DirectusFilesIdRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

AddTaskModel _$AddTaskModelFromJson(Map<String, dynamic> json) => AddTaskModel(
      data: json['data'] == null
          ? null
          : DataUserTask.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddTaskModelToJson(AddTaskModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

AllTasksModel _$AllTasksModelFromJson(Map<String, dynamic> json) =>
    AllTasksModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataAllTasks.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllTasksModelToJson(AllTasksModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

DataAllTasks _$DataAllTasksFromJson(Map<String, dynamic> json) => DataAllTasks(
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
      sort: json['sort'],
      owner: json['owner'] == null
          ? null
          : Owner.fromJson(json['owner'] as Map<String, dynamic>),
      created_on: json['created_on'] as String?,
      modified_by: json['modified_by'] == null
          ? null
          : Owner.fromJson(json['modified_by'] as Map<String, dynamic>),
      modified_on: json['modified_on'] as String?,
      assigned_to: json['assigned_to'] == null
          ? null
          : AssignedTo.fromJson(json['assigned_to'] as Map<String, dynamic>),
      due_date: json['due_date'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      client_name: json['client_name'] as String?,
      client_phone: json['client_phone'] as String?,
      notes: json['notes'] as String?,
      task_status: json['task_status'] as String?,
      priority: json['priority'] as String?,
      start_date: json['start_date'] as String?,
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      complete_date: json['complete_date'] as String?,
      cancelled_date: json['cancelled_date'] as String?,
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => FilesResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataAllTasksToJson(DataAllTasks instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'sort': instance.sort,
      'owner': instance.owner,
      'created_on': instance.created_on,
      'modified_by': instance.modified_by,
      'modified_on': instance.modified_on,
      'assigned_to': instance.assigned_to,
      'due_date': instance.due_date,
      'title': instance.title,
      'description': instance.description,
      'client_name': instance.client_name,
      'client_phone': instance.client_phone,
      'notes': instance.notes,
      'task_status': instance.task_status,
      'priority': instance.priority,
      'start_date': instance.start_date,
      'location': instance.location,
      'complete_date': instance.complete_date,
      'cancelled_date': instance.cancelled_date,
      'files': instance.files,
    };

Owner _$OwnerFromJson(Map<String, dynamic> json) => Owner(
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
      timezone: json['timezone'] as String?,
      locale: json['locale'] as String?,
      locale_options: json['locale_options'] as String?,
      avatar: json['avatar'] == null
          ? null
          : Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
      company: json['company'] as String?,
      title: json['title'] as String?,
      email_notifications: json['email_notifications'] as bool?,
      last_access_on: json['last_access_on'] as String?,
      last_page: json['last_page'] as String?,
    );

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
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
      'timezone': instance.timezone,
      'locale': instance.locale,
      'locale_options': instance.locale_options,
      'avatar': instance.avatar,
      'company': instance.company,
      'title': instance.title,
      'email_notifications': instance.email_notifications,
      'last_access_on': instance.last_access_on,
      'last_page': instance.last_page,
    };

OwnerLocation _$OwnerLocationFromJson(Map<String, dynamic> json) =>
    OwnerLocation(
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
      role: (json['role'] as num?)?.toInt(),
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      email: json['email'] as String?,
      token: json['token'] as String?,
      external_id: json['external_id'] as String?,
      theme: json['theme'] as String?,
      n2fa_secret: json['n2fa_secret'] as String?,
      password_resetToken: json['password_resetToken'] as String?,
      timezone: json['timezone'] as String?,
      locale: json['locale'] as String?,
      locale_options: json['locale_options'] as String?,
      avatar: (json['avatar'] as num?)?.toInt(),
      company: json['company'] as String?,
      title: json['title'] as String?,
      email_notifications: json['email_notifications'] as bool?,
      last_access_on: json['last_access_on'] as String?,
      last_page: json['last_page'] as String?,
    );

Map<String, dynamic> _$OwnerLocationToJson(OwnerLocation instance) =>
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
      'timezone': instance.timezone,
      'locale': instance.locale,
      'locale_options': instance.locale_options,
      'avatar': instance.avatar,
      'company': instance.company,
      'title': instance.title,
      'email_notifications': instance.email_notifications,
      'last_access_on': instance.last_access_on,
      'last_page': instance.last_page,
    };

AssignedTo _$AssignedToFromJson(Map<String, dynamic> json) => AssignedTo(
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
      timezone: json['timezone'] as String?,
      locale: json['locale'] as String?,
      locale_options: json['locale_options'] as String?,
      avatar: json['avatar'] == null
          ? null
          : Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
      company: json['company'] as String?,
      title: json['title'] as String?,
      email_notifications: json['email_notifications'] as bool?,
      last_access_on: json['last_access_on'] as String?,
      last_page: json['last_page'] as String?,
    );

Map<String, dynamic> _$AssignedToToJson(AssignedTo instance) =>
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
      'timezone': instance.timezone,
      'locale': instance.locale,
      'locale_options': instance.locale_options,
      'avatar': instance.avatar,
      'company': instance.company,
      'title': instance.title,
      'email_notifications': instance.email_notifications,
      'last_access_on': instance.last_access_on,
      'last_page': instance.last_page,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
      sort: json['sort'] as String?,
      owner: json['owner'] == null
          ? null
          : OwnerLocation.fromJson(json['owner'] as Map<String, dynamic>),
      created_on: json['created_on'] as String?,
      modified_by: json['modified_by'] == null
          ? null
          : OwnerLocation.fromJson(json['modified_by'] as Map<String, dynamic>),
      modified_on: json['modified_on'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      address: json['address'] as String?,
      map_url: json['map_url'] as String?,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'sort': instance.sort,
      'owner': instance.owner,
      'created_on': instance.created_on,
      'modified_by': instance.modified_by,
      'modified_on': instance.modified_on,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'map_url': instance.map_url,
    };
