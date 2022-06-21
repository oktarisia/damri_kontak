import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ApiProvider with ChangeNotifier {
  Dio _dio;
  String aToken = '';

  final BaseOptions options = new BaseOptions(
      baseUrl: 'https://testapi.damri.co.id/index.php',
      connectTimeout: 15000,
      receiveTimeout: 13000,
      contentType: 'application/x-www-form-urlencoded');
  static final ApiProvider _instance = ApiProvider._internal();

  factory ApiProvider() => _instance;

  ApiProvider._internal() {
    _dio = Dio(options);
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options options) async {
      // to prevent other request enter this interceptor.
      _dio.interceptors.requestLock.lock();
      // We use a new Dio(to avoid dead lock) instance to request token.
      //Set the cookie to headers
      options.headers["cookie"] = aToken;

      _dio.interceptors.requestLock.unlock();
      return options; //continue
    }));
  }

  Future<bool> login() async {
    final request = {
      "username": "joe@damri.co.id",
      "password": "passwordapi",
      "token": "463d2c83201694a5404d1e2d58b0350c"
    };
    final response = await _dio.post('/Loginact', data: request);
    //get cooking from response
    final cookies = response.headers.map['set-cookie'];
    if (cookies.isNotEmpty && cookies.length == 2) {
      final authToken = cookies[1]
          .split(';')[0]; //it depends on how your server sending cookie
      //save this authToken in local storage, and pass in further api calls.

      aToken =
          authToken; //saving this to global variable to refresh current api calls to add cookie.
      print(authToken);
    }

    print(cookies);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
    //print(response.headers.toString());
  }

  /// If we call this function without cookie then it will throw 500 err.
  Future getKontak() async {
    final response = await http.get('/kontak');

    print(response.body.toString());
  }
}
