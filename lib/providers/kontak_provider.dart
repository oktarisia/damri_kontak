import 'package:damri_kontak/providers/auth_provider.dart';
import 'package:damri_kontak/services/kontak_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/kontak_model.dart';
import '../models/user_model.dart';

class KontakProvider with ChangeNotifier {
  List<KontakModel> _kontaks = [];
  List<KontakModel> get kontaks => _kontaks;

  KontakModel _kontak;
  KontakModel get kontak => _kontak;

  set kontaks(List<KontakModel> kontaks) {
    _kontaks = kontaks;
    notifyListeners();
  }

  set kontak(KontakModel kontak) {
    _kontak = kontak;
    notifyListeners();
  }

  Future<void> getKontaks() async {
    try {
      List<KontakModel> kontaks = await KontakService().getKontaks();
      _kontaks = kontaks;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<bool> add({
    String nama,
    String nomor,
  }) async {
    try {
      if (await KontakService().addKontak(
        nama: nama,
        nomor: nomor,
      )) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> edit({
    String id,
    String nama,
    String nomor,
  }) async {
    try {
      if (await KontakService().editKontak(
        id: id,
        nama: nama,
        nomor: nomor,
      )) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete({
    String id,
  }) async {
    try {
      if (await KontakService().deleteKontak(
        id: id,
      )) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
