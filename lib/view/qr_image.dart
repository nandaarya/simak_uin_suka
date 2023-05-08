import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
        child: QrImage(
          data: qrData,
          size: 300,
          // You can include embeddedImageStyle Property if you
          //wanna embed an image from your Asset folder
          // embeddedImageStyle: QrEmbeddedImageStyle(
          //   size: const Size(
          //     100,
          //     100,
          //   ),
          // ),
        ),
      ),
    );
  }
}