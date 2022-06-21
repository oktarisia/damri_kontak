import 'dart:convert';

import '../models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseUrl = 'https://testapi.damri.co.id/index.php';

  Future<UserModel> login({
    String username,
    String password,
  }) async {
    var url = '$baseUrl/Loginact';
    var header = {'Content-Type': 'application/x-www-form-urlencoded'};
    var body = {
      'username': username,
      'password': password,
      'token': '463d2c83201694a5404d1e2d58b0350c'
    };

    var respone = await http.post(url, headers: header, body: body);

    if (respone.statusCode == 200) {
      String tes = respone.headers["set-cookie"].toString();

      var sessionId = tes.split(";");

      UserModel user = UserModel.fromJson({'token': sessionId[0]});

      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }
}
