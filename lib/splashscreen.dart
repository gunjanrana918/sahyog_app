import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sahyog_app/homescreen.dart';
import 'package:sahyog_app/slider screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sahyog_app/universal.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashscreen(),
    ));

class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  //for shared preference condition
  void check_if_already_login() async {
    var logindata = await SharedPreferences.getInstance();
    var newuser = (logindata.getBool('login') ?? true);

    if (newuser == false)
    {
      universaldata.did = logindata.getString('did')!;
      universaldata.dimage = logindata.getString('dimage')!;
      universaldata.dname = logindata.getString('dname')!;
      universaldata.dmobile = logindata.getString('dmobile')!;
      universaldata.dpassword = logindata.getString('dpassword')!;
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => dashboardscreen()));
    }
  }



  void initState() {
    check_if_already_login();
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => slider())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('custom/splashscreen.jpg'),
                  fit: BoxFit.fill),
            ),
          ),
        ],
      ),
    );
  }
}
