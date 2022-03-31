import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:sahyog_app/forgotpassword.dart';
import 'package:sahyog_app/homescreen.dart';
import 'package:sahyog_app/registrationscreen.dart';
import 'package:sahyog_app/universal.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: loginscreen(),
  ));
}

late SharedPreferences localstorage;

class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  _loginscreenState createState() => _loginscreenState();
  static init() async {
    localstorage = await SharedPreferences.getInstance();
  }
}

class _loginscreenState extends State<loginscreen> {
  bool ishiddenpassword = true;
  final mobilecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final pincodecontroller = TextEditingController();
  final citycontroller = TextEditingController();
  late SharedPreferences? logindata = null;
  late bool newuser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata?.getBool('login') ?? true);

    if (newuser == false) {
      universaldata.did = logindata!.getString('did')!;
      universaldata.dimage = logindata!.getString('dimage')!;
      universaldata.dname = logindata!.getString('dname')!;
      universaldata.demail = logindata!.getString('demail')!;
      universaldata.dmobile = logindata!.getString('dmobile')!;
      universaldata.dpassword = logindata!.getString('dpassword')!;
      universaldata.dcity = logindata!.getString('dcity')!;
      universaldata.dpincode = logindata!.getString('dpincode')!;
      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (context) {
        return dashboardscreen();
      }));
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    mobilecontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'custom/bg1.jpg',
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 45.0),
                  child: Image.asset(
                    'custom/3.jpeg',
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 50.0)),
                Stack(
                  children: [
                    SingleChildScrollView(
                      child: Form(
                        autovalidateMode: AutovalidateMode.always,
                        key: _formKey,
                        child: Container(
                          height: 280,
                          width: 300,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: TextFormField(
                                  style: TextStyle(fontSize: 15.0),
                                  controller: mobilecontroller,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.phone_android),
                                      hintText: 'mobile',
                                      border: InputBorder.none,
                                      fillColor: Colors.grey[100],
                                      filled: true,
                                      contentPadding: EdgeInsets.all(15.0)),
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: '*required'),
                                    MinLengthValidator(10,
                                        errorText: 'mobile'
                                            ' no. should be 10 digit')
                                  ]),
                                ),
                              ),
                              TextFormField(
                                style: TextStyle(fontSize: 15.0),
                                controller: passwordcontroller,
                                obscureText: ishiddenpassword,
                                decoration: InputDecoration(
                                    hintText: 'password',
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: InkWell(
                                      onTap: _togglePasswordView,
                                      child: Icon(
                                        Icons.visibility,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    fillColor: Colors.grey[100],
                                    filled: true,
                                    contentPadding: EdgeInsets.all(15.0)),
                                validator: MultiValidator([
                                  RequiredValidator(errorText: '*required')
                                ]),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ForgotPassword();
                                        }));
                                      },
                                      child: Text(
                                        'forgot password?',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              MaterialButton(
                                color: Colors.lightBlue[100],
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  if (mobilecontroller.text.length == 0) {
                                    Fluttertoast.showToast(
                                        msg: "Enter mobile no.",
                                        gravity: ToastGravity.BOTTOM,
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 2,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 13.0);
                                    return;
                                  }
                                  if (passwordcontroller.text.length == 0) {
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
                                  if (_formKey.currentState!.validate()) {
                                    Future<void> getdata() async {
                                      var req = await http.get(Uri.parse(
                                          'http://sahyogapp'
                                                  '.iotans'
                                                  '.in/api/dlogin?dmobile=' +
                                              mobilecontroller.text
                                                  .replaceAll(" ", "") +
                                              '&dpassword=' +
                                              passwordcontroller.text
                                                  .replaceAll(" ", "") +
                                              ''));

                                      if (req.body
                                          .contains(mobilecontroller.text)) {
                                        //For Sharedpreferance
                                        String mobile = mobilecontroller.text;
                                        String password =
                                            passwordcontroller.text;
                                        if (mobile != '' && password != '') {
                                          logindata?.setBool('login', false);

                                          logindata?.setString('mobile',
                                              mobilecontroller.text.toString());
                                          logindata?.setString(
                                              'password',
                                              passwordcontroller.text
                                                  .toString());
                                          logindata?.setString('email',
                                              emailcontroller.text.toString());
                                          logindata?.setString('mobile',
                                              mobilecontroller.text.toString());
                                          logindata?.setString('city',
                                              citycontroller.text.toString());
                                          logindata?.setString(
                                              'pincode',
                                              pincodecontroller.text
                                                  .toString());
                                        }

                                        //***********************

                                        universaldata.dpassword =
                                            passwordcontroller.text;
                                        var logindatastr = req.body.split(",");
                                        var did = logindatastr[0]
                                            .replaceAll("id", "")
                                            .replaceAll("\"", "");
                                        var dname = logindatastr[1]
                                            .replaceAll("name", "")
                                            .replaceAll("\"", "");
                                        var demail = logindatastr[2]
                                            .replaceAll("email", "")
                                            .replaceAll("\"", "");
                                        var dmobile = logindatastr[3]
                                            .replaceAll("mobile", "")
                                            .replaceAll("\"", "");
                                        var dpassword = logindatastr[4]
                                            .replaceAll("password", "")
                                            .replaceAll("\"", "");
                                        var dimage = logindatastr[5]
                                            .replaceAll("image", "")
                                            .replaceAll("\"", "");
                                        var dpincode = logindatastr[6]
                                            .replaceAll("pincode", "")
                                            .replaceAll("\"", "");
                                        var dcity = logindatastr[7]
                                            .replaceAll("city", "")
                                            .replaceAll("\"", "");

                                        universaldata.did =
                                            did.replaceAll(":", "");
                                        logindata?.setString(
                                            'id', universaldata.did);
                                        universaldata.dname =
                                            dname.replaceAll(":", "");
                                        logindata?.setString(
                                            'name', universaldata.dname);
                                        universaldata.demail =
                                            demail.replaceAll(":", "");
                                        logindata?.setString(
                                            'email', universaldata.demail);
                                        universaldata.dmobile =
                                            dmobile.replaceAll(":", "");
                                        logindata?.setString(
                                            'mobile', universaldata.dmobile);

                                        universaldata.dpassword =
                                            dpassword.replaceAll(":", "");
                                        logindata?.setString('password',
                                            universaldata.dpassword);
                                        universaldata.dimage =
                                            dimage.replaceAll(":", "");
                                        logindata?.setString(
                                            'image', universaldata.dimage);
                                        universaldata.dpincode =
                                            dpincode.replaceAll(":", "");
                                        logindata?.setString(
                                            'pincode', universaldata.dpincode);
                                        universaldata.dcity =
                                            dcity.replaceAll(":", "");
                                        logindata?.setString(
                                            'city', universaldata.dcity);

                                        Navigator.of(context).pop(true);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    dashboardscreen()));
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Please enter valid Credentials.",
                                            gravity: ToastGravity.BOTTOM,
                                            toastLength: Toast.LENGTH_SHORT,
                                            timeInSecForIosWeb: 2,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 13.0);
                                        return;
                                      }
                                    }

                                    getdata();
                                  }
                                },
                              ),
                              Padding(padding: EdgeInsets.only(top: 10.0)),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          registrationform()));
                                        },
                                        child: RichText(
                                            text: TextSpan(
                                                text: 'Create new account',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15.0,
                                                    decoration: TextDecoration
                                                        .underline))))
                                  ]),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ));
  }

  void _togglePasswordView() {
    setState(() {
      ishiddenpassword = !ishiddenpassword;
    });
  }
}
