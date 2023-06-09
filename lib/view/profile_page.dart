import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simak_uin_suka/theme.dart';
import 'package:simak_uin_suka/view/change_data_page.dart';
import 'package:simak_uin_suka/view/change_password_page.dart';
import 'package:simak_uin_suka/view/sign_in_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? name;
  // ignore: non_constant_identifier_names
  String? nim_nip;
  String? role;

  @override
  void initState() {
    getLocalData();
    super.initState();
  }

  Future<void> getLocalData() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      nim_nip = prefs.getString('nim_nip');
      role = prefs.getString('role');
    });
  }

  Future<void> removeLocalData() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('password');
    await prefs.remove('email');
    await prefs.remove('name');
    await prefs.remove('nim_nip');
    await prefs.remove('role');
  }

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding.top;

    Widget header() {
      return Container(
        alignment: AlignmentDirectional.centerStart,
        height: 100 + safePadding,
        width: double.infinity,
        padding: EdgeInsets.only(
            top: safePadding, left: defaultMargin, right: defaultMargin),
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            )),
        child: Text(
          'Profil',
          style: h1,
        ),
      );
    }

    Widget profile() {
      return Container(
        height: 200,
        padding: EdgeInsets.all(defaultPadding),
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Icon(
              Icons.account_circle,
              size: 100,
            ),
            Text(
              name ?? 'Nama tidak ada',
              style: h2,
            ),
            Text(
              nim_nip ?? 'NIM / NIP tidak ada',
              style: h2,
            ),
            Text(
              role == 'mahasiswa' ? 'User Mahasiswa' : 'User Dosen',
              style: h2,
            )
          ],
        ),
      );
    }

    Widget setting() {
      return Container(
        height: 150,
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangeDataPage()));
              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Ubah Data',
                        style: h2,
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 1,
                    color: primaryColor,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePasswordPage()));
              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Ubah Kata Sandi',
                        style: h2,
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 1,
                    color: primaryColor,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.infoReverse,
                  borderSide: const BorderSide(color: Colors.green, width: 2),
                  width: double.infinity * 0.9,
                  buttonsBorderRadius:
                      const BorderRadius.all(Radius.circular(2)),
                  headerAnimationLoop: false,
                  animType: AnimType.bottomSlide,
                  title: 'INFO',
                  desc: 'Apakah anda yakin ingin keluar?',
                  showCloseIcon: true,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    removeLocalData().whenComplete(() => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInPage())));
                  },
                ).show();
              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Logout',
                        style: h2.copyWith(color: Colors.red),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 1,
                    color: primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        // physics: NeverScrollableScrollPhysics(),
        children: [
          header(),
          const SizedBox(height: 24),
          profile(),
          const SizedBox(height: 24),
          setting()
        ],
      ),
    );
  }
}
