import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme.dart';

class ChangeDataPage extends StatefulWidget {
  const ChangeDataPage({Key? key}) : super(key: key);

  @override
  State<ChangeDataPage> createState() => _ChangeDataPageState();
}

class _ChangeDataPageState extends State<ChangeDataPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nimnipController = TextEditingController();

  String? name;
  String? email;
  // ignore: non_constant_identifier_names
  String? nim_nip;
  String? role;

  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  Future<void> getLocalData() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      email = prefs.getString('email');
      nim_nip = prefs.getString('nim_nip');
      role = prefs.getString('role');
      nameController = TextEditingController(text: name);
      emailController = TextEditingController(text: email);
      nimnipController = TextEditingController(text: nim_nip);
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height - 50;
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
            Text(
              'Ubah Data',
              style: h1,
            ),
          ],
        ),
      );
    }

    Widget nameTextField() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            Text('Nama', style: h2),
            Container(
              margin: const EdgeInsets.only(top: 6),
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black)),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'Nama Mahasiswa/Dosen'),
              ),
            ),
          ],
        ),
      );
    }

    Widget emailTextField() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            Text('Email', style: h2),
            Container(
              margin: const EdgeInsets.only(top: 6),
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black)),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'Email Mahasiswa/Dosen'),
              ),
            ),
          ],
        ),
      );
    }

    // ignore: non_constant_identifier_names
    Widget nim_nipTextField() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            Text('NIM/NIP', style: h2),
            Container(
              margin: const EdgeInsets.only(top: 6),
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black)),
              child: TextField(
                controller: nimnipController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'NIM Mahasiswa / NIP Dosen'),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SizedBox(
        height: heightDevice,
        width: widthDevice,
        child: ListView(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            header(),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                padding: EdgeInsets.only(top: defaultPadding),
                child: Text(
                  role == 'mahasiswa' ? 'Data Mahasiswa' : 'Data Dosen',
                  style: h1,
                ),
              ),
            ),
            nameTextField(),
            emailTextField(),
            nim_nipTextField(),
            Container(
                margin: EdgeInsets.all(defaultMargin),
                child: ElevatedButton(
                    onPressed: () {}, child: const Text('Simpan Data')))
          ],
        ),
      ),
    );
  }
}
