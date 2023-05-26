import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
            Text('Kode Kelas: $qrData', style: h2,),
          ],
        ),
      ),
    );
  }
}