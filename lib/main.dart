import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        // initialRoute: '/',
        // routes: {
        //   '/': (context) => SplashPage(),
        //   '/signIn_page': (context) => SignInPage(),
        //   '/main_page': (context) => MainPage(),
        //   '/nasabah_search_page': (context) => CustomerSearchPage(),
        //   '/news_search_page': (context) => NewsSearchPage(),
        // }
        );
  }
}