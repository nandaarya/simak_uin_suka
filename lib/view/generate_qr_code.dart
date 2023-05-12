import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atur Jadwal Kelas'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: materiController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Materi Perkuliahan'),
            ),
          ),
          Row(
            children: [
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
              Text(startTime.toString())
            ],
          ),
          Row(
            children: [
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
              Text(endTime.toString())
            ],
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: ruangController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Ruang Perkuliahan'),
            ),
          ),
          ElevatedButton(
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
        ],
      ),
    );
  }
}
