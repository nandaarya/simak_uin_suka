import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import '../theme.dart';
import 'qr_image.dart';

class GenerateQRCode extends StatefulWidget {
  const GenerateQRCode({super.key});

  @override
  GenerateQRCodeState createState() => GenerateQRCodeState();
}

class GenerateQRCodeState extends State<GenerateQRCode> {
  TextEditingController materiController = TextEditingController();
  TextEditingController ruangController = TextEditingController();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  @override
  void dispose() {
    materiController.dispose();
    ruangController.dispose();
    super.dispose();
  }

  // String dateIdFormat(date) {
  //   initializeDateFormatting('id_ID', null).then((_) {
  //     var formatter = DateFormat('dd MMMM y', 'id_ID');
  //     String formattedDate = formatter.format(date).toString() ;
  //     return formattedDate;
  //   });
  //   return "Atur Waktu";
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atur Jadwal Kelas'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Materi Perkuliahan'),
            Container(
              child: TextField(
                controller: materiController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Masukkan Materi Perkuliahan'),
              ),
            ),
            TextButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      // Without maxTime
                      minTime: DateTime.now(), onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    setState(() {
                      startTime = date;
                    });
                    print('confirm $date');
                  }, currentTime: DateTime.now(), locale: LocaleType.id);
                },
                child: const Text(
                  'Pilih Waktu Mulai',
                  style: TextStyle(color: Colors.blue),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Waktu mulai: '),
                Text(DateFormat(
                    "EEEE, d MMMM yyyy","id_ID"
                ).format(startTime)),
                Text(DateFormat(
                    "hh:mm WIB","id_ID"
                ).format(startTime)),
                // SizedBox(width: 8,),
                // Text(DateFormat.Hm().format(startTime)),
              ],
            ),
            TextButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      // Without maxTime
                      minTime: DateTime.now(), onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {
                        setState(() {
                          endTime = date;
                        });
                        print('confirm $date');
                      }, currentTime: DateTime.now(), locale: LocaleType.id);
                },
                child: const Text(
                  'Pilih Waktu Selesai',
                  style: TextStyle(color: Colors.blue),
                )),
            Text(endTime.toString()),
            const Text('Masukkan Ruang Perkuliahan'),
            Container(
              child: TextField(
                controller: ruangController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Ruang Perkuliahan'),
              ),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) =>
                            QRImage(qrData: materiController.text)),
                      ),
                    );
                  },
                  child: const Text('GENERATE QR CODE')),
            ),
          ],
        ),
      ),
    );
  }
}
