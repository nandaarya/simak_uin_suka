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
              'Aktivitas Semester 4 TA 2022/2023',
              style: h2,
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: heightDevice,
              child: ListView.builder(
                // controller: ScrollController(),
                // physics: NeverScrollableScrollPhysics(),
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(defaultPadding),
                      margin: EdgeInsets.only(
                        bottom: defaultMargin
                      ),
                      height: 160,
                      width: widthDevice,
                      decoration: BoxDecoration(
                          color: primaryColor, borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Perancangan Algoritma dan Pemrograman A', style: h3b,),
                          const SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Dosen', style: h3,),
                                  Text('Materi', style: h3,),
                                  Text('Mulai', style: h3,),
                                  Text('Selesai', style: h3,),
                                  Text('Ruang', style: h3,),
                                  Text('Status', style: h3,)
                                ],
                              ),
                              const SizedBox(width: 8,),
                              Column(
                                children: [
                                  Text(':', style: h3,),
                                  Text(':', style: h3,),
                                  Text(':', style: h3,),
                                  Text(':', style: h3,),
                                  Text(':', style: h3,),
                                  Text(':', style: h3,)
                                ],
                              ),
                              const SizedBox(width: 8,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Dwi Otik Kurniawati, M.Eng.', style: h3,),
                                  Text('Hello World C++', style: h3,),
                                  Text('09:38:00 WIB', style: h3,),
                                  Text('09:38:00 WIB', style: h3,),
                                  Text('FST 404', style: h3,),
                                  Text('Hadir', style: h3,)
                                ],
                              ),
                            ],
                          ),

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
        physics: const NeverScrollableScrollPhysics(),
        children: [header(), const SizedBox(height: 24), user(), const SizedBox(height: 24), jadwal()],
      ),
    );
  }
}
