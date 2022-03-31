import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sahyog_app/registrationscreen.dart';
import 'package:sahyog_app/universal.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'loginscreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: mobileotp(),
  ));
}

class mobileotp extends StatefulWidget {
  const mobileotp({Key? key}) : super(key: key);

  @override
  _mobileotpState createState() => _mobileotpState();
}

class _mobileotpState extends State<mobileotp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Padding(padding: EdgeInsets.only(top: 15.0)),
                // ignore: deprecated_member_use
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
                      Future<void> getdata() async {
                        var req =
                            await http.get(Uri.parse('http://sahyogapp.iotans'
                                    '.in/api/dregistration?dname=' +
                                universaldata.dname +
                                '&dmobile=' +
                                universaldata.dmobile +
                                '&demail=' +
                                universaldata.demail +
                                '&dpassword=' +
                                universaldata.dpassword +
                                '&dpincode=' +
                                universaldata.dpincode +
                                '&dcity=' +
                                universaldata.dcity +
                                ''));
                        if (req.body.contains(
                            "Your registration done successfully!!")) {
                          // universaldata.dpassword = "";

                          // ignore: deprecated_member_use
                          Widget gotIt = FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Colors.black,
                            child: Text(
                              "Ok",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => loginscreen()));
                            },
                          );
                          AlertDialog alert = AlertDialog(
                            title: Text("Success"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            backgroundColor: Colors.brown[100],
                            content: Text(
                                "Registered Successfully! Press ok to continue login"),
                            actions: [
                              gotIt,
                            ],
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        } else {
                          if (req.body.contains(universaldata.dmobile +
                              " is already registered with us!")) {
                            Widget gotIt2 = FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: Colors.black,
                              child: Text(
                                "Ok",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            registrationform()));
                              },
                            );
                            AlertDialog alert = AlertDialog(
                              title: Text("Success"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              backgroundColor: Colors.brown[100],
                              content: Text(universaldata.dmobile +
                                  " is already registered "
                                      "with us! please try another no."),
                              actions: [
                                gotIt2,
                              ],
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          }
                          // ignore: deprecated_member_use
                          Widget gotIt = FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Colors.black,
                            child: Text(
                              "Ok",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop('alert');
                            },
                          );
                          AlertDialog alert = AlertDialog(
                            title: Text("Registration Error"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            backgroundColor: Colors.brown[300],
                            content: Text("Try Again!"),
                            actions: [
                              gotIt,
                            ],
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        }
                      }

                      getdata();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
