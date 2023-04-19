import 'package:flutter/material.dart';

// class SplashPage extends StatelessWidget {
//   const SplashPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// import 'dart:async';

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:simak_uin_suka/view/main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // Future<Widget> futureCall() async {
  //   // do async operation ( api call, auto login)
  //   return Future.value(new MainPage());
  // }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      durationInSeconds: 5,
      logo: Image.network(
          'https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/flutter-512.png'),
      title: const Text(
        "Title",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.grey.shade400,
      showLoader: true,
      loadingText: const Text("Mengunduh Data..."),
      // futureNavigator: futureCall(),
      navigator: const MainPage(),
    );
  }
}
