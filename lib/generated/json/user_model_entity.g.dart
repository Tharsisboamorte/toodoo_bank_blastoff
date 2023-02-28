import 'package:toodoo_bank/generated/json/base/json_convert_content.dart';
import 'package:toodoo_bank/network/models/user_model_entity.dart';

UserModelEntity $UserModelEntityFromJson(Map<String, dynamic> json) {
	final UserModelEntity userModelEntity = UserModelEntity();
	final String? username = jsonConvert.convert<String>(json['username']);
	if (username != null) {
		userModelEntity.username = username;
	}
	final String? password = jsonConvert.convert<String>(json['password']);
	if (password != null) {
		userModelEntity.password = password;
	}
	return userModelEntity;
}

Map<String, dynamic> $UserModelEntityToJson(UserModelEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['username'] = entity.username;
	data['password'] = entity.password;
	return data;
}