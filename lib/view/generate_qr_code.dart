import 'package:flutter/material.dart';
import 'qr_image.dart';

class GenerateQRCode extends StatefulWidget {
  const GenerateQRCode({super.key});

  @override
  GenerateQRCodeState createState() => GenerateQRCodeState();
}

class GenerateQRCodeState extends State<GenerateQRCode> {
  TextEditingController materiController = TextEditingController();
  final _timeC = TextEditingController();
  DateTime selectedDate = DateTime.now();
  ///Time
  TimeOfDay timeOfDay = TimeOfDay.now();

  Future displayTimePicker(BuildContext context) async {
    var time = await showTimePicker(
        context: context,
        initialTime: timeOfDay);

    if (time != null) {
      setState(() {
        _timeC.text = "${time.hour}:${time.minute}";
      });
    }
  }

  @override
  void dispose() {
    materiController.dispose();
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
                  border: OutlineInputBorder(), labelText: 'Enter your URL'),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                showDatePicker(
                    context: this.context,
                    initialDate: selectedDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    initialDatePickerMode: DatePickerMode.year,
                    cancelText: "cancel",
                    confirmText: "confirm")
                    .then((value) {
                  if (value != null) {
                    print(value);
                    setState(() {
                      selectedDate = value;
                    });
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, elevation: 0),
              child: const Icon(Icons.calendar_today_outlined,
                  color: Colors.grey)),
          ElevatedButton(onPressed: () => displayTimePicker(context), child: const Text("Pick Time")),
    TextFormField(
    controller: _timeC,
    decoration: const InputDecoration(
    labelText: 'Time picker', border: OutlineInputBorder()),),
          ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => QRImage(qrData: materiController.text)),
                  ),
                );
              },
              child: const Text('GENERATE QR CODE')),
        ],
      ),
    );
  }
}