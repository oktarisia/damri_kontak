import 'package:damri_kontak/models/kontak_model.dart';
import 'package:damri_kontak/pages/edit_page.dart';
import 'package:damri_kontak/providers/kontak_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class DetailPage extends StatefulWidget {
  final KontakModel kontak;
  DetailPage(this.kontak);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isLoading = false;
  getInit() async {
    await Provider.of<KontakProvider>(context, listen: false).getKontaks();
  }

  @override
  Widget build(BuildContext context) {
    KontakProvider kontakProvider = Provider.of<KontakProvider>(context);

    handleDelete() async {
      setState(() {
        isLoading = true;
      });
      if (await kontakProvider.delete(
        id: widget.kontak.id,
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: successColor,
            content: Text(
              'Kontak berhasil dihapus',
              textAlign: TextAlign.center,
            ),
          ),
        );
        setState(() {
          getInit();
          Navigator.pushReplacementNamed(context, '/home');
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text(
              'Gagal menghapus Kontak',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      setState(() {
        isLoading = false;
        Navigator.pop(context);
      });
    }

    Widget namaInput() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Kontak',
              style: secondaryTextStyle.copyWith(fontSize: 13),
            ),
            Text(
              widget.kontak.nama,
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
          ],
        ),
      );
    }

    Widget nomorInput() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nomor Kontak',
              style: secondaryTextStyle.copyWith(fontSize: 13),
            ),
            Text(
              widget.kontak.nomor,
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(
                top: defaultMargin,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/image_profile.png'),
                ),
              ),
            ),
            namaInput(),
            nomorInput(),
            SizedBox(
              height: 12,
            ),
            Divider(
              thickness: 1,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            SizedBox(
              height: 12,
            ),
            Center(
              child: GestureDetector(
                onTap: handleDelete,
                child: Text(
                  'Hapus',
                  style: alertTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundCalor3,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: backgroundCalor1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Detail',
              style: primaryTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 18,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPage(widget.kontak),
                  ),
                );
              },
              child: Text(
                'Edit',
                style: primaryTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: content(),
    );
  }
}
