import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:simak_uin_suka/theme.dart';
import 'package:simak_uin_suka/view/sign_in_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      durationInSeconds: 3,
      logo: Image.asset('assets/images/logo_uin.png'),
      title: Text(
        "SIMAK UIN SUKA",
        style: h1,
      ),
      backgroundColor: Colors.grey.shade400,
      showLoader: true,
      // loadingText: Text(
      //   "Mengunduh Data...",
      //   style: h2,
      // ),
      navigator: const SignInPage(),
    );
  }
}
