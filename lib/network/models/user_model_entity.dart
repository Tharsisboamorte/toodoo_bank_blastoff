import 'package:toodoo_bank/generated/json/base/json_field.dart';
import 'package:toodoo_bank/generated/json/user_model_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class UserModelEntity {

	late String username;
	late String password;
  
  UserModelEntity();

  factory UserModelEntity.fromJson(Map<String, dynamic> json) => $UserModelEntityFromJson(json);

  Map<String, dynamic> toJson() => $UserModelEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}