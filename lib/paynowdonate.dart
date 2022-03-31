import 'package:flutter/material.dart';
import 'package:sahyog_app/universal.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: paynow(),
  ));
}

class paynow extends StatefulWidget {
  const paynow({Key? key}) : super(key: key);

  @override
  _paynowState createState() => _paynowState();
}

class _paynowState extends State<paynow> {
  var url = 'http://sahyogapp.iotans.in/payment/Index?did=' +
      universaldata.did.replaceAll(":", "").replaceAll(" ", "") +
      '&dname=' +
      universaldata.dname.replaceAll(":", "").replaceAll(" ", "") +
      '&dmobile=' +
      universaldata.dmobile.replaceAll(":", "").replaceAll(" ", "") +
      '&demail=' +
      universaldata.demail.replaceAll(":", "").replaceAll(" ", "") +
      '&rid=' +
      universaldata.rid.replaceAll(":", "").replaceAll(" ", "") +
      '&rname=' +
      universaldata.rname.replaceAll(":", "").replaceAll(" ", "") +
      '&transamount=' +
      universaldata.transamount.replaceAll(":", "").replaceAll(" ", "");




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          WebView(initialUrl: "http://sahyogapp.iotans.in/payment/Index?did=17&dname=garima&dmobile=9528166211&demail=abc@gmail.com&rid=2&rname=Deviram&transamount=1", javascriptMode: JavascriptMode.unrestricted),
    );
  }
}
