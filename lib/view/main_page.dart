import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/services.dart';
import 'package:simak_uin_suka/view/atur_jadwal_page.dart';
import 'package:simak_uin_suka/view/scan_qr_code.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'package:simak_uin_suka/theme.dart';
import 'package:page_transition/page_transition.dart';

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
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //FAB1 fro Mahasiswa User
            FloatingActionButton(
              heroTag: 'FAB1',
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const QRScanner(),
                        type: PageTransitionType.bottomToTop));
              },
              backgroundColor: secondaryColor,
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
            //FAB2 fro Dosen User
            FloatingActionButton(
              heroTag: 'FAB2',
              // GenerateQRCode -> Atur Jadwal
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const GenerateQRCode(),
                        type: PageTransitionType.bottomToTop));
              },
              backgroundColor: secondaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
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
