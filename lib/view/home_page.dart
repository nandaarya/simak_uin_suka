import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simak_uin_suka/theme.dart';
import '../model/jadwalModel.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    getJadwal();
  }

  List<JadwalModel> jadwalList = [];

  Future<void> getJadwal() async {
    try {
      var response = await http.get(Uri.parse('https://simak-back-end.cyclic.app/api/' + 'jadwal'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData["data"]["classes"] != null) {
          List<dynamic> data = jsonData["data"]["classes"];
          setState(() {
            jadwalList.clear();
            for (var element in data) {
              JadwalModel jadwal = JadwalModel.fromJson(element);
              jadwalList.add(jadwal);
            }
          });
        }
      }
      for (var jadwal in jadwalList) {
        print('classCode: ${jadwal.classCode}');
        print('className: ${jadwal.className}');
        print('lecturer: ${jadwal.lecturer}');
        print('material: ${jadwal.material}');
        print('startedAt: ${jadwal.startedAt}');
        print('finishAt: ${jadwal.finishAt}');
        print('room: ${jadwal.room}');
        print('--------------');
      }

    } catch (e) {
      print("Something went wrong while getting jadwal");
      print(e);
    }
  }

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
                padding: const EdgeInsets.only(bottom: 320),
                  // controller: ScrollController(),
                  // physics: NeverScrollableScrollPhysics(),
                  // shrinkWrap: true, // Mengatur agar ukuran ListView menyesuaikan dengan item yang terlihat
                  // physics: ClampingScrollPhysics(), // Mengatur scroll dengan batas konten yang tersedia
                  itemCount: jadwalList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(defaultPadding),
                      margin: EdgeInsets.only(bottom: defaultMargin),
                      height: 160,
                      width: widthDevice,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            jadwalList[index].className,
                            style: h3b,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Dosen',
                                    style: h3,
                                  ),
                                  Text(
                                    'Materi',
                                    style: h3,
                                  ),
                                  Text(
                                    'Mulai',
                                    style: h3,
                                  ),
                                  Text(
                                    'Selesai',
                                    style: h3,
                                  ),
                                  Text(
                                    'Ruang',
                                    style: h3,
                                  ),
                                  Text(
                                    'Status',
                                    style: h3,
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                children: [
                                  Text(
                                    ':',
                                    style: h3,
                                  ),
                                  Text(
                                    ':',
                                    style: h3,
                                  ),
                                  Text(
                                    ':',
                                    style: h3,
                                  ),
                                  Text(
                                    ':',
                                    style: h3,
                                  ),
                                  Text(
                                    ':',
                                    style: h3,
                                  ),
                                  Text(
                                    ':',
                                    style: h3,
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    jadwalList[index].lecturer,
                                    style: h3,
                                  ),
                                  Text(jadwalList[index].material,
                                    style: h3,
                                  ),
                                  Text(jadwalList[index].startedAt,
                                    style: h3,
                                  ),
                                  Text(jadwalList[index].finishAt,
                                    style: h3,
                                  ),
                                  Text(jadwalList[index].room,
                                    style: h3,
                                  ),
                                  Text(
                                    'Hadir',
                                    style: h3,
                                  )
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
        children: [
          header(),
          const SizedBox(height: 24),
          user(),
          const SizedBox(height: 24),
          jadwal()
        ],
      ),
    );
  }
}
