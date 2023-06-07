import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simak_uin_suka/view/sign_in_page.dart';

import '../theme.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  String? username;

  @override
  void dispose() {
    usernameController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  Future<void> flushBar(BuildContext context, message) async {
    // debugPrint(message);
    if (message != null) {
      await Flushbar(
        message: message,
        duration: const Duration(seconds: 2),
        flushbarPosition: FlushbarPosition.BOTTOM,
        backgroundColor: message == 'Password berhasil diubah'
            ? Colors.lightGreen
            : Colors.red,
      ).show(context);
    }
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

  Future<String?> changePassword() async {
    setState(() {
      username = usernameController.text;
    });
    try {
      var url = Uri.parse(
          'https://simak-back-end.cyclic.app/api/users/updatePassword/$username');
      var requestBody = json.encode({
        "oldPassword": oldPasswordController.text,
        "newPassword": newPasswordController.text,
        "confirmNewPassword": confirmNewPasswordController.text,
      });
      var response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: requestBody);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        debugPrint('Berhasil mengubah password!');
        return jsonData['message'];
      } else {
        debugPrint(
            'PUT request gagal dengan status code: ${response.statusCode}');
        return jsonData['message'];
      }
    } catch (e) {
      print('Something went wrong while change password');
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
              'Ubah Password',
              style: h1,
            ),
          ],
        ),
      );
    }

    Widget usernameTextField() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            Text('Username', style: h2),
            Container(
              margin: const EdgeInsets.only(top: 6),
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black)),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'Masukkan Username'),
              ),
            ),
          ],
        ),
      );
    }

    Widget oldPasswordTextField() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            Text('Password Lama', style: h2),
            Container(
              margin: const EdgeInsets.only(top: 6),
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black)),
              child: TextField(
                controller: oldPasswordController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'Masukkan Password Lama'),
              ),
            ),
          ],
        ),
      );
    }

    Widget newPasswordTextField() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            Text('Password Baru', style: h2),
            Container(
              margin: const EdgeInsets.only(top: 6),
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black)),
              child: TextField(
                controller: newPasswordController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'Masukkan Password Baru'),
              ),
            ),
          ],
        ),
      );
    }

    Widget confirmNewPasswordTextField() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            Text('Masukkan Ulang Password Baru', style: h2),
            Container(
              margin: const EdgeInsets.only(top: 6),
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black)),
              child: TextField(
                controller: confirmNewPasswordController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'Masukkan Ulang Password Baru'),
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
                  'Masukkan Informasi Login',
                  style: h1,
                ),
              ),
            ),
            usernameTextField(),
            oldPasswordTextField(),
            newPasswordTextField(),
            confirmNewPasswordTextField(),
            Container(
                margin: EdgeInsets.all(defaultMargin),
                child: ElevatedButton(
                    onPressed: () async {
                      await changePassword().then((value) async {
                        if (value == 'Password berhasil diubah') {
                          await flushBar(context, value);
                          return removeLocalData().whenComplete(
                            () => Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const SignInPage()),
                                (Route<dynamic> route) => false),
                          );
                        } else {
                          return flushBar(context, value);
                        }
                      });
                    },
                    child: const Text('Ubah Password')))
          ],
        ),
      ),
    );
  }
}
