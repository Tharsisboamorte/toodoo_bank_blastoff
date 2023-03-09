import 'package:toodoo_bank/generated/json/base/json_convert_content.dart';
import 'package:toodoo_bank/network/models/token_model_entity.dart';

TokenModelEntity $TokenModelEntityFromJson(Map<String, dynamic> json) {
	final TokenModelEntity tokenModelEntity = TokenModelEntity();
	final String? accessToken = jsonConvert.convert<String>(json['access_token']);
	if (accessToken != null) {
		tokenModelEntity.accessToken = accessToken;
	}
	final String? refreshToken = jsonConvert.convert<String>(json['refresh_token']);
	if (refreshToken != null) {
		tokenModelEntity.refreshToken = refreshToken;
	}
	final TokenModelInfo? info = jsonConvert.convert<TokenModelInfo>(json['info']);
	if (info != null) {
		tokenModelEntity.info = info;
	}
	return tokenModelEntity;
}

Map<String, dynamic> $TokenModelEntityToJson(TokenModelEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['access_token'] = entity.accessToken;
	data['refresh_token'] = entity.refreshToken;
	data['info'] = entity.info.toJson();
	return data;
}

TokenModelInfo $TokenModelInfoFromJson(Map<String, dynamic> json) {
	final TokenModelInfo tokenModelInfo = TokenModelInfo();
	final bool? hasTransactionalPassword = jsonConvert.convert<bool>(json['hasTransactionalPassword']);
	if (hasTransactionalPassword != null) {
		tokenModelInfo.hasTransactionalPassword = hasTransactionalPassword;
	}
	return tokenModelInfo;
}

Map<String, dynamic> $TokenModelInfoToJson(TokenModelInfo entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['hasTransactionalPassword'] = entity.hasTransactionalPassword;
	return data;
}