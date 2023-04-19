import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:simak_uin_suka/view/main_page.dart';
import 'package:simak_uin_suka/view/splash_page.dart';


void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();

  runApp(const MyApp());
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
          '/': (context) => SplashPage(),
        //   '/signIn_page': (context) => SignInPage(),
          '/main_page': (context) => MainPage(),
        //   '/nasabah_search_page': (context) => CustomerSearchPage(),
        //   '/news_search_page': (context) => NewsSearchPage(),
        }
        );
  }
}