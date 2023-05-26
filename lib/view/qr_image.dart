import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:simak_uin_suka/view/main_page.dart';

import '../theme.dart';

class QRImage extends StatelessWidget {
  final String qrData;
  const QRImage({super.key,required this.qrData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Presensi'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            QrImage(
              data: qrData,
              size: 300,
            ),
            Container(
              margin: EdgeInsets.all(defaultMargin),
              child: Column(
                children: [
                  Text('Kode Kelas: ', style: h2,),
                  Text(qrData, style: h2, textAlign: TextAlign.center,),
                ],
              ),
            ),
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