import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simak_uin_suka/view/profile_page.dart';

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

  String? username;
  String? name;
  String? email;
  // ignore: non_constant_identifier_names
  String? nim_nip;
  String? role;

  final emailKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  Future<void> flushBar(BuildContext context, message) async {
    // debugPrint(message);
    if (message != null) {
      await Flushbar(
        message: message,
        duration: const Duration(seconds: 2),
        flushbarPosition: FlushbarPosition.BOTTOM,
        backgroundColor: message == 'Data user berhasil diubah'
            ? Colors.lightGreen
            : Colors.red,
      ).show(context);
    }
  }

  Future<void> getLocalData() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
      name = prefs.getString('name');
      email = prefs.getString('email');
      nim_nip = prefs.getString('nim_nip');
      role = prefs.getString('role');
      nameController = TextEditingController(text: name);
      emailController = TextEditingController(text: email);
      nimnipController = TextEditingController(text: nim_nip);
    });
  }

  Future<String?> changeUserData() async {
    try {
      var url =
          Uri.parse('https://simak-back-end.cyclic.app/api/users/$username');
      var requestBody = json.encode({
        "name": nameController.text,
        "email": emailController.text,
        "nim_nip": nimnipController.text,
      });
      var response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: requestBody);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', emailController.text);
          prefs.setString('name', nameController.text);
          prefs.setString('nim_nip', nimnipController.text);

          debugPrint("Data email lokal: ${prefs.getString('email')}");
          debugPrint("Data nama lokal: ${prefs.getString('name')}");
          debugPrint("Data nim_nip lokal: ${prefs.getString('nim_nip')}");
        } catch (e) {
          debugPrint('Error accessing SharedPreferences: $e');
        }
        debugPrint('Berhasil mengubah data User!');
        return jsonData['message'];
      } else {
        debugPrint(
            'PUT request gagal dengan status code: ${response.statusCode}');
        return jsonData['message'];
      }
    } catch (e) {
      print('Something went wrong while change user data');
      print(e);
    }
    return null;
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
              child: Form(
                key: emailKey,
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan email Anda!';
                    }
                    if (!value.contains('@') ||
                        !value.endsWith('uin-suka.ac.id')) {
                      return 'Gunakan email UIN Sunan Kalijaga!';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Email Mahasiswa/Dosen'),
                ),
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
                    onPressed: () async {
                      if (emailKey.currentState!.validate()) {
                        await changeUserData()
                            .then((value) => flushBar(context, value));
                        if (!mounted) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()),
                        );
                      }
                    },
                    child: const Text('Simpan Data')))
          ],
        ),
      ),
    );
  }
}
