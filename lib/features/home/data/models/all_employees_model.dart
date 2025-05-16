
import 'package:json_annotation/json_annotation.dart';

part 'all_employees_model.g.dart';


@JsonSerializable()

class AllEmployeeModel {
  List<DataAllEmployee>? data;

  AllEmployeeModel({this.data});

  factory AllEmployeeModel.fromJson(Map<String, dynamic> json) => _$AllEmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllEmployeeModelToJson(this);
}
@JsonSerializable()
class DataAllEmployee {
  int? id;
  String? status;
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

  DataAllEmployee({this.id,
    this.status,
    this.owner,
    this.created_on,
    this.modified_by,
    this.modified_on,
    this.phone_1,
    this.phone_2,
    this.whatsapp,
    this.email,
    this.address,
    this.user});

  factory DataAllEmployee.fromJson(Map<String, dynamic> json) => _$DataAllEmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$DataAllEmployeeToJson(this);
}


