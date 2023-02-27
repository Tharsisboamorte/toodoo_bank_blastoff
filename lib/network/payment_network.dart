import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';

import 'package:toodoo_bank/network/models/billet_payment_entity.dart';

const request = "https://qa-internal-api.tfes.tech/transfer";

class CallApi{
  Map<dynamic, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Token bff0e7675d6d80bd692f1be811da63e4182e4a5f'
  };

  final dio = Dio(
    BaseOptions(
      baseUrl: request,
    ),
  )..interceptors.add(networkService());

  Future<Map> getValidBarCode(String barcode) async{
    Response response = await dio.get("/v1/validate/{$barcode}");
    return json.decode(response.data);
  }

  void postPayment(BilletPaymentEntity billetPayment) async{
    try {
      await dio.post("/v1/billetPayment", data: billetPayment.toJson());
    } on DioError catch (error) {
      debugPrint("Error when posting: ${error.response?.statusCode}");
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