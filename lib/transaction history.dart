import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sahyog_app/node_donortransaction.dart';
import 'package:sahyog_app/universal.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: transaction(),
  ));
}

class transaction extends StatefulWidget {
  const transaction({Key? key}) : super(key: key);

  @override
  _transactionState createState() => _transactionState();
}

int rindex = 0;

class _transactionState extends State<transaction> {
  List<nodetransaction> _nodes = [];

  Future<List<nodetransaction>> getdata() async {
    var req = await http.get(Uri.parse('http://sahyogapp.iotans'
            '.in/api/donortranshistory?did=' +
        universaldata.did));
    var nodesJson = List<Map<String, dynamic>>.from(json.decode(req.body));
    //print("body" + nodesJson);
    List<nodetransaction> nodes = [];

    rindex = 0;
    for (var nodeJson in nodesJson) {
      rindex++;
      String did = nodeJson["did"].toString();
      print("DID" + universaldata.did);
      String tid = nodeJson["tid"].toString();
      String transamount = nodeJson["transamount"].toString();
      String tcreatedate = nodeJson["tcreatedate"].toString();

      nodes.add(new nodetransaction(
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
                          'Date :' + universaldata.tcreatedate,
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        Text(
                          'Amount :' + universaldata.transamount,
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
