import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'util.dart' as util;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String cityName = util.defaultName;


  Future _nextScreen(BuildContext context) async {
    Map result = await Navigator.of(context).push(
        new MaterialPageRoute(builder: (BuildContext context) {
          return new nextScreen();
        }));
    if (result != null && result.containsKey('enter')) {
      cityName = result['enter'].toString();
    } else {
      cityName = util.defaultName.toString();
    }
  }




  Future _ownWeather(BuildContext context) async {
    Map result = await Navigator.of(context).push(
        new MaterialPageRoute(builder: (BuildContext context) {
          return new Home();
        }));
    if (result != null && result.containsKey('enter')) {
      cityName = result['enter'].toString();
    } else {
      cityName = util.defaultName.toString();
    }
  }





  void getStuff() async {
    Map data = await getWeather(util.apiId, util.defaultName.toString());
    print(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Climate Update"),
        backgroundColor: Colors.greenAccent,
//        actions: <Widget>[
////          new IconButton(
////              icon: Icon(Icons.menu), onPressed:getStuff)
//        ],
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(accountName: null, accountEmail: null),
            new ListTile(
              title: new Text('Select Country'),
              onTap: () {
                Navigator.of(context).pop();
                _nextScreen(context);
              },
            ),
            new Divider(
              color: Colors.black38,
              height: 5.0,
            ),
            new ListTile(
              title: new Text('Show your location weather'),
              onTap: () {
                Navigator.of(context).pop();
                util.getCurrentLocation();
              },
            )
          ],
        ),
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset(
              'images/weather.jpg',
              width: 500.0,
              height: 800.0,
              fit: BoxFit.fill,
            ),
          ),
          new Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.fromLTRB(20, 80, 20, 20),
            child: new Text(
              "$cityName",
              style: textStyle(),
            )

          ),
          new Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: updateTemp(
                '$cityName' == null ? util.defaultName : cityName),
          )
        ],
      ),
    );
  }

  Future<Map> getWeather(String apiId, String city) async {
    String apiURL =
        "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=${util
        .apiId}&units=metric";

    http.Response response = await http.get(apiURL);
    return json.decode(response.body);
  }

  Widget updateTemp(String city) {
    return new FutureBuilder(
        future: getWeather(util.apiId, city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;
            return new Container(
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    title: new Text(content['main']['temp'].toString(),
                      style: tempStyle(),
                    ),
                  )
                ],
              ),
            );
          } else {
            return new Container();
          }
        });
  }

}

//  _getName() async{
//  Map _data = await getCity(latitude as String, longitude as String);
//  String cityName = _data['city'];
//  return cityName;


class nextScreen extends StatelessWidget {

  var _cityFeildControler = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Select City'),
        backgroundColor: Colors.green,
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child:new Image.asset('images/wet_mobile.jpg',
              width: 500.0,
              height: 600.0,
              fit: BoxFit.fill,
            ) ,
          ),
          new ListView(
            children: <Widget>[
              new ListTile(
                title: new TextField(
                  decoration: new InputDecoration(
                      hintText: 'Enter a City'
                  ),
                  controller: _cityFeildControler,
                  keyboardType: TextInputType.text,
                ),
              ),

              new ListTile(
                title: new FlatButton(
                    onPressed: (){
                      Navigator.pop(context,{
                        'enter': _cityFeildControler.text
                      });
                    },
                    child: new Text('Get weather')),
              )
            ],
          )


        ],
      ),
    );
  }

}


TextStyle textStyle() {
  return new TextStyle(fontSize: 40.0, color: Colors.white);
}

TextStyle tempStyle() {
  return new TextStyle(fontSize: 50.0, color: Colors.white);
}

