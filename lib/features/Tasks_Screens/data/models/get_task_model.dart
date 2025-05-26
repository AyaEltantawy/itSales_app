import 'package:json_annotation/json_annotation.dart';

import '../../../addEmployee/data/models/add_employee_model.dart';

part 'get_task_model.g.dart';

@JsonSerializable()
class GetUserTaskModel {
  List<DataUserTask>? data;

  GetUserTaskModel({this.data});

  factory GetUserTaskModel.fromJson(Map<String, dynamic> json) => _$GetUserTaskModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetUserTaskModelToJson(this);
}

@JsonSerializable()
class DataUserTask {
  int? id;
  String? status;
  String? sort;
  Owner? owner;
  String? created_on;
  Owner? modified_by;
  String? modified_on;
  AssignedTo? assigned_to;
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
  List<FilesResponseModel>? files;

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

  factory DataUserTask.fromJson(Map<String, dynamic> json) => _$DataUserTaskFromJson(json);
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
  String? assigned_to;
  List<Files>? files;
  int? location;
  int? company;

  AddTaskRequestModel({
    this.status,
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
    this.company
  });

  factory AddTaskRequestModel.fromJson(Map<String, dynamic> json) => _$AddTaskRequestModelFromJson(json);
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

  factory FilesResponseModel.fromJson(Map<String, dynamic> json) {
    final raw = json['directus_files_id'];
    return FilesResponseModel(
      id: json['id'] as int?,
      directus_files_id: raw is Map<String, dynamic>
          ? DirectusFilesId.fromJson(raw)
          : raw is int
          ? DirectusFilesId(id: raw)
          : null,
    );

  }

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

  DirectusFilesId({
    this.id,
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
    this.data,
  });

  factory DirectusFilesId.fromJson(Map<String, dynamic> json) => _$DirectusFilesIdFromJson(json);
  Map<String, dynamic> toJson() => _$DirectusFilesIdToJson(this);
}

@JsonSerializable()
class DirectusFilesIdRequest {
  int? id;

  DirectusFilesIdRequest({this.id});

  factory DirectusFilesIdRequest.fromJson(Map<String, dynamic> json) => _$DirectusFilesIdRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DirectusFilesIdRequestToJson(this);
}

@JsonSerializable()
class AddTaskModel {
  DataUserTask? data;

  AddTaskModel({this.data});
  factory AddTaskModel.fromJson(Map<String, dynamic> json) => _$AddTaskModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddTaskModelToJson(this);
}

@JsonSerializable()
class AllTasksModel {
  List<DataAllTasks>? data;

  AllTasksModel({this.data});
  factory AllTasksModel.fromJson(Map<String, dynamic> json) => _$AllTasksModelFromJson(json);
  Map<String, dynamic> toJson() => _$AllTasksModelToJson(this);
}


@JsonSerializable()
class DataAllTasks {
  int? id;
  String? status;
  dynamic? sort;
  Owner? owner;
  String? created_on;
  Owner? modified_by;
  String? modified_on;
  AssignedTo? assigned_to;
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
  List<FilesResponseModel>? files;
  //Company? companies;
  //int? companyId;

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
    //this.companies,
   // this.companyId,
  });

  factory DataAllTasks.fromJson(Map<String, dynamic> json) {
    final companiesJson = json['companies'];
    // Company? company;
    // int? companyId;
    //
    // if (companiesJson is Map<String, dynamic>) {
    //   company = Company.fromJson(companiesJson);
    //   companyId = companiesJson['id'] as int?;
    // } else if (companiesJson is int) {
    //   companyId = companiesJson;
    // }

    return DataAllTasks(
      id: json['id'],
      status: json['status'] as String?,
      sort: json['sort'],
      owner: json['owner'] is Map<String, dynamic>
          ? Owner.fromJson(json['owner'])
          : null,
      created_on: json['created_on'] as String?,
      modified_by: json['modified_by'] is Map<String, dynamic>
          ? Owner.fromJson(json['modified_by'])
          : null,
      modified_on: json['modified_on'] as String?,
      assigned_to: json['assigned_to'] is Map<String, dynamic>
          ? AssignedTo.fromJson(json['assigned_to'])
          : null,
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
          : null,
      complete_date: json['complete_date'] as String?,
      cancelled_date: json['cancelled_date'] as String?,
      files: (json['files'] as List?)
          ?.map((e) {
        if (e is Map<String, dynamic>) {
          return FilesResponseModel.fromJson(e);
        } else if (e is int) {
          return FilesResponseModel(id: e); // handle int fallback
        } else {
          return null;
        }
      })
          .whereType<FilesResponseModel>()
          .toList(),

     // companies: company,
     // companyId: companyId,
    );
  }

  Map<String, dynamic> toJson() => _$DataAllTasksToJson(this);
}

// @JsonSerializable()
// class Company {
//   dynamic? id;
//   String? status;
//   dynamic sort;
//   dynamic? owner;
//   String? created_on;
//   dynamic? modified_by;
//   String? modified_on;
//   String? name;
//   dynamic? logo;
//   String? email;
//   String? whatsapp;
//   String? website;
//
//   Company({
//     this.id,
//     this.status,
//     this.sort,
//     this.owner,
//     this.created_on,
//     this.modified_by,
//     this.modified_on,
//     this.name,
//     this.logo,
//     this.email,
//     this.whatsapp,
//     this.website,
//   });
//
//   factory Company.fromJson(Map<String, dynamic> json) =>
//       _$CompanyFromJson(json);
//
//   Map<String, dynamic> toJson() => _$CompanyToJson(this);
// }

@JsonSerializable()
@JsonSerializable()
class Owner {
  dynamic id;
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

  /// Only keep this - no dynamic or map allowed
  int companies;

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
    required this.companies,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    // Handle companies being sent as map or int
    final cleanedJson = Map<String, dynamic>.from(json);
    final rawCompanies = json['companies'];

    cleanedJson['companies'] = (rawCompanies is Map && rawCompanies.containsKey('id'))
        ? rawCompanies['id'] as int
        : rawCompanies is int
        ? rawCompanies
        : 0;

    return _$OwnerFromJson(cleanedJson);
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
  dynamic? avatar;
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

  factory OwnerLocation.fromJson(Map<String, dynamic> json) => _$OwnerLocationFromJson(json);
  Map<String, dynamic> toJson() => _$OwnerLocationToJson(this);
}

@JsonSerializable()
class AssignedTo {
  dynamic? id;
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

  factory AssignedTo.fromJson(Map<String, dynamic> json) => _$AssignedToFromJson(json);
  Map<String, dynamic> toJson() => _$AssignedToToJson(this);
}

@JsonSerializable()
class Location {
  dynamic? id;
  String? status;
  String? sort;
  OwnerLocation? owner;
  String? created_on;
  OwnerLocation? modified_by;
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

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}