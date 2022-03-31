import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sahyog_app/loginscreen.dart';
import 'package:sahyog_app/universal.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: updateprofile(),
    ));

class updateprofile extends StatefulWidget {
  const updateprofile({Key? key}) : super(key: key);

  @override
  _updateprofileState createState() => _updateprofileState();
}

class _updateprofileState extends State<updateprofile> {
  get updatedetails => null;

  @override
  void initState() {
    namecontroller.text = universaldata.dname;
    emailcontroller.text = universaldata.demail;
    mobilecontroller.text = universaldata.dmobile;
    citycontroller.text = universaldata.dcity;
    pincodecontroller.text = universaldata.dpincode;
    super.initState();
  }

  late XFile? uploadimage = null;

  //variable for choosed file
  var isimgselected = false;
  Future<void> opengallery() async {
    // ignore: deprecated_member_use
    var choosedimage =
        await new ImagePicker().pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      isimgselected = true;
      uploadimage = choosedimage as XFile;
    });
  }

  Future<void> openCamera() async {
    // ignore: deprecated_member_use
    var choosedimage =
        await new ImagePicker().pickImage(source: ImageSource.camera);
    this.setState(() {
      isimgselected = true;
      uploadimage = choosedimage as XFile;
    });
  }

  Upload(XFile imageFile) async {
    // ignore: deprecated_member_use
    var stream = new http.ByteStream(
        // ignore: deprecated_member_use
        DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(
        "http://sahyogapp.iotans.in/api/deditprofile?did=" + universaldata.did);

    var request = new http.MultipartRequest("POST", uri);
    request.fields["did"] = universaldata.did.replaceAll(":", "");
    request.fields["dname"] = namecontroller.text.replaceAll(":", "");
    request.fields["demail"] = emailcontroller.text.replaceAll(":", "");
    request.fields["dmobile"] = mobilecontroller.text.replaceAll(":", "");
    request.fields["dcity"] = citycontroller.text.replaceAll(":", "");
    request.fields["dpincode"] = pincodecontroller.text.replaceAll(":", "");

    var multipartFile = new http.MultipartFile('dimaged', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.files.add(multipartFile);
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      if (value.contains("Profile updated successfully!!")) {
        Fluttertoast.showToast(
            msg: " Details updated Successfully.",
            gravity: ToastGravity.SNACKBAR,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 15.0);
        uploadimage = new File("") as XFile;
      }
    });
  }

  //update details without image
  Uploadwithoutimage() async {
    // ignore: deprecated_member_use

    // print("didd"+universaldata.did);
    var uri = Uri.parse("http://sahyogapp.iotans.in/api/dedittextprofile/" +
        '?did=' +
        universaldata.did +
        '?dname=' +
        universaldata.dname +
        '?demail=' +
        universaldata.demail +
        '?dmobile=' +
        universaldata.dmobile +
        '?dpincode=' +
        universaldata.dpincode +
        '?dcity=' +
        universaldata.dcity);
    var request = new http.MultipartRequest("POST", uri);
    request.fields["dname"] = namecontroller.text.replaceAll(":", "");
    request.fields["demail"] = emailcontroller.text.replaceAll(":", "");
    request.fields["dmobile"] = mobilecontroller.text.replaceAll(":", "");
    request.fields["dcity"] = citycontroller.text.replaceAll(":", "");
    request.fields["dpincode"] = pincodecontroller.text.replaceAll(":", "");

    //contentType: new MediaType('image', 'png'));
    var response = await request.send();
    print("vall  " + response.toString());
    response.stream.transform(utf8.decoder).listen((value) {
      if (value.contains("Profile updated successfully")) {
        Fluttertoast.showToast(
            msg: " Details updated Successfully.",
            gravity: ToastGravity.BOTTOM_LEFT,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 15.0);
      }
    });
  }

  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final mobilecontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final pincodecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update profile'),
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
        child: ListView(
          children: [
            Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 10.0)),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'http://sahyogapp.iotans.in/UploadDocs/' +
                                      universaldata.dimage),
                            )),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white10, width: 1)),
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  _showDialog();
                                },
                              )))
                    ],
                    // InkWell(
                    //   onTap: _showDialog,
                    //   child: CircleAvatar(
                    //     backgroundColor: Colors.black,
                    //     radius: 60.0,
                    //     child: CircleAvatar(
                    //       radius: 70.0,
                    //       child: ClipOval(
                    //         child: (uploadimage != null)
                    //             ? Image.file(Upload(uploadimage!))
                    //             : Image.network('http://sahyogapp.iotans.in/UploadDocs/' + universaldata.dimage),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10.0)),
                TextFormField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                      labelText: universaldata.dname.replaceAll(":", ""),
                      contentPadding: EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
                      labelStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 10.0)),
                TextFormField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                      labelText: universaldata.demail.replaceAll(":", ""),
                      contentPadding: EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
                      labelStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 10.0)),
                TextFormField(
                  controller: mobilecontroller,
                  decoration: InputDecoration(
                      labelText: universaldata.dmobile.replaceAll(":", ""),
                      contentPadding: EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
                      labelStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 10.0)),
                TextFormField(
                  controller: citycontroller,
                  decoration: InputDecoration(
                      labelText: universaldata.dcity.replaceAll(":", ""),
                      contentPadding: EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
                      labelStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 10.0)),
                TextFormField(
                  controller: pincodecontroller,
                  decoration: InputDecoration(
                      labelText: universaldata.dpincode.replaceAll(":", ""),
                      contentPadding: EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
                      labelStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 25.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                        color: Colors.lightBlue[100],
                        child: Text('Update',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          if (isimgselected == true) {
                            Upload(uploadimage!);
                          } else {
                            Uploadwithoutimage();
                          }
                          Navigator.push(
                              this.context,
                              MaterialPageRoute(
                                  builder: (context) => loginscreen()));
                        }),
                    Padding(padding: EdgeInsets.only(right: 20.0)),
                    MaterialButton(
                        color: Colors.lightBlue[100],
                        child: Text('Cancel',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold)),
                        onPressed: () {})
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showDialog() {
    // ignore: missing_return
    return showDialog(
        context: this.context,
        builder: (BuildContext) {
          return AlertDialog(
              title: Text('Do You want to Take Photo From?'),
              content: SingleChildScrollView(
                  child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text('Gallery'),
                    onTap: () {
                      opengallery();
                      Navigator.of(this.context).pop(false);
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 8.0)),
                  GestureDetector(
                    child: Text('Camera'),
                    onTap: () {
                      openCamera();
                      Navigator.of(this.context).pop(false);
                    },
                  )
                ],
              )));
        });
  }
}
