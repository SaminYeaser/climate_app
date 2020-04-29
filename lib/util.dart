import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

final apiId = "71b080b488627db52f279b053e9df166";
var defaultName = "Dhaka";

void getCurrentLocation() async{
  final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
   String long ="${position.longitude}";
   String lat = "${position.latitude}";
   Future  a = getCity(lat, long);
   print(a);
}

String _getName(){

}



Future<String> getCity(String latitude, String longitude) async{
  String apiURL1 ="https://geocode.xyz/$latitude,$longitude?geoit=json";

  http.Response response = await http.get(apiURL1);


 List list = json.decode(response.body);
  return list[2];
}



//double latitude ;
//double longitude;
//
//void geoLocation() {
//  Future<void> getCurrentLocation() async {
//    try {
//      Position position = await Geolocator().getCurrentPosition(
//          desiredAccuracy: LocationAccuracy.bestForNavigation);
//      latitude = position.latitude;
//       longitude = position.longitude;
//       print(latitude);
//    } catch (e) {
//      print(e);
//    }
//  }
//}
//
//
//Future<String> getCity(String latitude, String longitude) async {
//  String apiURL ="https://geocode.xyz/$latitude,$longitude?geoit=json";
//
//  http.Response response = await http.get(apiURL);
//  Map<String, dynamic> data = json.decode(response.body);
//  return data['city'].toString();
//}
//
//
//
////String a = getCity(latitude.toString(), longitude.toString());
////
////Widget updateCity(String city) {
////  return new FutureBuilder(
////      future: getCity(util.longitude.toString(), util.latitude.toString()),
////      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
////        if (snapshot.hasData) {
////          Map content = snapshot.data;
////          return new Container(
////            child: new Column(
////              children: <Widget>[
////                new ListTile(
////                  title: new Text(content['city'].toString(),
////                    style: tempStyle(),
////                  ),
////                )
////              ],
////            ),
////          );
////        } else {
////          return new Container();
////        }
////      });
////}
//
//
//
//Location a = new Location();