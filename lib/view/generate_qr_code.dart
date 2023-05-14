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
  TextEditingController kelasController = TextEditingController();
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(defaultMargin),
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pilih Kelas', style: h2,),
              TextField(
                controller: kelasController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Masukkan Kelas Perkuliahan'),
              ),
              const SizedBox(height: 8,),
              Text('Materi Perkuliahan', style: h2,),
              TextField(
                controller: materiController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Masukkan Materi Perkuliahan'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        DatePicker.showDateTimePicker(context,
                            showTitleActions: true,
                            // Without maxTime
                            minTime: DateTime.now(), onChanged: (date) {
                        }, onConfirm: (date) {
                          setState(() {
                            startTime = date;
                          });
                        }, currentTime: DateTime.now(), locale: LocaleType.id);
                      },
                      child: const Text(
                        'Pilih Waktu Mulai',
                        style: TextStyle(color: Colors.blue),
                      )),
                  const Text('-'),
                  TextButton(
                      onPressed: () {
                        DatePicker.showDateTimePicker(context,
                            showTitleActions: true,
                            // Without maxTime
                            minTime: DateTime.now(), onChanged: (date) {
                            }, onConfirm: (date) {
                              setState(() {
                                endTime = date;
                              });
                            }, currentTime: DateTime.now(), locale: LocaleType.id);
                      },
                      child: const Text(
                        'Pilih Waktu Selesai',
                        style: TextStyle(color: Colors.blue),
                      )),
                ],
              ),
              Text('Waktu mulai: ', style: h3.copyWith(fontSize: 14),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(DateFormat("EEEE, d MMMM yyyy ", "id_ID").format(startTime), style: h3.copyWith(fontSize: 14),),
                  Text(DateFormat("HH:mm WIB", "id_ID").format(startTime), style: h3.copyWith(fontSize: 14),),
                ],
              ),
              const SizedBox(height: 8,),
              Text('Waktu selesai: ', style: h3.copyWith(fontSize: 14),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(DateFormat("EEEE, d MMMM yyyy ", "id_ID").format(endTime), style: h3.copyWith(fontSize: 14),),
                  Text(DateFormat("HH:mm WIB", "id_ID").format(endTime), style: h3.copyWith(fontSize: 14),),
                ],
              ),
              const SizedBox(height: 8,),
              Text('Masukkan Ruang Perkuliahan', style: h2,),
              TextField(
                controller: ruangController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ruang Perkuliahan'),
              ),
              const SizedBox(height: 8,),
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
                    child: const Text('ATUR JADWAL')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
