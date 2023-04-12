import 'package:flutter/material.dart';
import 'package:simak_uin_suka/theme.dart';

class AturJadwalPage extends StatefulWidget {
  const AturJadwalPage({Key? key}) : super(key: key);

  @override
  State<AturJadwalPage> createState() => _AturJadwalPageState();
}

class _AturJadwalPageState extends State<AturJadwalPage> {

  @override
  Widget build(BuildContext context) {

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
          'Atur Jadwal',
          style: h1,
        ),
      );
    }

    Widget aturjadwal() {
      return Column(
        children: [
          Text('Kelas'),
          Text('Pertemuan ke'),
          Text('Materi'),
          Text('Tanggal'),
          Text('Mulai'),
          Text('Selesai')
        ],
      );
    }

    return Scaffold(
      body: ListView(
        // physics: NeverScrollableScrollPhysics(),
        children: [header(), const SizedBox(height: 24), aturjadwal()],
      ),
    );
  }
}

