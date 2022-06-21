import 'package:damri_kontak/pages/add_page.dart';
import 'package:damri_kontak/pages/detail_page.dart';
import 'package:damri_kontak/pages/edit_page.dart';
import 'package:damri_kontak/pages/home/main_page.dart';
import 'package:damri_kontak/pages/home/profile_page.dart';
import 'package:damri_kontak/pages/sign_in_page.dart';
import 'package:damri_kontak/pages/splash_page.dart';
import 'package:damri_kontak/providers/auth_provider.dart';
import 'package:damri_kontak/providers/kontak_provider.dart';
import 'package:damri_kontak/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => KontakProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/sign-in': (context) => SignInPage(),
          '/home': (context) => MainPage(),
          '/add': (context) => AddPage(),
        },
      ),
    );
  }
}
