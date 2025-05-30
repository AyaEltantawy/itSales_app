import 'package:json_annotation/json_annotation.dart';

import '../../../addEmployee/data/models/add_employee_model.dart';

part 'get_task_model.g.dart';

@JsonSerializable()
class GetUserTaskModel {
  List<DataUserTask>? data;

  GetUserTaskModel({this.data});

  factory GetUserTaskModel.fromJson(Map<String, dynamic> json) =>
      _$GetUserTaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserTaskModelToJson(this);
}

@JsonSerializable()
class DataUserTask {
  int? id;
  String? status;
  String? sort;
  dynamic? owner;
  String? created_on;
  dynamic? modified_by;
  String? modified_on;
  dynamic? assigned_to;
  String? due_date;
  String? title;
  String? description;
  String? client_name;
  String? client_phone;
  String? notes;
  String? task_status;
  String? priority;
  String? start_date;
  Location? location;
  String? complete_date;
  String? cancelled_date;
  List<dynamic>? files;

  DataUserTask({
    this.id,
    this.status,
    this.sort,
    this.owner,
    this.created_on,
    this.modified_by,
    this.modified_on,
    this.assigned_to,
    this.due_date,
    this.title,
    this.description,
    this.client_name,
    this.client_phone,
    this.notes,
    this.task_status,
    this.priority,
    this.start_date,
    this.location,
    this.complete_date,
    this.cancelled_date,
    this.files,
  });

  factory DataUserTask.fromJson(Map<String, dynamic> json) =>
      _$DataUserTaskFromJson(json);

  Map<String, dynamic> toJson() => _$DataUserTaskToJson(this);
}

@JsonSerializable()
class AddTaskRequestModel {
  String? status;
  String? due_date;
  String? title;
  String? client_name;
  String? client_phone;
  String? task_status;
  String? priority;
  String? start_date;
  String? complete_date;
  String? cancelled_date;
  String? description;
  String? notes;
  int? assigned_to;
  dynamic? files;
  dynamic? location;
  int? company;

  AddTaskRequestModel(
      {this.status,
      this.due_date,
      this.title,
      this.client_name,
      this.client_phone,
      this.task_status,
      this.priority,
      this.start_date,
      this.complete_date,
      this.cancelled_date,
      this.description,
      this.notes,
      this.assigned_to,
      this.files,
      this.location,
      this.company});

  factory AddTaskRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AddTaskRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddTaskRequestModelToJson(this);
}

@JsonSerializable()
class Files {
  DirectusFilesIdRequest? directus_files_id;

  Files({this.directus_files_id});

  factory Files.fromJson(Map<String, dynamic> json) => _$FilesFromJson(json);

  Map<String, dynamic> toJson() => _$FilesToJson(this);
}

@JsonSerializable()
class FilesResponseModel {
  int? id;
  DirectusFilesId? directus_files_id;

  FilesResponseModel({this.id, this.directus_files_id});

  factory FilesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FilesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilesResponseModelToJson(this);
}

@JsonSerializable()
class DirectusFilesId {
  int? id;
  String? storage;
  String? privateHash;
  String? filenameDisk;
  String? filenameDownload;
  String? title;
  String? type;
  int? uploadedBy;
  String? uploaded_on;
  String? charset;
  int? filesize;
  int? width;
  int? height;
  int? duration;

  String? description;
  String? location;

  String? checksum;

  Data? data;

  DirectusFilesId(
      {this.id,
      this.storage,
      this.privateHash,
      this.filenameDisk,
      this.filenameDownload,
      this.title,
      this.type,
      this.uploadedBy,
      this.uploaded_on,
      this.charset,
      this.filesize,
      this.width,
      this.height,
      this.duration,
      this.description,
      this.location,
      this.checksum,
      this.data});

  factory DirectusFilesId.fromJson(Map<String, dynamic> json) =>
      _$DirectusFilesIdFromJson(json);

  Map<String, dynamic> toJson() => _$DirectusFilesIdToJson(this);
}

@JsonSerializable()
class DirectusFilesIdRequest {
  int? id;

  DirectusFilesIdRequest({this.id});

  factory DirectusFilesIdRequest.fromJson(Map<String, dynamic> json) =>
      _$DirectusFilesIdRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DirectusFilesIdRequestToJson(this);
}

@JsonSerializable()
class AddTaskModel {
  DataUserTask? data;

  AddTaskModel({this.data});

  factory AddTaskModel.fromJson(Map<String, dynamic> json) =>
      _$AddTaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddTaskModelToJson(this);
}

@JsonSerializable()
class AllTasksModel {
  List<DataAllTasks>? data;

  AllTasksModel({this.data});

  factory AllTasksModel.fromJson(Map<String, dynamic> json) =>
      _$AllTasksModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllTasksModelToJson(this);
}

class DataAllTasks {
  int? id;
  String? status;
  dynamic sort;
  dynamic? owner;
  String? created_on;
  dynamic? modified_by;
  String? modified_on;
  dynamic? assigned_to;
  String? due_date;
  String? title;
  String? description;
  String? client_name;
  String? client_phone;
  String? notes;
  String? task_status;
  String? priority;
  String? start_date;
  dynamic? location;
  String? complete_date;
  String? cancelled_date;
  dynamic? files;
  dynamic? company;

  DataAllTasks({
    this.id,
    this.status,
    this.sort,
    this.owner,
    this.created_on,
    this.modified_by,
    this.modified_on,
    this.assigned_to,
    this.due_date,
    this.title,
    this.description,
    this.client_name,
    this.client_phone,
    this.notes,
    this.task_status,
    this.priority,
    this.start_date,
    this.location,
    this.complete_date,
    this.cancelled_date,
    this.files,
    this.company,
  });

  factory DataAllTasks.fromJson(Map<String, dynamic> json) {
    return DataAllTasks(
      id: json['id'] as int?,
      status: json['status'] as String?,
      sort: json['sort'],
      owner: json['owner'],
      created_on: json['created_on'] as String?,
      modified_by: json['modified_by'],
      modified_on: json['modified_on'] as String?,
      assigned_to: json['assigned_to'] != null
          ? AssignedTo.fromJson(json['assigned_to'])
          : null,
      //json['assigned_to'],
      due_date: json['due_date'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      client_name: json['client_name'] as String?,
      client_phone: json['client_phone'] as String?,
      notes: json['notes'] as String?,
      task_status: json['task_status'] as String?,
      priority: json['priority'] as String?,
      start_date: json['start_date'] as String?,
      location: json['location'] is Map<String, dynamic>
          ? Location.fromJson(json['location'])
          : json['location'] is int
              ? Location(id: json['location'])
              : null,
      complete_date: json['complete_date'] as String?,
      cancelled_date: json['cancelled_date'] as String?,
      files: json['files'],
      company: json['company'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'sort': sort,
      'owner': owner?.toJson(),
      'created_on': created_on,
      'modified_by': modified_by?.toJson(),
      'modified_on': modified_on,
      'assigned_to': assigned_to?.toJson(),
      'due_date': due_date,
      'title': title,
      'description': description,
      'client_name': client_name,
      'client_phone': client_phone,
      'notes': notes,
      'task_status': task_status,
      'priority': priority,
      'start_date': start_date,
      'location': location?.toJson(),
      'complete_date': complete_date,
      'cancelled_date': cancelled_date,
      'files': files?.map((e) => e.toJson()).toList(),
      'company': company?.toJson(),
    };
  }

  static Owner? _parseOwner(dynamic json) {
    if (json == null) return null;
    if (json is int) return Owner(id: json);
    if (json is Map<String, dynamic>) return Owner.fromJson(json);
    return null;
  }
}

@JsonSerializable()
class Company {
  int? id;
  String? status;
  dynamic sort;
  int? owner;
  String? created_on;
  int? modified_by;
  String? modified_on;
  String? name;
  String? logo;
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
class Owner {
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
  String? timezone;
  String? locale;
  String? locale_options;
  Avatar? avatar;
  String? company;
  String? title;
  bool? email_notifications;
  String? last_access_on;
  String? last_page;
  int? companies;

  Owner({
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
    this.timezone,
    this.locale,
    this.locale_options,
    this.avatar,
    this.company,
    this.title,
    this.email_notifications,
    this.last_access_on,
    this.last_page,
    this.companies,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    final cleaned = Map<String, dynamic>.from(json);
    final rawCompanies = json['companies'];
    cleaned['companies'] =
        (rawCompanies is Map && rawCompanies.containsKey('id'))
            ? rawCompanies['id'] as int
            : (rawCompanies is int ? rawCompanies : null);
    return _$OwnerFromJson(cleaned);
  }

  Map<String, dynamic> toJson() => _$OwnerToJson(this);
}

@JsonSerializable()
class OwnerLocation {
  dynamic? id;
  String? status;
  dynamic? role;
  String? first_name;
  String? last_name;
  String? email;
  String? token;
  String? external_id;
  String? theme;
  String? n2fa_secret;
  String? password_resetToken;
  String? timezone;
  String? locale;
  String? locale_options;
  Avatar? avatar;
  String? company;
  String? title;
  bool? email_notifications;
  String? last_access_on;
  String? last_page;

  OwnerLocation({
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
    this.timezone,
    this.locale,
    this.locale_options,
    this.avatar,
    this.company,
    this.title,
    this.email_notifications,
    this.last_access_on,
    this.last_page,
  });

  factory OwnerLocation.fromJson(Map<String, dynamic> json) =>
      _$OwnerLocationFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerLocationToJson(this);
}

@JsonSerializable()
class AssignedTo {
  int? id;
  String? status;
  dynamic role;  // remove '?'
  String? first_name;
  String? last_name;
  String? email;
  String? token;
  String? external_id;
  String? theme;
  String? n2fa_secret;
  String? password_resetToken;
  String? timezone;
  String? locale;
  String? locale_options;
  Avatar? avatar;
  String? company;
  String? title;
  bool? email_notifications;
  String? last_access_on;
  String? last_page;

  AssignedTo({
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
    this.timezone,
    this.locale,
    this.locale_options,
    this.avatar,
    this.company,
    this.title,
    this.email_notifications,
    this.last_access_on,
    this.last_page,
  });

  factory AssignedTo.fromJson(Map<String, dynamic> json) {
    return AssignedTo(
      id: json['id'] as int?,
      status: json['status'] as String?,
      role: json['role'],
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
          : (json['avatar'] is int
          ? Avatar(id: json['avatar'] as int)
          : Avatar.fromJson(json['avatar'] as Map<String, dynamic>)),
      company: json['company'] as String?,
      title: json['title'] as String?,
      email_notifications: json['email_notifications'] as bool?,
      last_access_on: json['last_access_on'] as String?,
      last_page: json['last_page'] as String?,
    );
  }

  Map<String, dynamic> toJson() => _$AssignedToToJson(this);
}



@JsonSerializable()
class Location {
  int? id;
  String? status;
  String? sort;
  dynamic owner;
  String? created_on;
  dynamic? modified_by;
  String? modified_on;
  String? latitude;
  String? longitude;
  String? address;
  String? map_url;

  Location({
    this.id,
    this.status,
    this.sort,
    this.owner,
    this.created_on,
    this.modified_by,
    this.modified_on,
    this.latitude,
    this.longitude,
    this.address,
    this.map_url,
  });

  factory Location.fromJson(dynamic json) {
    if (json == null) return Location();
    if (json is int) return Location(id: json);
    if (json is Map<String, dynamic>) return _$LocationFromJson(json);
    throw Exception('Invalid type for Location: ${json.runtimeType}');
  }

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
