// @dart=2.9
import 'package:flutter/material.dart';
import 'package:sahyog_app/splashscreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.red, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.deepOrange),
    ),
    home: splashscreen(),
  ));
}
