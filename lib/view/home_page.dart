import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simak_uin_suka/theme.dart';
import 'package:simak_uin_suka/view/detail_jadwal_page.dart';
import '../model/jadwalModel.dart';
import 'package:http/http.dart' as http;

import '../model/presensiModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<JadwalModel> jadwalList = [];
  List<PresensiModel> presensiList = [];
  bool isLoading = true;
  String? name;
  // ignore: non_constant_identifier_names
  String? nim_nip;

  static const loading = Center(
      heightFactor: 2.0,
      child: SpinKitCircle(
        color: Colors.grey,
        size: 150,
      ));

  @override
  void initState() {
    super.initState();
    getLocalData();
    getJadwal();
    getPresensi();
  }

  Future<void> getLocalData() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      nim_nip = prefs.getString('nim_nip');
    });
  }

  Future<void> getJadwal() async {
    try {
      var response = await http
          .get(Uri.parse('https://simak-back-end.cyclic.app/api/' + 'jadwal'));
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
      setState(() {
        isLoading = false;
      });
      // for (var jadwal in jadwalList) {
      //   print('classCode: ${jadwal.classCode}');
      //   print('className: ${jadwal.className}');
      //   print('lecturer: ${jadwal.lecturer}');
      //   print('material: ${jadwal.material}');
      //   print('startedAt: ${jadwal.startedAt}');
      //   print('finishAt: ${jadwal.finishAt}');
      //   print('room: ${jadwal.room}');
      //   print('--------------');
      // }
    } catch (e) {
      print("Something went wrong while getting jadwal");
      print(e);
    }
  }

  Future<void> getPresensi() async {
    try {
      var response = await http.get(
          Uri.parse('https://simak-back-end.cyclic.app/api/' + 'presensi'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData["data"]["attendances"] != null) {
          List<dynamic> data = jsonData["data"]["attendances"];
          setState(() {
            presensiList.clear();
            for (var element in data) {
              PresensiModel presensi = PresensiModel.fromJson(element);
              presensiList.add(presensi);
            }
          });
        }
      }
      // for (var presensi in presensiList) {
      //   print('nim: ${presensi.nim}');
      //   print('classCode: ${presensi.classCode}');
      //   print('status: ${presensi.status}');
      //   print('--------------');
      // }
    } catch (e) {
      print("Something went wrong while getting presensi");
      print(e);
    }
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
        padding: EdgeInsets.only(top: safePadding, left: defaultMargin, right: defaultMargin),
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
                        name ?? 'Nama tidak ada',
                        style: h3,
                      ),
                      Text(
                        nim_nip ?? 'NIM/NIP tidak ada',
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
              child: RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await getJadwal();
                  await getPresensi();
                },
                child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 320),
                    itemCount: jadwalList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailJadwalPage(
                                    classCode: jadwalList[index].classCode,
                                    className: jadwalList[index].className,
                                    lecturer: jadwalList[index].lecturer,
                                    material: jadwalList[index].material,
                                    startedAt: jadwalList[index].startedAt,
                                    finishAt: jadwalList[index].finishAt,
                                    room: jadwalList[index].room)),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(defaultPadding),
                          margin: EdgeInsets.only(bottom: defaultMargin),
                          width: widthDevice,
                          decoration: BoxDecoration(
                              color: presensiList.any((presensi) =>
                                      presensi.classCode ==
                                      jadwalList[index].classCode)
                                  ? Colors.green
                                  : primaryColor,
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
                                      Text(
                                        jadwalList[index].material,
                                        style: h3,
                                      ),
                                      Text(
                                        jadwalList[index].startedAt,
                                        style: h3,
                                      ),
                                      Text(
                                        jadwalList[index].finishAt,
                                        style: h3,
                                      ),
                                      Text(
                                        jadwalList[index].room,
                                        style: h3,
                                      ),
                                      Text(
                                        presensiList.any((presensi) =>
                                                presensi.classCode ==
                                                jadwalList[index].classCode)
                                            ? 'Hadir'
                                            : 'Tidak Hadir',
                                        style: h3,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          header(),
          const SizedBox(height: 24),
          user(),
          const SizedBox(height: 24),
          isLoading ? loading : jadwal()
        ],
      ),
    );
  }
}
