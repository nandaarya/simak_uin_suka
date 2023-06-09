import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:simak_uin_suka/view/main_page.dart';
import 'package:simak_uin_suka/view/splash_page.dart';


void main() async {
  await initializeDateFormatting('id_ID', null).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
        title: 'SIMAK UIN SUKA',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        debugShowCheckedModeBanner: false,
        // home: const MainPage(),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
        //   '/signIn_page': (context) => SignInPage(),
          '/main_page': (context) => const MainPage(),
        }
        );
  }
}