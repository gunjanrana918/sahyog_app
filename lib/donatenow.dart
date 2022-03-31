import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sahyog_app/node_mediareceiver.dart';
import 'package:sahyog_app/paynowdonate.dart';
import 'package:sahyog_app/receivertransaction.dart';
import 'package:sahyog_app/universal.dart';

import 'donateamount.dart';
import 'node_mediavideo.dart';
import 'node_receiverinfodata.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: donatescreen(),
  ));
}

class donatescreen extends StatefulWidget {
  const donatescreen({Key? key}) : super(key: key);

  @override
  _donatescreenState createState() => _donatescreenState();
}

int rindex = 0;
List<nodemediavideo> _nodesvideo = [];

class _donatescreenState extends State<donatescreen> {
  get nodeJson => null;
  List<String> text = [];
  List<noderecieverinfo> nodes1 = [];
  List<nodemedia> _nodes = [];
  List<nodemediavideo> _nodes2 = [];
// For Single Data
  Future<List<noderecieverinfo>> getdata() async {
    var req = await http.get(Uri.parse(
        'http://sahyogapp.iotans.in/api/receiverinfo?rid=' +
            universaldata.rid));
    var nodesJson = List<Map<String, dynamic>>.from(json.decode(req.body));
    rindex = 0;
    for (var nodeJson in nodesJson) {
      rindex++;
      String rdphoto = nodeJson["rdphoto"].toString();
      universaldata.rdphoto = rdphoto;
      String ramount = nodeJson["ramount"].toString();
      universaldata.ramount = ramount;
      String rgoalamount = nodeJson["rgoalamount"].toString();
      universaldata.rgoalamount = rgoalamount;
      String rdescription = nodeJson["rdescription"].toString();
      universaldata.rdescription = rdescription;
    }
    print("DID" + universaldata.rid);
    return nodes1;
  }
  ///************
  Future<List<nodemedia>> getdata1() async {
    var req = await http.get(Uri.parse(
        'http://sahyogapp.iotans.in/api/receivermediadata?rid=' +
            universaldata.rid));
    var nodesJson = List<Map<String, dynamic>>.from(json.decode(req.body));
    List<nodemedia> nodes = [];
    rindex = 0;
    for (var nodeJson in nodesJson) {
      rindex++;
      String rmid = nodeJson["rmid"].toString();
      String rmmedia = nodeJson["rmmedia"].toString();
      text.add("http://sahyogapp.iotans.in/UploadDocs/" + rmmedia);
      String rmtype = nodeJson["rmtype"].toString();

      if (rmtype == "Images") {
        print("http://sahyogapp.iotans.in/UploadDocs/" + rmmedia);
        nodes.add(new nodemedia(
          rmid,
          rmmedia,
          rmtype,
        ));
      }
    }

    print("IMAGES" + universaldata.rid);
    return nodes;
  }

  Future<List<nodemediavideo>> getdata2() async {
    var req = await http.get(Uri.parse(
        'http://sahyogapp.iotans.in/api/receivermediadata?rid=' +
            universaldata.rid));
    var nodesJson = List<Map<String, dynamic>>.from(json.decode(req.body));
    List<nodemediavideo> nodes = [];
    rindex = 0;
    for (var nodeJson in nodesJson) {
      rindex++;
      String rmid = nodeJson["rmid"].toString();
      String rmmedia = nodeJson["rmmedia"].toString();
      String rmtype = nodeJson["rmtype"].toString();

      if (rmtype == "Videos") {
        nodes.add(new nodemediavideo(
          rmid,
          rmmedia,
          rmtype,
        ));
      }
    }
    print("IMAGES" + universaldata.rmmedia);
    return nodes;
  }

  @override
  Widget build(BuildContext context) {
getdata();
getdata1();
    // getdata().then((value) {
    //   setState(() {});
    // });
    // getdata1().then((value) {
    //   setState(() {
    //     if (!_nodes.contains(value)) {
    //       _nodes.addAll(value);
    //     }
    //   });
    // });
    // getdata2().then((value) {
    //   setState(() {
    //     if (!_nodes2.contains(value)) _nodes2.addAll(value);
    //   });
    // });


double width = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
        appBar: AppBar(
          title: Text(universaldata.rname),
          centerTitle: true,
          backgroundColor: Colors.pinkAccent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black87, width: 1),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          "http://sahyogapp.iotans.in/UploadDocs/" +
                              universaldata.rdphoto,
                        ),
                      )),
                ),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => receivertransaction()));
                    },
                    child: Container(
                      width: 100,
                      child: Text(
                        'Received amount:- ' + " Rs." + universaldata.ramount,
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      'Goal amount:-' + "Rs. " + universaldata.rgoalamount,
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ),
                  )
                ],
              ),
              Card(
                margin: EdgeInsets.all(10.0),
                elevation: 6,
                color: Colors.blueGrey[100],
                shadowColor: Colors.pinkAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(width: 1, color: Colors.black87)),
                child: Row(children: <Widget>[
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  "Why Need?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              Container(
                                width: width,
                                child: Text(universaldata.rdescription),
                              ),
                            ])),
                  )
                ]),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.green[200]),
                height: 190,
                child: ListView.builder(
                    reverse: false,
                    // primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: rindex,
                    itemBuilder: (context, index) {
                      return  Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(5.0),
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: List.generate(text.length,(index){
                                  return Image.network(text[index].toString(),
                                 height: 120,
                                    width: 130,
                                  );
                                }),
                              ),
                            )
                            // Container(
                            //   height: 150,
                            //   width: 150,
                            //   decoration: BoxDecoration(
                            //       image: DecorationImage(
                            //     fit: BoxFit.cover,
                            //     image: NetworkImage(
                            //       "http://sahyogapp.iotans.in/UploadDocs/" +
                            //           _nodes[index].rmmedia,
                            //     ),
                            //   )),
                            // ),
                          ],
                        );

                    }),
              ),
              //videoplayer
              // Padding(padding: EdgeInsets.only(top: 5.0)),
              // Container(
              //   decoration: BoxDecoration(color: Colors.lightGreenAccent),
              //   height: 180,
              //   child: ListView.builder(
              //       reverse: false,
              //       // primary: false,
              //       shrinkWrap: true,
              //       scrollDirection: Axis.horizontal,
              //       itemCount: rindex,
              //       itemBuilder: (context, index) {
              //         return Column(
              //           mainAxisSize: MainAxisSize.min,
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             BetterPlayer.network(
              //               "http://sahyogapp.iotans.in/UploadDocs/" +
              //                   _nodes2[index].rmmedia,
              //               betterPlayerConfiguration:
              //                   BetterPlayerConfiguration(
              //                 autoPlay: false,
              //                 autoDetectFullscreenDeviceOrientation: true,
              //               ),
              //             )
              //           ],
              //         );
              //       }),
              // ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              //donatenowbutton
              MaterialButton(
                  color: Colors.green,
                  child: Text(
                    'Donate now',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => donateamount()));
                  }),
            ],
          ),
        ));
  }
}
