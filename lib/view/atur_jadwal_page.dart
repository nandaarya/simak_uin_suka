import 'package:flutter/material.dart';
import 'package:simak_uin_suka/theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AturJadwalPage extends StatefulWidget {
  const AturJadwalPage({Key? key}) : super(key: key);

  @override
  State<AturJadwalPage> createState() => _AturJadwalPageState();
}

class _AturJadwalPageState extends State<AturJadwalPage> {
  // List kelas = []; //untuk menampung data dari API
  // String? selectedValue; //untuk menyimpan nilai yang dipilih
  //
  //
  // Future<String> getDataKelas() async {
  //   var response = await http.get(
  //       Uri.parse("https://dummyjson.com/products/1")); //ubah URL dengan URL API yang ingin diambil datanya
  //   setState(() {
  //     var dataJSON = json.decode(response.body);
  //     kelas = dataJSON["products"]; //ubah "items" dengan key atau nama array yang menyimpan data dari API
  //   });
  //   return "Success!";
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   getDataKelas();
  // }

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
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kelas', style: h2,),
            Text('Pertemuan ke', style: h2,),
            Text('Materi', style: h2,),
            Text('Tanggal', style: h2,),
            Text('Mulai', style: h2,),
            Text('Selesai', style: h2,)
          ],
        ),
      );
    }

    // Widget daftarkelas() {
    //   return DropdownButton(
    //     hint: Text("Select item"), //text yang muncul pada DropdownButton ketika belum ada item yang dipilih
    //     value: selectedValue,
    //     onChanged: (newValue) {
    //       setState(() {
    //         selectedValue = newValue;
    //       });
    //     },
    //     items: kelas.map((item) {
    //       return DropdownMenuItem(
    //         value: item['id'].toString(),
    //         child: Text(item['title']), //ubah "id" dengan key atau nama yang ingin dijadikan nilai pada DropdownMenuItem
    //       );
    //     }).toList(),
    //   );
    // }

    return Scaffold(
      body: ListView(
        // physics: NeverScrollableScrollPhysics(),
        children: [header(), const SizedBox(height: 24), aturjadwal()],
      ),
    );
  }
}

