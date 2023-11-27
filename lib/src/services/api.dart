import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as get_lib;
import 'package:dio/dio.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/user.dart';

class MethodType {
  static const String get = 'GET';
  static const String post = 'POST';
  static const String put = 'PUT';
  static const String delete = 'DELETE';
}

class Api {
  final String baseUrl = 'https://8927-5-155-4-181.ngrok-free.app';

  Future<dynamic> request(
      {required String url,
      @required dynamic body,
      @required String? token,
      required String methodType}) async {
    Map<String, String> headers = {};

    headers.addAll(
      {'userToken': token ?? ""},
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
      // TODO remove from body when implement header
      User.token = jsonData['token'];
      return jsonData;
    } on DioException catch (exception) {
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
          log(e.toString());
          throw DioException(
              message: "somthingWrongHappend".tr,
              requestOptions: RequestOptions());
        }
        throw DioException(
            message: erroMessage, requestOptions: RequestOptions());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
