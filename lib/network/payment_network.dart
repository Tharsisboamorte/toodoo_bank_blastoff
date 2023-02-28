import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

import 'package:toodoo_bank/network/models/billet_payment_entity.dart';

import 'models/barcode_model.dart';

const request = "https://qa-internal-api.tfes.tech/";

class CallApi{
  Future<String?> getTokenPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      return token;
    }
    return null;
  }

  final dio = Dio(
    BaseOptions(
      baseUrl: request,
      connectTimeout: const Duration(milliseconds: 5000),

    ),
  )..interceptors.add(networkService());


  Future<BarcodeModelEntity> getValidBarCode(String barcode) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('token');
    debugPrint("Token :  $authToken");
    Response response = await dio.get("transfer/v1/validate/$barcode",
        options: Options(
            headers: {
              "Authorization" : "Bearer $authToken"
            }
        ));
    if (response.statusCode == 200) {
      return BarcodeModelEntity.fromJson(response.data);
    } else {
      debugPrint("error : ${response.statusMessage}");
      throw Exception('Failed to get valid barcode');
    }
  }

  void postPayment(BilletPaymentEntity billetPayment) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('token');
    try {
      await dio.post("transfer/v1/billetPayment", data: billetPayment.toJson(), options: Options(
        headers: {"Authorization": "Bearer $authToken"}));
    } on DioError catch (error) {
      debugPrint("Error when posting: ${error.response?.statusCode}");
    }
  }

  Future<void> getToken() async {
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
      final token = response.data;
      await prefs.setString('token', token.toString());
      return token;
    } else {
      debugPrint('Failed to get token: ${response.statusCode}');
    }
  }

}

class networkService extends InterceptorsWrapper{

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