import 'package:damri_kontak/providers/kontak_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/kontak_model.dart';
import '../theme.dart';

class EditPage extends StatefulWidget {
  final KontakModel kontak;
  EditPage(this.kontak);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController namaController =
        TextEditingController(text: widget.kontak.nama);

    TextEditingController nomorController =
        TextEditingController(text: widget.kontak.nomor);
    KontakProvider kontakProvider = Provider.of<KontakProvider>(context);

    handleEdit() async {
      setState(() {
        isLoading = true;
      });
      if (await kontakProvider.edit(
        id: widget.kontak.id,
        nama: namaController.text,
        nomor: nomorController.text,
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: successColor,
            content: Text(
              'Kontak berhasil diedit',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text(
              'Gagal Menambah Kontak',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      setState(() {
        isLoading = false;
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
              'Nama',
              style: secondaryTextStyle.copyWith(fontSize: 13),
            ),
            TextFormField(
              style: primaryTextStyle,
              controller: namaController,
              decoration: InputDecoration(
                hintText: 'Masukkan Nama',
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: subtitleColor,
                  ),
                ),
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
              'Nomor',
              style: secondaryTextStyle.copyWith(fontSize: 13),
            ),
            TextFormField(
              style: primaryTextStyle,
              controller: nomorController,
              decoration: InputDecoration(
                hintText: 'Masukkan Nomor',
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: subtitleColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget saveButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: TextButton(
          onPressed: handleEdit,
          style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
          child: Text(
            'Simpan',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
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
            saveButton()
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundCalor3,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: backgroundCalor1,
        centerTitle: true,
        title: Text(
          'Edit Kontak',
          style: primaryTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 18,
          ),
        ),
        elevation: 0,
      ),
      body: content(),
    );
  }
}
