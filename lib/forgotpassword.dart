import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:sahyog_app/resetpassword.dart';
import 'package:sms_autofill/sms_autofill.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.red,
      accentColor: Colors.deepOrange,
    ),
    home: ForgotPassword(),
  ));
}

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listOPT();
  }

  @override
  Widget build(BuildContext context) {
    final mobilecontroller = TextEditingController();
    final otpcontroller = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Forgot Password',
            style: TextStyle(
              fontSize: 25.0,
            ),
          ),
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
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 100.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: mobilecontroller,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        hintText: "Mobile No."),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  // ignore: deprecated_member_use
                  MaterialButton(
                    color: Colors.lightBlue[100],
                    child: Text(
                      'Send OTP',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      var req =
                          await http.get(Uri.parse('http://sahyogapp.iotans'
                                  '.in/api/otpfor_resetpassword?dmobile=' +
                              mobilecontroller.text.replaceAll(" ", "")));
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return OTP();
                      // }));
                    },
                  ),
                  // Divider(
                  //   thickness: 2.0,
                  //   color: Colors.grey,
                  // ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  // Text('Enter Pin'),
                  Container(
                    child: PinFieldAutoFill(
                      decoration: UnderlineDecoration(
                        textStyle: TextStyle(fontSize: 20, color: Colors.black),
                        colorBuilder:
                            FixedColorBuilder(Colors.black.withOpacity(0.3)),
                      ),
                      codeLength: 4,
                      onCodeSubmitted: (code) {},
                      onCodeChanged: (code) {
                        if (code!.length == 4) {
                          FocusScope.of(context).requestFocus(FocusNode());
                        }
                      },
                    ),
                  ),
                  //ignore: deprecated_member_use
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  MaterialButton(
                      color: Colors.lightBlue[100],
                      child: Text(
                        'Verify',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    resetpassword()));
                      }),
                ],
              ),
            ),
          ),
        ));
  }

  _listOPT() async {
    await SmsAutoFill().listenForCode;
  }
}

// class OTP extends StatefulWidget {
//   @override
//   _OTPState createState() => _OTPState();
// }
//
// class _OTPState extends State<OTP> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _listOPT();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
//
//   _listOPT() async {
//     await SmsAutoFill().listenForCode;
//   }
// }
