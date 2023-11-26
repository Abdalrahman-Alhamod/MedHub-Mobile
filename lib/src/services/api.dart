import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as get_lib;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class MethodType {
  static const String get = 'GET';
  static const String post = 'POST';
  static const String put = 'PUT';
  static const String delete = 'DELETE';
}

class Api {
  static String? userToken;
  final String baseUrl = 'https://www.google.com/api/';

  Future<dynamic> request(
      {required String url,
      @required dynamic body,
      @required String? token,
      required MethodType methodType}) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers.addAll({'userToken': token});
    }

    final dio = Dio();
    try {
      Response response = await dio.request(baseUrl + url,
          data: body,
          options: Options(headers: headers, method: methodType.toString()));
      var jsonData = jsonDecode(response.data);
      if (response.statusCode == 200 || response.statusCode == 200) {
        return jsonData;
      } else {
        throw Exception(jsonData['message']);
      }
    } on DioException catch (exception) {
      if (exception.toString().contains('SocketException')) {
        throw Exception("Network Error !");
      } else if (exception.type == DioExceptionType.receiveTimeout ||
          exception.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection time out !");
      } else {
        return Exception('Somthing wrong happend !');
      }
    }
  }

  Future<dynamic> get({required String url, @required String? token}) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers.addAll({'userToken': token});
    }

    final dio = Dio();
    try {
      Response response =
          await dio.get(url, options: Options(headers: headers));
      var jsonData = jsonDecode(response.data);
      if (response.statusCode == 200 || response.statusCode == 200) {
        return jsonData;
      } else {
        throw Exception(jsonData['message']);
      }
    } on DioException catch (exception) {
      if (exception.toString().contains('SocketException')) {
        throw Exception("Network Error !");
      } else if (exception.type == DioExceptionType.receiveTimeout ||
          exception.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection time out !");
      } else {
        return Exception('Somthing wrong happend !');
      }
    }
  }

  Future<dynamic> post(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers.addAll({'userToken': token});
    }

    final dio = Dio();
    try {
      Response response = await dio.post(baseUrl + url,
          data: body, options: Options(headers: headers));
      var jsonData = jsonDecode(response.data);
      if (response.statusCode == 200 || response.statusCode == 200) {
        return jsonData;
      } else {
        throw Exception(jsonData['message']);
      }
    } on DioException catch (exception) {
      if (exception.toString().contains('SocketException')) {
        throw DioException(
            message: "networkError".tr, requestOptions: RequestOptions());
      } else if (exception.type == DioExceptionType.receiveTimeout ||
          exception.type == DioExceptionType.connectionTimeout) {
        throw DioException(
            message: "connectionTimeOut".tr, requestOptions: RequestOptions());
      } else {
        throw DioException(
            message: "somthingWrongHappend".tr,
            requestOptions: RequestOptions());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> put(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers.addAll({'userToken': token});
    }

    final dio = Dio();
    try {
      Response response =
          await dio.post(url, data: body, options: Options(headers: headers));
      var jsonData = jsonDecode(response.data);
      if (response.statusCode == 200 || response.statusCode == 200) {
        return jsonData;
      } else {
        throw Exception(jsonData['message']);
      }
    } on DioException catch (exception) {
      if (exception.toString().contains('SocketException')) {
        throw Exception("Network Error !");
      } else if (exception.type == DioExceptionType.receiveTimeout ||
          exception.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection time out !");
      } else {
        return Exception('Somthing wrong happend !');
      }
    }
  }

  Future<dynamic> delete(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response =
        await http.delete(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
