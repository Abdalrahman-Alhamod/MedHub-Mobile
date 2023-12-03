import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as get_lib;
import 'package:dio/dio.dart';
import 'package:pharmacy_warehouse_store_mobile/main.dart';

class MethodType {
  const MethodType._();
  static const String get = 'GET';
  static const String post = 'POST';
  static const String put = 'PUT';
  static const String delete = 'DELETE';
}

class Api {
  const Api._();
  static const String baseUrl = 'https://8927-5-155-4-181.ngrok-free.app';

  static Future<dynamic> request(
      {required String url,
      @required dynamic body,
      @required String? token,
      required String methodType}) async {
    Map<String, String> headers = {};

    headers.addAll(
      {'token': token ?? "", 'lang': get_lib.Get.locale.toString()},
    );

    final dio = Dio();
    try {
      Response response = await dio.post(
        baseUrl + url,
        data: body,
        options: Options(
          headers: headers,
          method: methodType,
        ),
      );
      var jsonData = jsonDecode(
        response.toString(),
      );
      return jsonData;
    } on DioException catch (exception) {
      logger.e("API Dio Exception : $exception");
      if (exception.toString().contains('SocketException')) {
        throw DioException(
            message: "networkError".tr, requestOptions: RequestOptions());
      } else if (exception.type == DioExceptionType.receiveTimeout ||
          exception.type == DioExceptionType.connectionTimeout) {
        throw DioException(
            message: "connectionTimeOut".tr, requestOptions: RequestOptions());
      } else {
        dynamic jsonData, erroMessage;
        try {
          jsonData = jsonDecode(exception.response.toString());
          erroMessage = jsonData['message'];
        } catch (e) {
          throw DioException(
              message: "somthingWrongHappend".tr,
              requestOptions: RequestOptions());
        }
        throw DioException(
            message: erroMessage, requestOptions: RequestOptions());
      }
    } catch (e) {
      logger.e("API General Exception : $e");
      throw Exception(e.toString());
    }
  }
}
