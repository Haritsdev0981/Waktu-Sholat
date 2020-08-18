import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jadwal_sholat_app/header_content.dart';
import 'package:jadwal_sholat_app/list_jadwal.dart';
import 'package:jadwal_sholat_app/model/ResponseJadwal.dart'; // as http untuk memunculkan klo gk ada itu gk muncul

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHomeScreen(),
  ));
}

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  TextEditingController _locationControler = TextEditingController();

  Future<ResponseJadwal> getJadwal({String location}) async {
    String url =
        'https://api.pray.zone/v2/times/today.json?city=$location&school=9';
    final response = await http.get(url);
    final JsonResponse =
        json.decode(response.body); //decode untuk metranslate json
    return ResponseJadwal.fromJsonMap(JsonResponse);
  }

  @override
  void iniState() {
    if (_locationControler.text.isEmpty || _locationControler.text == null) {
      _locationControler.text = 'bogor';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final header = Stack(
      children: <Widget>[
        Container(
          // media query kyk semacam match perent
          height: MediaQuery.of(context).size.width - 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 6.0,
                    offset: Offset(0.0, 2.0),
                    color: Colors.black26)
              ],
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1597648825857-84d2dcdede35?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2378&q=80"),
              )),
        ),
        //symmettic itu untuk mengatur horizontak dan certival
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Tooltip(
                message: 'Ubah lokasi',
                child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.location_on),
                    onPressed: () {
                      // ketika di tekan
                      _showDialogEditLocation(context);
                    }),
              ),
            ],
          ),
        ),
        FutureBuilder(
            future: getJadwal(
                location: _locationControler.text.toLowerCase().toString()),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return HeaderContent(snapshot.data);
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Data tidak tersedia',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
              return Positioned.fill(
                  child: Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(), //progressbar (muter muter)
              ));
            })
      ],
    );

    final body = Expanded(
        child: FutureBuilder(
            future: getJadwal(
                location: _locationControler.text.toLowerCase().toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListJadwal(snapshot.data);
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text('Data tidak tersedia'));
              }
              return Center(child: CircularProgressIndicator());
            }));
    return Scaffold(
      body: Column(
        children: <Widget>[header, body],
      ),
    );
  }

  void _showDialogEditLocation(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ubah Lokasi'),
            content: TextField(
              controller: _locationControler,
              decoration: InputDecoration(hintText: 'Lokasi'),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Batal'),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.pop(context, () {
                    setState(() {
                      getJadwal(
                          location:
                              _locationControler.text.toLowerCase().toString());
                    });
                  });
                },
                child: new Text('Ok'),
              ),
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
          );
        });
  }
}

//null itu kosong artinya
