import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_pro/carousel_pro.dart' show Carousel;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sahyog_app/forgotpassword.dart';
import 'package:sahyog_app/loginscreen.dart';
import 'package:sahyog_app/node_recieverdata.dart';
import 'package:sahyog_app/transaction%20history.dart';
import 'package:sahyog_app/universal.dart';
import 'package:sahyog_app/updateprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'change_password.dart';
import 'donatenow.dart';
import 'node_donorlist.dart';
import 'node_recentdonation.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: dashboardscreen(),
  ));
}

class dashboardscreen extends StatefulWidget {
  const dashboardscreen({Key? key}) : super(key: key);

  @override
  _dashboardscreenState createState() => _dashboardscreenState();
}

int rindex = 0;

class _dashboardscreenState extends State<dashboardscreen> {
  List<Noderecentdonor> _nodes = [];
  List<Nodedonor> _topdonernodes = [];
  List<Nodereciever> _nodereceiver = [];
  var imgarr = [];
  var imgarr1 = [];

  //RECENT DONATION API
  Future<List<Noderecentdonor>> getdata() async {
    var reqimg = await http
        .get(Uri.parse('http://sahyogapp.iotans.in/configuration/appslider'));
    var imgvalue = reqimg.body.split(",");
    imgvalue.forEach((element) {
      if (element != "" || null != element) {
        imgarr.add(
            NetworkImage("http://sahyogapp.iotans.in/UploadDocs/" + element));
      }
    });

    var req = await http
        .get(Uri.parse('http://sahyogapp.iotans.in/api/recentdonation'));
    // ignore: deprecated_member_use
    var nodesJson = List<Map<String, dynamic>>.from(json.decode(req.body));
    List<Noderecentdonor> nodes = [];
    rindex = 0;
    for (var nodeJson in nodesJson) {
      rindex++;
      String did = nodeJson["did"].toString();
      String dname = nodeJson["dname"].toString();
      String dimage = nodeJson["dimage"].toString();
      String transamount = nodeJson["transamount"].toString();

      nodes.add(new Noderecentdonor(did, dname, dimage, transamount));
    }
    return nodes;
  }

  //Get doner list api
  Future<List<Nodedonor>> getdata1() async {
    var reqimg = await http
        .get(Uri.parse('http://sahyogapp.iotans.in/configuration/appcampaign'));
    var imgvalue = reqimg.body.split(",");
    imgvalue.forEach((element) {
      imgarr1.add(
          NetworkImage("http://sahyogapp.iotans.in/UploadDocs/" + element));
    });

    var req =
        await http.get(Uri.parse('http://sahyogapp.iotans.in/api/topdonor'));
    var nodesJson = List<Map<String, dynamic>>.from(json.decode(req.body));
    List<Nodedonor> nodes = [];
    rindex = 0;
    for (var nodeJson in nodesJson) {
      rindex++;
      String did = nodeJson["did"].toString();
      String dname = nodeJson["dname"].toString();
      String dimage = nodeJson["dimage"].toString();
      String transamount = nodeJson["transamount"].toString();

      nodes.add(new Nodedonor(did, dname, dimage, transamount));
    }
    return nodes;
  }

  //for receiver API
  Future<List<Nodereciever>> getdata2() async {
    var req = await http
        .get(Uri.parse('http://sahyogapp.iotans.in/api/receiverdata'));

    // ignore: deprecated_member_use
    var nodesJson = List<Map<String, dynamic>>.from(json.decode(req.body));
    List<Nodereciever> nodes = [];
    rindex = 0;
    for (var nodeJson in nodesJson) {
      rindex++;
      String rid = nodeJson["rid"].toString();
      String rname = nodeJson["rname"].toString();
      String rdphoto = nodeJson["rdphoto"].toString();

      nodes.add(new Nodereciever(
        rid,
        rname,
        rdphoto,
      ));
    }
    return nodes;
  }

  @override
  Widget build(BuildContext context) {
    imgarr.add(NetworkImage(
        "http://sahyogapp.iotans.in/UploadDocs/10730301261882021143631.jpg"));
    getdata().then((value) {
      setState(() {
        //Recent donation api
        if (!_nodes.contains(value)) {
          _nodes.addAll(value);
        }
      });
    });
    imgarr1.add(NetworkImage(
        "http://sahyogapp.iotans.in/UploadDocs/10730301261882021143631.jpg"));
    getdata1().then((value) {
      setState(() {
        //Recent donation api
        if (!_topdonernodes.contains(value)) {
          _topdonernodes.addAll(value);
        }
      });
    });
    //receiver data
    getdata2().then((value) {
      setState(() {
        getdata().then((value) {
          setState(() {
            //Recent donation api
            if (!_nodes.contains(value)) {
              _nodes.addAll(value);
            }
          });
        });
        //Recent donation api
        if (!_nodereceiver.contains(value)) {
          _nodereceiver.addAll(value);
        }
      });
    });

    //EXIT FROM APP//
    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit an App'),
              actions: <Widget>[
                // ignore: deprecated_member_use
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('No'),
                ),
                // ignore: deprecated_member_use
                new FlatButton(
                  onPressed: () => exit(0),
                  child: new Text('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    }

    Widget imageSliderCarousel = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
      ),
      height: 180,
      child: Carousel(
        boxFit: BoxFit.fill,
        autoplay: true,
        autoplayDuration: Duration(seconds: 5),
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 2.0,
        dotBgColor: Colors.white,
        showIndicator: false,
        images: imgarr,
      ),
    );

    Widget imageSliderCarousel1 = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
      ),
      height: 180,
      child: Carousel(
        boxFit: BoxFit.fill,
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 100),
        dotSize: 5.0,
        dotBgColor: Colors.transparent,
        showIndicator: false,
        images: imgarr1,
      ),
    );

    getdata().then((value) {
      setState(() {
        //Recent donation api
        if (!_nodes.contains(value)) {
          _nodes.addAll(value);
        }
      });
    });

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Sahyog',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.pinkAccent,
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('custom/backgroundimage.jpeg'),
                        fit: BoxFit.cover),
                  ),
                  child: Image.asset('custom/logo1.png'),
                ),
                ListTile(
                    leading: Image.asset('custom/updateprofile.png'),
                    title: Text(
                      'Profile update',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => updateprofile()));
                    }),
                ListTile(
                    leading: Icon(
                      Icons.lock_outline,
                      size: 30.0,
                      color: Colors.brown,
                    ),
                    title: Text(
                      'Change Password',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => changepassword()));
                    }),
                ListTile(
                    leading: Icon(
                      Icons.lock_outline,
                      size: 30.0,
                      color: Colors.brown,
                    ),
                    title: Text(
                      'forgot Password',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                    }),
                ListTile(
                  leading: Icon(
                    Icons.history,
                    size: 30.0,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Transaction History',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => transaction()));
                  },
                ),
                ListTile(
                  leading: Image.asset('custom/shareapp.png'),
                  title: Text(
                    'Share app',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                ListTile(
                    leading: Image.asset('custom/logout.png'),
                    title: Text(
                      'Signout',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.clear();
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => loginscreen()));
                    }),
              ],
            ),
          ),
          body: Container(
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //       image: AssetImage('custom/bg1.jpg'), fit: BoxFit.fill),
            // ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Padding(padding: EdgeInsets.only(top: 5.0)),
                  Container(
                    height: 200,
                    child: imageSliderCarousel,
                  ),
                  Divider(
                    height: 2,
                    thickness: 1,
                    color: Colors.black38,
                  ),
                  //topdonor//
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(left: 5.0, top: 5)),
                      SizedBox(
                        height: 50,
                        child: AnimatedTextKit(
                          animatedTexts: [
                            RotateAnimatedText(
                              'Top Donor',
                              textStyle: const TextStyle(
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            )
                          ],
                          repeatForever: true,
                        ),
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.redAccent),
                    height: 180,
                    child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        // controller: _scrollController,
                        reverse: false,
                        scrollDirection: Axis.horizontal,
                        itemCount: rindex,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 6.0,
                            shadowColor: Colors.green,
                            margin: EdgeInsets.all(6.0),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100,
                                  width: 123,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black87, width: 2),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "http://sahyogapp.iotans.in/UploadDocs/" +
                                              _topdonernodes[index].dimage,
                                        ),
                                      )),
                                ),
                                Padding(padding: EdgeInsets.only(top: 5.0)),
                                Text(
                                  _topdonernodes[index].dname,
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(padding: EdgeInsets.only(top: 5.0)),
                                Text(
                                  _topdonernodes[index].transamount,
                                  style: TextStyle(fontSize: 13.0),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  //top donor
                  Divider(
                    height: 2,
                    thickness: 2,
                    color: Colors.black38,
                  ),
                  //Social Compaign
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(padding: EdgeInsets.only(left: 5.0)),
                      SizedBox(
                        height: 50,
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              'Social Compaign',
                              textAlign: TextAlign.right,
                              textStyle: const TextStyle(
                                  fontSize: 35.0,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            )
                          ],
                          repeatForever: true,
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 200,
                    child: imageSliderCarousel1,
                  ),
                  Divider(
                    height: 2,
                    thickness: 2,
                    color: Colors.black38,
                  ),
                  //receiver data//
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(left: 5.0, top: 10)),
                      SizedBox(
                          height: 50,
                          child: Text(
                            'Help US',
                            style: TextStyle(
                                fontSize: 35.0,
                                color: Colors.lightGreen,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          )),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.greenAccent),
                    height: 190,
                    child: ListView.builder(
                        reverse: false,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: rindex,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 6.0,
                            shadowColor: Colors.green,
                            margin: EdgeInsets.all(6.0),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black87, width: 1),
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "http://sahyogapp.iotans.in/UploadDocs/" +
                                              _nodereceiver[index].rdphoto,
                                        ),
                                      )),
                                ),
                                Padding(padding: EdgeInsets.only(top: 5.0)),
                                Text(_nodereceiver[index].rname),
                                Padding(padding: EdgeInsets.only(top: 3.0)),
                                TextButton(
                                  onPressed: () {
                                    universaldata.rid =
                                        _nodereceiver[index].rid;
                                    universaldata.rname =
                                        _nodereceiver[index].rname;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                donatescreen()));
                                  }, //
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.amberAccent,
                                    ),
                                  ),
                                  child: Text(
                                    'more details',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                      decoration: TextDecoration.underline,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  //receiver data//
                  Divider(
                    height: 2,
                    thickness: 1,
                    color: Colors.black38,
                  ),
                  //******RECENT DONATION*****
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(padding: EdgeInsets.only(left: 5.0)),
                      SizedBox(
                        height: 50,
                        child: AnimatedTextKit(
                          animatedTexts: [
                            RotateAnimatedText(
                              'Recent Donation',
                              textAlign: TextAlign.right,
                              textStyle: const TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.lightBlue,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            )
                          ],
                          repeatForever: true,
                        ),
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.blue),
                    height: 170,
                    child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        reverse: false,
                        itemCount: rindex,
                        itemBuilder: (context, index) {
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 6.0,
                            shadowColor: Colors.green,
                            margin: EdgeInsets.all(6.0),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 90,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black87, width: 2),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "http://sahyogapp.iotans.in/UploadDocs/" +
                                              _nodes[index].dimage,
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    _nodes[index].dname,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 5.0)),
                                Text(
                                  _nodes[index].transamount,
                                  style: TextStyle(fontSize: 13.0),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  //******RECENT DONATION*****
                  // Image.asset('custom/image2.jpg'),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'custom/facebook.png',
                  ),
                )),
                Expanded(
                    child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'custom/whatsapp.png',
                    height: 50,
                    width: 50,
                  ),
                )),
                Expanded(
                    child: IconButton(
                  onPressed: () {},
                  icon: Image.asset('custom/instagram.png'),
                ))
              ],
            ),
          )),
    );
  }
}
