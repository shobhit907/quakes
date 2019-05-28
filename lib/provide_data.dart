import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeState();
  }
}

var data;
List _msg;

class HomeState extends State<Home> {
  void showData() async {
    await getData();
    setState(() {
      data = data;
      _msg = _msg;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Quakes"),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        actions: <Widget>[
            new IconButton(icon: Icon(Icons.refresh), onPressed: showData,tooltip: "Click to Refresh",splashColor: Colors.blue,),
        ],
      ),
      body: new Center(
        child: new Scrollbar(
          child: new ListView.builder(
              itemCount: _msg.length * 2,
              itemBuilder: (BuildContext context, int position) {
                if (position.isOdd) {
                  return new Divider();
                }
                int index = position ~/ 2;
                DateTime d = DateTime.fromMillisecondsSinceEpoch(
                    _msg[index]['properties']['time']);
                String datetime =
                    "${new DateFormat.MMMM().format(d)} ${d.day}, ${d.year} ${new DateFormat.jm().format(d)}";
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new ListTile(
                    title: new Text(datetime),
                    subtitle: new Text(_msg[index]['properties']['place']),
                    leading: new CircleAvatar(
                      child:
                          new Text(_msg[index]['properties']['mag'].toString()),
                      backgroundColor: Colors.green,
                    ),
                    onTap: () {
                      showOnTap(context,
                          "Magnitude : ${_msg[index]['properties']['mag']} \nPlace : ${_msg[index]['properties']['place']}");
                    },
                  ),
                );
              }),
        ),
      ),
    );
  }

  Future getData() async {
    String apiurl =
        "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson";
    http.Response response = await http.get(apiurl);
    data = json.decode(response.body);
    _msg = data['features'];
  }
}
//Widget showData(BuildContext context) {
//  return new FutureBuilder(future: ,builder:(BuildContext context,AsyncSnapshot<Map> snapshot){
//
//  });
//}

void showOnTap(BuildContext context, String message) {
  var alert = new AlertDialog(
    title: new Text("Quakes"),
    content: new Text(message),
    actions: <Widget>[
      new FlatButton(
          onPressed: () => Navigator.pop(context), child: new Text("OK")),
    ],
  );
  showDialog(context: context, child: alert);
}
