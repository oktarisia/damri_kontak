import 'dart:convert';

import 'package:damri_kontak/models/kontak_model.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/auth_provider.dart';

class KontakService {
  String baseUrl = 'https://testapi.damri.co.id/index.php';

  BuildContext context;

  Future<List<KontakModel>> getKontaks() async {
    var url = '$baseUrl/kontak';
    var header = {
      'Content-Type': 'application/json; charset=utf-8',
      'cookie': 'ci_session=l0744c78lmsmunf77ab7r8dkdguu9ul9',
    };

    var respone = await http.get(url, headers: header);

    if (respone.statusCode == 200) {
      List data = jsonDecode(respone.body)['data'];
      List<KontakModel> kontaks = [];

      for (var item in data) {
        kontaks.add(KontakModel.fromJson(item));
      }

      return kontaks;
    } else {
      throw Exception(respone.statusCode);
    }
  }

  Future<bool> addKontak({
    String nama,
    String nomor,
  }) async {
    var url = '$baseUrl/kontak';
    var header = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'cookie': 'ci_session=l0744c78lmsmunf77ab7r8dkdguu9ul9',
    };
    var body = {
      'nama': nama,
      'nomor': nomor,
    };
    var respone = await http.post(url, headers: header, body: body);

    print(respone.body);
    if (respone.statusCode == 200) {
      return true;
    } else {
      throw Exception(respone.statusCode);
    }
  }

  Future<bool> editKontak({
    String id,
    String nama,
    String nomor,
  }) async {
    var url = '$baseUrl/kontak';
    var header = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'cookie': 'ci_session=l0744c78lmsmunf77ab7r8dkdguu9ul9',
    };
    var body = {
      'id': id,
      'nama': nama,
      'nomor': nomor,
    };
    var respone = await http.put(url, headers: header, body: body);

    print(respone.body);
    if (respone.statusCode == 200) {
      return true;
    } else {
      throw Exception(respone.statusCode);
    }
  }

  Future<bool> deleteKontak({
    String id,
  }) async {
    var url = '$baseUrl/kontak/';
    var header = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'cookie': 'ci_session=l0744c78lmsmunf77ab7r8dkdguu9ul9',
    };
    var body = {
      'id': id,
    };

    http.Request rq = http.Request('DELETE', Uri.parse(url))
      ..headers.addAll({
        'Content-Type': 'application/x-www-form-urlencoded',
        'cookie': 'ci_session=l0744c78lmsmunf77ab7r8dkdguu9ul9',
      });
    rq.bodyFields = {
      'id': id,
    };

    http.StreamedResponse respone = await http.Client().send(rq);
    // var respone = await http.delete(
    //   url,
    //   headers: header,
    // );

    if (respone.statusCode == 200) {
      return true;
    } else {
      throw Exception(respone.statusCode);
    }
  }
}
