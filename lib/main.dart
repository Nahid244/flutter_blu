import 'package:flutter/material.dart';
import 'package:flutter_app4/publicdata.dart';
import 'package:flutter_app4/two.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyApp_s();
  }

}
class MyApp_s extends State<MyApp>{
  bool loaded=false;
  String logGmail="shohel.debugbd@gmail.com";
  String logPass="123456";
  _login() async {
    String url = 'http://ams.mydbdsoft.com/api/auth/login';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"email": "' + logGmail + '", "password": "' + logPass + '"}';

    var response = await http.post(url, headers: headers, body: json);
    String body = response.body;
   // print(body);
    var data = jsonDecode(body);
    accesToken=data["access_token"];
    print(accesToken);
    setState(() {
      loaded=true;
    });

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(loaded==false){
      _login();
      return MaterialApp(
        home:Scaffold(
          backgroundColor: Colors.white,
          body:  Center(
            child: CircularProgressIndicator(),
          ),
        )
      );
    }
    else{
      return MaterialApp(
        home: Two(),
      );
    }

  }

}


  // This widget is the root of your application.

