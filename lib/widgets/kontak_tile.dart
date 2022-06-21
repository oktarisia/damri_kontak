import 'package:damri_kontak/models/kontak_model.dart';
import 'package:damri_kontak/pages/detail_page.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

// ignore: use_key_in_widget_constructors
class KontakTile extends StatelessWidget {
  final KontakModel kontrak;
  KontakTile(this.kontrak);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: defaultMargin,
        right: defaultMargin,
        bottom: 10,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(kontrak),
            ),
          );
        },
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/image_profile.png',
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kontrak.nama,
                        style: primaryTextStyle.copyWith(
                          fontSize: 24,
                          fontWeight: medium,
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 24,
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(
              thickness: 1,
              color: Color(0xff2B2939),
            )
          ],
        ),
      ),
    );
  }
}
