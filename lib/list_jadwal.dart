import 'package:flutter/material.dart';
import 'package:jadwal_sholat_app/model/ResponseJadwal.dart';
import 'package:jadwal_sholat_app/text_style.dart';

class ListJadwal extends StatelessWidget {
  ResponseJadwal data;

  ListJadwal(this.data);

  Widget containerWaktu(String waktu, String jam) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        height: 70.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5.0)],
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xff3f51b5), Color(0xff607d8b)])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // agar rengan kgk nyatu
          children: <Widget>[
            Text(waktu, style: styleListText),
            Text(jam, style: styleListText)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        containerWaktu(
            'subuh', data.results.datetime[0].times.Fajr.toUpperCase()),
        // knp ada angka 0 nya(date time itu array)
        containerWaktu(
            'Dhuzur', data.results.datetime[0].times.Dhuhr.toUpperCase()),
        containerWaktu(
            'Ashar', data.results.datetime[0].times.Asr.toUpperCase()),
        containerWaktu(
            'Maghrib', data.results.datetime[0].times.Maghrib.toUpperCase()),
        containerWaktu(
            'Isya', data.results.datetime[0].times.Isha.toUpperCase()),
      ],
    );
  }
}
