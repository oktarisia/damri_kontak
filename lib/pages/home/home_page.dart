import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/kontak_provider.dart';
import '../../theme.dart';
import '../../widgets/kontak_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getInit();
    print("initState()");
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies()");
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    print("didUpdateWidget()");
    super.didUpdateWidget(oldWidget);
  }

  void getInit() async {
    await Provider.of<KontakProvider>(context, listen: false).getKontaks();
  }

  @override
  Widget build(BuildContext context) {
    KontakProvider kontakProvider = Provider.of<KontakProvider>(context);

    Widget daftarKontakTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'Daftar Kontak',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget daftarKontak() {
      return Container(
        margin: EdgeInsets.only(
          top: 14,
        ),
        child: Column(
          children: kontakProvider.kontaks
              .map((kontak) => KontakTile(kontak))
              .toList(),
        ),
      );
    }

    return ListView(
      children: [
        daftarKontakTitle(),
        SizedBox(
          height: 10,
        ),
        daftarKontak(),
      ],
    );
  }
}
