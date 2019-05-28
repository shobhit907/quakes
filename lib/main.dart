import 'package:flutter/material.dart';
import 'dart:async';
import 'package:quakes/provide_data.dart';
import 'package:http/http.dart' as http;

void main ()async
{
  await new HomeState().getData();
  runApp(new MaterialApp(
    title: "Quakes",
    debugShowCheckedModeBanner: false,
    home: new Home(),
  ));
}