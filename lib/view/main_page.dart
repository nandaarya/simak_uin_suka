import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/services.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'package:simak_uin_suka/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      const HomePage(),
      const ProfilePage(),
    ];

    return WillPopScope(
      onWillPop: () async {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return false;
      },
      child: Scaffold(
        body: widgets[currentIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.green,
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: ConvexAppBar(
            style: TabStyle.textIn,
            backgroundColor: primaryColor,
            items: const [
              TabItem(icon: Icons.home, title: 'Beranda'),
              TabItem(icon: Icons.person, title: 'Profil'),
            ],
            initialActiveIndex: 0,
            onTap: (int i) {
              setState(() {
                currentIndex = i;
              });
            }),
      ),
    );
  }
}
