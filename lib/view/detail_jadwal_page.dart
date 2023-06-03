import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../theme.dart';
import 'main_page.dart';

class DetailJadwalPage extends StatelessWidget {
  final String classCode,
      className,
      lecturer,
      material,
      startedAt,
      finishAt,
      room;
  const DetailJadwalPage(
      {super.key,
      required this.classCode,
      required this.className,
      required this.lecturer,
      required this.material,
      required this.startedAt,
      required this.finishAt,
      required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Jadwal'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(defaultMargin),
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Text('QR Presensi', style: h2,),
            const SizedBox(height: 16,),
            QrImage(
              data: classCode,
              size: 300,
            ),
            const SizedBox(height: 16,),
            Column(
              children: [
                Text(
                  className,
                  style: h3b,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
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
                      ],
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lecturer,
                          style: h3,
                        ),
                        Text(
                          material,
                          style: h3,
                        ),
                        Text(
                          startedAt,
                          style: h3,
                        ),
                        Text(
                          finishAt,
                          style: h3,
                        ),
                        Text(
                          room,
                          style: h3,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainPage()),
                );
              },
              child: const Text('Kembali ke Beranda'),
            ),
          ],
        ),
      ),
    );
  }
}
