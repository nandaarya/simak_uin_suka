import 'package:flutter/material.dart';

import '../theme.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController? usernameController;
  TextEditingController? oldPasswordController;
  TextEditingController? newPasswordController;
  TextEditingController? confirmNewPasswordController;

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
                    onPressed: () {}, child: const Text('Ubah Password')))
          ],
        ),
      ),
    );
  }
}
