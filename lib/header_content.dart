import 'package:flutter/material.dart';
import 'package:jadwal_sholat_app/model/ResponseJadwal.dart';
import 'package:jadwal_sholat_app/text_style.dart';

class HeaderContent extends StatelessWidget {
  ResponseJadwal responseJadwal;

  HeaderContent(this.responseJadwal); //parameter

  @override
  Widget build(BuildContext context) {
    //column sama kyk linerlayout
    return Positioned(
      left: 20.0,
      bottom: 20.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            responseJadwal.results.location.city,
            //masuk nya ke ip kotanya, yaitu bogor
            style: styleCityHeader,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.location_on,
                color: Colors.white,
                size: 20.0,
              ),
              Text(
                responseJadwal.results.location.country,
                style: styleAddresHeader,
                overflow: TextOverflow.ellipsis,
                //ketika text terlalu panjang maka akan muncul titik tiga
                softWrap: false,
              )
            ],
          )
        ],
      ),
    );
  }
}
