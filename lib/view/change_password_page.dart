import 'package:flutter/material.dart';

import '../theme.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
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
                  '',
                  style: h1,
                ),
              ),
            ),
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
