import 'package:toodoo_bank/generated/json/base/json_field.dart';
import 'package:toodoo_bank/generated/json/token_model_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class TokenModelEntity {

	@JSONField(name: "access_token")
	late String accessToken;
	@JSONField(name: "refresh_token")
	late String refreshToken;
	late TokenModelInfo info;
  
  TokenModelEntity();

  factory TokenModelEntity.fromJson(Map<String, dynamic> json) => $TokenModelEntityFromJson(json);

  Map<String, dynamic> toJson() => $TokenModelEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TokenModelInfo {

	late bool hasTransactionalPassword;
  
  TokenModelInfo();

  factory TokenModelInfo.fromJson(Map<String, dynamic> json) => $TokenModelInfoFromJson(json);

  Map<String, dynamic> toJson() => $TokenModelInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}