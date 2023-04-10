import 'package:flutter/material.dart';
import 'package:simak_uin_suka/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height - 50;

    Widget header() {
      return Container(
        alignment: AlignmentDirectional.centerStart,
        height: 100,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            )),
        child: Text(
          'Beranda',
          style: h1,
        ),
      );
    }

    Widget user() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pengguna',
              style: h2,
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.all(defaultPadding),
              height: 60,
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 40,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nanda Arya Putra',
                        style: h3,
                      ),
                      Text(
                        '21106050048',
                        style: h3,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget jadwal() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Semester Genap TA 2022/2023',
              style: h2,
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: heightDevice,
              child: ListView.builder(
                // controller: ScrollController(),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(defaultPadding),
                      margin: EdgeInsets.only(
                        bottom: defaultMargin
                      ),
                      height: 100,
                      width: widthDevice,
                      decoration: BoxDecoration(
                          color: primaryColor, borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          Text('PSD'),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: ListView(
        children: [header(), const SizedBox(height: 24), user(), const SizedBox(height: 24), jadwal()],
      ),
    );
  }
}
