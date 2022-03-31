import 'package:flutter/material.dart';
import 'package:sahyog_app/paynowdonate.dart';
import 'package:sahyog_app/universal.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: donateamount(),
  ));
}
class donateamount extends StatefulWidget {
  const donateamount({Key? key}) : super(key: key);


  @override
  _donateamountState createState() => _donateamountState();
}

class _donateamountState extends State<donateamount> {
  final amountcontroller = TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Choose to donate'),
        centerTitle: true,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(top: 120.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(padding: EdgeInsets.only(right: 10.0)),
                    Text(
                      'Amount :',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 20.0)),
                    Expanded(
                      child: Container(
                        height: 50,
                        width: 20,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: amountcontroller,
                          cursorColor: Colors.pink,
                          decoration: InputDecoration(
                            contentPadding:
                            EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 90.0)),
                MaterialButton(
                    color: Colors.green[300],
                    child: Text(
                      'Pay now',
                      style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      universaldata.transamount = amountcontroller.text;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => paynow()));
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
