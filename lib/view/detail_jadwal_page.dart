import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
    return Column(
      children: [
        QrImage(
          data: classCode,
          size: 300,
        ),
        Text(className),
        Text(lecturer),
        Text(material),
        Text(startedAt),
        Text(finishAt),
        Text(room)
      ],
    );
  }
}
