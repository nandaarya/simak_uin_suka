import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import '../theme.dart';
import 'qr_image.dart';
import 'package:http/http.dart' as http;

  fetchData() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  if (response.statusCode == 200) {
    var users = jsonDecode(response.body);
    var filteredUsers = users.where((user) => user["name"] != null).toList();
    var names = filteredUsers.map((user) => user["name"]).toList();
    print(names);
  } else {
    print('Failed to fetch data');
  }

  // if (response.statusCode == 200) {
  //   final List<dynamic> data = json.decode(response.body);
  //   return List<String>.from(data);
  // } else {
  //   throw Exception('Failed to fetch data from API');
  // }

  // if (response.statusCode == 200) {
  //   final jsonResponse = json.decode(response.body);
  //   final List<dynamic> data = jsonResponse['id']; // Ganti 'key' dengan key yang ingin Anda ambil
  //   return List<String>.from(data);
  // } else {
  //   throw Exception('Failed to load data');
  // }
}

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
  String? selectedKelas;
  List<String> dropdownKelas = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    // fetchData().then((data) {
    //   setState(() {
    //     dropdownKelas = data;
    //   });
    // });
  }

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
              Text(
                'Pilih Kelas',
                style: h2,
              ),
              TextField(
                controller: kelasController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Masukkan Kelas Perkuliahan'),
              ),
              const SizedBox(height: 8,),
              // DropdownButton<String>(
              //   value: selectedKelas,
              //   items: dropdownKelas.map((String item) {
              //     return DropdownMenuItem<String>(
              //       value: item,
              //       child: Text(item),
              //     );
              //   }).toList(),
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       selectedKelas = newValue;
              //     });
              //   },
              // ),
              const SizedBox(height: 8,),
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
