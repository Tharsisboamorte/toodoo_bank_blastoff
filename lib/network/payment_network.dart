import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toodoo_bank/network/models/billet_payment_entity.dart';
import 'package:toodoo_bank/network/models/token_model_entity.dart';

import 'models/barcode_model.dart';

const request = "https://qa-internal-api.tfes.tech/";

class CallApi {
  final dio = Dio(
    BaseOptions(
      baseUrl: request,
      connectTimeout: const Duration(milliseconds: 5000),
    ),
  )..interceptors.add(networkService());

  //Shared prefs
  Future<String?> getTokenPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      return token;
    }
    return null;
  }

  //Validar o código de barras
  Future<bool> isValidBarCode(String barcode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final authToken = prefs.getString('token');
      if (authToken == null) {
        throw Exception('Failed to get auth token');
      }

      final response = await dio.get(
        "https://qa-api.tfes.tech/transfer/v1/validate/$barcode",
        options: Options(
          headers: {
            'Accept-Language': 'pt-BR',
            "Authorization": "Bearer $authToken",
            'Ocp-Apim-Subscription-Key': '31e412230884479bb6252284d4020f8a',
            'Content-Type': 'application/json'
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        final errorMessage = response.data['message'] ?? response.statusMessage;
        throw Exception('Failed to validate barcode: $errorMessage');
      }
    } catch (e) {
      debugPrint('Error validating barcode: $e');
      return false;
    }
  }

  Future<BarcodeModelEntity> getValidBarCode(String barcode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('token');
    debugPrint("Token :  $authToken");
    Response response =
        await dio.get("https://qa-api.tfes.tech/transfer/v1/validate/$barcode",
            options: Options(headers: {
              'Accept-Language': 'pt-BR',
              "Authorization": "Bearer $authToken",
              'Ocp-Apim-Subscription-Key': '31e412230884479bb6252284d4020f8a',
              'Content-Type': 'application/json'
            }),
        );

    if (response.statusCode == 200) {
      return BarcodeModelEntity.fromJson(response.data);
    } else {
      debugPrint("error : ${response.statusMessage}");
      throw Exception('Failed to get valid barcode');
    }
  }

  //Realizar o pagamento
  void postPayment(BilletPaymentEntity billetPayment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('token');
    try {
      await dio.post("https://qa-api.tfes.tech/transfer/v1/billetPayment",
          data: billetPayment.toJson(),
          options: Options(headers: {"Authorization": "Bearer $authToken"}));
    } on DioError catch (error) {
      debugPrint("Error when posting: ${error.response?.statusCode}");
    }
  }

  //Pegar o token
  Future<TokenModelEntity?> getToken() async {
    final response = await dio.post(
      'https://qa-api.tfes.tech/account/v1/auth/token',
      options: Options(
        headers: {
          'Accept-Language': 'en_US',
          'Ocp-Apim-Subscription-Key': '31e412230884479bb6252284d4020f8a',
          'Content-Type': 'application/json',
        },
      ),
      data: jsonEncode({
        'username': '00000002135',
        'password': 'Abelha@123',
      }),
    );

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final TokenModelEntity token = TokenModelEntity.fromJson(response.data);
      await prefs.setString('token', token.accessToken);
      debugPrint("tokenModel : $token");
      return token;
    } else {
      debugPrint('Failed to get token: ${response.statusCode}');
    }
    return null;
  }
}

//Interceptors
class networkService extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }
}
