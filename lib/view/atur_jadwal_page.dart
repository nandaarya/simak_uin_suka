import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:simak_uin_suka/model/jadwalModel.dart';
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

  static const List<String> classes = <String>[
    'Metode Pengembangan Perangkat Lunak A',
    'Interaksi Manusia dan Komputer B',
    'Perancangan Algoritma dan Pemrograman A',
    'Grafis dan Visualisasi A',
    'Perancangan Struktur Data A',
    'Rekayasa Perangkat Lunak A',
    'Basis Data A',
  ];
  String dropdownClassValue = classes.first;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    materiController.dispose();
    ruangController.dispose();
    super.dispose();
  }

  Future<String?> postJadwal(JadwalModel jadwal) async {
    try {
      var url = Uri.parse('https://simak-back-end.cyclic.app/api/' + 'jadwal');
      var requestBody = jadwalModelToJson(jadwal);
      var response = await http.post(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, body: requestBody);
      if (response.statusCode == 201) {
        var jsonData = json.decode(response.body);
        // Proses response atau lakukan operasi lain setelah POST berhasil
        var classCode = jsonData['data']['classCode'];
        print('Jadwal berhasil dipost');
        print(jsonData);
        return classCode;
      } else {
        print('POST request gagal dengan status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Something went wrong while posting jadwal');
      print(e);
    }
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
          // padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pilih Kelas',
                style: h2,
              ),
              DropdownButton<String>(
                isExpanded: true,
                value: dropdownClassValue,
                // icon: const Icon(Icons.arrow_downward),
                elevation: 8,
                style: h3b,
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                items: classes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownClassValue = value!;
                    print(dropdownClassValue);
                  });
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Materi Perkuliahan',
                style: h2,
              ),
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
                            minTime: DateTime.now(),
                            onChanged: (date) {}, onConfirm: (date) {
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
                            minTime: DateTime.now(),
                            onChanged: (date) {}, onConfirm: (date) {
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
              Text(
                'Waktu mulai: ',
                style: h3.copyWith(fontSize: 14),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat("EEEE, d MMMM yyyy ", "id_ID").format(startTime),
                    style: h3.copyWith(fontSize: 14),
                  ),
                  Text(
                    DateFormat("HH:mm WIB", "id_ID").format(startTime),
                    style: h3.copyWith(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Waktu selesai: ',
                style: h3.copyWith(fontSize: 14),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat("EEEE, d MMMM yyyy ", "id_ID").format(endTime),
                    style: h3.copyWith(fontSize: 14),
                  ),
                  Text(
                    DateFormat("HH:mm WIB", "id_ID").format(endTime),
                    style: h3.copyWith(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Masukkan Ruang Perkuliahan',
                style: h2,
              ),
              TextField(
                controller: ruangController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ruang Perkuliahan'),
              ),
              const SizedBox(
                height: 8,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      JadwalModel jadwal = JadwalModel(
                        classCode: '',
                        className: dropdownClassValue,
                        lecturer: 'Dosen',
                        material: materiController.text,
                        startedAt: startTime.toString(),
                        finishAt: endTime.toString(),
                        room: ruangController.text,
                      );
                      postJadwal(jadwal).then((value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) =>
                                QRImage(qrData: value!)),
                          ),
                        );
                      });
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
