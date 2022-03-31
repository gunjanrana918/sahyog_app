import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

import 'loginscreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: slider(),
  ));
}

class slider extends StatefulWidget {
  @override
  _sliderState createState() => _sliderState();
}

class _sliderState extends State<slider> {
  @override
  Widget build(BuildContext context) {
    Widget imageSliderCarousel = Container(
      height: 520,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('custom/slider1.jpeg'),
          AssetImage('custom/slider2.jpeg'),
          AssetImage('custom/slider3.jpeg'),
        ],
        autoplay: true,
        showIndicator: false,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Sahyog',
        style: TextStyle(fontSize: 35.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
        body: Container(
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //       image: AssetImage('custom/bg1.jpg'), fit: BoxFit.fill),
      // ),
      child: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 20)),
          imageSliderCarousel,
          Padding(padding: EdgeInsets.only(top: 25)),
          // ignore: deprecated_member_use
          ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.red, width: 2.0)))),
            child: Text(
              'Donate Now',
              style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => loginscreen()));
            },
          ),
        ],
      ),
    ));
  }
}
