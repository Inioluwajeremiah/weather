import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

void main () => runApp(
  MaterialApp(
    title:"My Weather App",
    home: Home(),
  )
);

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp, description, currently, humidity, windspeed, pressure, rainfall, clouds;

  Future getWeather() async{
    http.Response response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=Lagos&appid=147b8e904f4d3c098584eafe817d6469"));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.pressure = results['main']['pressure'];
      this.windspeed = results['main']['speed'];
      this.rainfall = results['rain']['1h'];
      this.clouds = results['clouds']['all'];

    });
}
  @override
  void initState(){
    super.initState();
    this.getWeather();
  }
  @override
  Widget build (BuildContext buildContext) {
    return Scaffold(
      body: Column(
          children: <Widget>[
      Container(
      height: MediaQuery.of(buildContext).size.height / 3,
      width: MediaQuery.of(buildContext).size.width,
      color: Colors.green,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
      Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Text(
        "Currently in Nigeria",
        style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.w600
        ),
      ),
    ),
    Text(
     temp != null ? temp.toString() + "\u0000" : " Loading",
    style: TextStyle(
    color: Colors.white,
    fontSize: 40.0,
    fontWeight: FontWeight.w600
    ),
    ),
    Padding(
    padding: EdgeInsets.only(top: 10.0),
    child: Text(
    currently != null ? currently.toString() : "Loading",
    style: TextStyle(
    color: Colors.white,
    fontSize: 14.0,
    fontWeight: FontWeight.w600
    ),
    ),
    ),
    ],
    ),
    ),
    Expanded(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                title: Text('Temperature'),
                trailing: Text(temp != null ? temp.toString() + '\u0080' : "Loading"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.compress),
                title: Text('Pressure'),
                trailing: Text(pressure != null ? pressure.toString() + '\u0080' : "Loading"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.cloudSun),
                title: Text('Humidity'),
                trailing: Text(humidity != null ? humidity.toString() + '\u0080' : "Loading"),
              ),

              ListTile(
                leading: FaIcon(FontAwesomeIcons.wind),
                title: Text('Wind Speed'),
                trailing: Text(windspeed != null ? windspeed.toString() : "Loading"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.cloudRain),
                title: Text('Pressure'),
                trailing: Text(pressure != null ? pressure.toString()  : "Loading"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.cloudRain),
                title: Text('Weather'),
                trailing: Text(description != null ? description.toString()  : "Loading"),
              )
            ],
          ),
        ))
    ],
    )
    );
  }
}



