import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class ShaSpnView extends StatefulWidget {
  const ShaSpnView({Key? key}) : super(key: key);

  @override
  _ShaSpnViewState createState() => _ShaSpnViewState();
}

class _ShaSpnViewState extends State<ShaSpnView> {

  String txtCrypto="";
  TextEditingController txtCryptoCont=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var x = MediaQuery.of(context).size.width;
    var y = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Container(
              width: x*0.8,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Text Girin',),
                controller: txtCryptoCont,
              ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      rsa256(txtCryptoCont.text);
                    });
                  },
                  child: Text("Sha256"),
                ),
                RaisedButton(
                  onPressed: () {
                    setState(() {


                    spnPermutationEncode(txtCryptoCont.text);
                    });
                  },
                  child: Text("SPN"),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.all(30),
              width: x*0.8,
              height: y*0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.amber.shade100
              ),
              child: Center(child: Text(txtCrypto)),)
          ],
        ),
      ),
    );
  }

  void rsa256(String value) {
    var key = utf8.encode('p@ssw0rd');
    var bytes = utf8.encode(value);

    var hmacSha256 = Hmac(sha256, key); 
    var digest = hmacSha256.convert(bytes);
    txtCrypto= digest.toString();
  }

  void spnPermutationEncode(String plainText) {
    // key 4231
    String newValue = "";
    String temp;
    String temp2;
    String temp3;
    String temp4;
    int mod;
    mod = plainText.length % 4;
    for (int i = 0; i < plainText.length - mod;) {
      temp = plainText[i];
      temp2 = plainText[i + 1];
      temp3 = plainText[i + 2];
      temp4 = plainText[i + 3];
      newValue += temp4 + temp2 + temp3 + temp+plainText.substring(plainText.length-mod,plainText.length);
      i = i + 4;
    }
    txtCrypto= newValue;
  }
}
