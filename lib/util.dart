import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

final apiId = "71b080b488627db52f279b053e9df166";
// ignore: top_level_instance_method
var defaultName = "Dhaka";

class Location{

  double latitude;
  double longitude;
  Future<void> getCurrentLocation() async{
    try {
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
      latitude = position.latitude;
      longitude = position.longitude;

    }catch(e){
    print(e);
    }
  }

  Future<Map> getCity(String latitude, String longitude) async {
    String apiURL =
        "https://geocode.xyz/$latitude,$longitude?geoit=json";

    http.Response response = await http.get(apiURL);
    return json.decode(response.body);
  }
  _getName() async{
    Map _data = await getCity(latitude as String, longitude as String);
   String cityName = _data['city'];
    return cityName;
  }

}

Location a = new Location();