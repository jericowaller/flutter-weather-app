import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;

var data;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  TextEditingController _controller = new TextEditingController();

  void getData(location) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=2f7f1281552a8fcc70eef66b67525bc1&units=imperial";
    http.Response res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      data = jsonDecode(res.body);
    } else {
      data = null;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/test.png"), fit: BoxFit.cover)),
            child: Scaffold(
                backgroundColor: Color.fromARGB(0, 0, 0, 0),
                body: Center(
                    child: Column(children: [
                  Container(
                      height: 50,
                      width: 200,
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      decoration: BoxDecoration(
                          color: Colors.white, border: Border.all()),
                      child: TextField(
                        controller: _controller,
                        onSubmitted: (value) => {getData(value)},
                      )),
                  Container(
                      padding: (data == null)
                          ? new EdgeInsets.all(0)
                          : new EdgeInsets.all(30),
                      margin: new EdgeInsets.only(bottom: 50, top: 30),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(100, 0, 0, 0),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: (data == null)
                          ? SizedBox()
                          : Column(children: [
                              Text(data['name'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 60)),
                              Text(
                                  data['main']['temp'].round().toString() +
                                      "°F",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 100)),
                              Text(
                                  "Feels like: " +
                                      data['main']['feels_like']
                                          .round()
                                          .toString() +
                                      "°F",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 40))
                            ])),
                  Container(
                      margin: EdgeInsets.only(
                          left: 200, right: 200, top: 40, bottom: 40),
                      padding: (data == null)
                          ? new EdgeInsets.all(0)
                          : new EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(100, 0, 0, 0),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: (data == null)
                          ? SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                    "Current weather: " +
                                        data['weather'][0]['main'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                Text(
                                    "Humidity: " +
                                        data['main']['humidity'].toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                Text(
                                    "Wind speed: " +
                                        data['wind']['speed'].toString() +
                                        " MPH",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))
                              ],
                            ))
                ])))));
  }
}
