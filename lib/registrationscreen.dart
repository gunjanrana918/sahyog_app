import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:sahyog_app/loginscreen.dart';
import 'package:sahyog_app/mobileverify.dart';
import 'package:sahyog_app/universal.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: registrationform(),
  ));
}

class registrationform extends StatefulWidget {
  const registrationform({Key? key}) : super(key: key);

  @override
  _registrationformState createState() => _registrationformState();
}

class _registrationformState extends State<registrationform> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final mobilecontroller = TextEditingController();
  final pincodecontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: 180,
              width: 250,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('custom/logo1.png'),
              )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: TextFormField(
                style: TextStyle(fontSize: 15.0),
                controller: namecontroller,
                decoration: InputDecoration(
                    hintText: 'Name',
                    border: InputBorder.none,
                    fillColor: Colors.grey[100],
                    filled: true,
                    contentPadding: EdgeInsets.all(15.0)),
                validator: MultiValidator([
                  RequiredValidator(errorText: '*required'),
                ]),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: TextFormField(
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      border: InputBorder.none,
                      fillColor: Colors.grey[100],
                      filled: true,
                      contentPadding: EdgeInsets.all(15.0)),
                )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: TextFormField(
                  controller: mobilecontroller,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.send,
                  onFieldSubmitted: (value) {
                    print("ok");
                  },
                  decoration: InputDecoration(
                    hintText: 'Mobile',
                    // fillColor: Colors.grey[200], filled: true,
                    border: InputBorder.none,
                    fillColor: Colors.grey[100],
                    filled: true,
                    contentPadding: EdgeInsets.all(15.0),
                    // suffixIcon: IconButton(
                    //   icon: Icon(Icons.send),
                    //   onPressed: () async {
                    //     var req =
                    //         await http.get(Uri.parse('http://sahyogapp.iotans'
                    //                 '.in/api/otpfor_resetpassword?dmobile=' +
                    //             mobilecontroller.text.replaceAll(" ", "")));
                    //   },
                    // ),
                  ),
                  validator: MultiValidator([
                    RequiredValidator(errorText: '*required'),
                    MinLengthValidator(10,
                        errorText: 'mobile'
                            ' no. should be 10 digit')
                  ]),
                )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: TextFormField(
                  controller: passwordcontroller,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      // fillColor: Colors.grey[200], filled: true,
                      border: InputBorder.none,
                      fillColor: Colors.grey[100],
                      filled: true,
                      contentPadding: EdgeInsets.all(15.0)),
                  validator: MultiValidator([
                    RequiredValidator(errorText: '*required'),
                    MinLengthValidator(10,
                        errorText: 'password atleast 6 character')
                  ]),
                )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: TextFormField(
                  controller: pincodecontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Pincode',
                      // fillColor: Colors.grey[200], filled: true,
                      border: InputBorder.none,
                      fillColor: Colors.grey[100],
                      filled: true,
                      contentPadding: EdgeInsets.all(15.0)),
                  validator: MultiValidator(
                      [RequiredValidator(errorText: '*required')]),
                )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: TextFormField(
                  controller: citycontroller,
                  decoration: InputDecoration(
                      hintText: 'City',
                      // fillColor: Colors.grey[200], filled: true,
                      border: InputBorder.none,
                      fillColor: Colors.grey[100],
                      filled: true,
                      contentPadding: EdgeInsets.all(15.0)),
                  validator: MultiValidator(
                      [RequiredValidator(errorText: '*required')]),
                )),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () async {
                    if (namecontroller.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Enter Name.",
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 13.0);
                      return;
                    } else if (mobilecontroller.text.length != 10) {
                      Fluttertoast.showToast(
                          msg: "Enter 10 digit.",
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 13.0);
                      return;
                    } else if (passwordcontroller.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Enter Password.",
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 13.0);
                      return;
                    }
                    //*****SAVE THE USER DETAILS ON SUBMIT*****

                    universaldata.dname = namecontroller.text;
                    universaldata.demail = emailcontroller.text;
                    universaldata.dmobile = mobilecontroller.text;
                    universaldata.dpassword = passwordcontroller.text;
                    universaldata.dcity = citycontroller.text;
                    universaldata.dpincode = pincodecontroller.text;
                    var req = await http.get(Uri.parse(
                        'http://sahyogapp.iotans.in/api/otpfor_checkphone?dmobile=' +
                            mobilecontroller.text.replaceAll(" ", "")));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => mobileotp()));
                  },
                  color: Colors.lightBlue[100],
                  child: Text(
                    'Submit',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 15.0)),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => loginscreen()));
                  },
                  color: Colors.lightBlue[100],
                  child: Text(
                    'Login',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            // Padding(padding: EdgeInsets.only(top: 20)),
            // Center(
            //   child: Text(
            //     'Contact us',
            //     style: TextStyle(
            //         fontSize: 20.0,
            //         color: Colors.red,
            //         fontWeight: FontWeight.bold,
            //         decoration: TextDecoration.underline),
            //   ),
            // ),
            // TextButton(
            //     onPressed: () {
            //       _launchURL();
            //     },
            //     child: Text('Visit website'))
          ],
        ),
      ),
    ));
  }

  // _launchURL() async {
  //   const url = 'http://sahyog.site/';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Please wait $url';
  //   }
  // }
}
