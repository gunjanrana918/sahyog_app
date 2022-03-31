import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sahyog_app/node_receivertransaction.dart';
import 'package:sahyog_app/universal.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: receivertransaction(),
  ));
}

class receivertransaction extends StatefulWidget {
  const receivertransaction({Key? key}) : super(key: key);

  @override
  _receivertransactionState createState() => _receivertransactionState();
}

int rindex = 0;

class _receivertransactionState extends State<receivertransaction> {
  List<node_receivetrans> _nodes = [];

  Future<List<node_receivetrans>> getdata() async {
    var req = await http.get(Uri.parse('http://sahyogapp.iotans'
            '.in/api/receivertrans/?rid=' +
        universaldata.rid));
    var nodesJson = List<Map<String, dynamic>>.from(json.decode(req.body));
    //print("body" + nodesJson);
    List<node_receivetrans> nodes = [];

    rindex = 0;
    for (var nodeJson in nodesJson) {
      rindex++;
      String did = nodeJson["did"].toString();
      String tid = nodeJson["tid"].toString();
      String transamount = nodeJson["transamount"].toString();
      String tcreatedate = nodeJson["tcreatedate"].toString();

      nodes.add(new node_receivetrans(
        did,
        tid,
        transamount,
        tcreatedate,
      ));
    }
    return nodes;
  }

  @override
  Widget build(BuildContext context) {
    getdata().then((value) {
      setState(() {
        if (!_nodes.contains(value)) _nodes.addAll(value);
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction details'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('custom/bg1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: rindex,
          itemBuilder: (context, index) {
            return Card(
                margin: EdgeInsets.all(25.0),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          universaldata.tcreatedate,
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        Text(
                          universaldata.transamount,
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )));
          },
        ),
      ),
    );
  }
}
