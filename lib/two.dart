import 'package:flutter/material.dart';
import 'package:flutter_app4/publicdata.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
class Two extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Two_State();
  }

}
class Two_State extends State<Two>{
  FlutterBlue flutterBlue=FlutterBlue.instance;
  BluetoothDevice device;
  BluetoothState statee;
  BluetoothDeviceState deviceState;
  bool foundDevice=false;
  // List<BluetoothDevice> devices = [];
  List<String> devics=[];


  _send() async {
    String url = 'http://ams.mydbdsoft.com/api/auth/attendance';
    Map<String, String> headers = {"Content-type": "application/json",'Accept': 'application/json', 'Authorization': 'Bearer $accesToken',};
   // String json = '{"email": "' + logGmail + '", "password": "' + logPass + '"}';

    var response = await http.post(url, headers: headers);
    String body = response.body;
     print(body);
    var data = jsonDecode(body);


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    flutterBlue.state.listen((state) {
      statee=state;


      //print("sddf");
      if (state == BluetoothState.on ) {

       _showDialog("sd");


//        flutterBlue.startScan();
//        flutterBlue.scanResults.listen((res){
//          devics.clear();
//          setState(() {
//            for(var i in res ){
//              devics.add(i.device.name);
//            }
//          });
//        });
//        flutterBlue.stopScan();

      }
      else{

        setState(() {
          devics.clear();
        });
      }
    });

  }

  // Store the [devices] list in the [_devicesList] for accessing
  // the list outside this class
  void _showDialog(String title){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          contentPadding: EdgeInsets.all(0),
          content:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            FlatButton(
                  color: Colors.green,
                  textColor: Colors.black,

                  // disabledColor: Colors.grey,
                  // disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      side: BorderSide(color: Colors.black)
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Close"),
                ),

            FlatButton(
                color: Colors.green,
                textColor: Colors.black,

                // disabledColor: Colors.grey,
                // disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                    side: BorderSide(color: Colors.black)
                ),
                onPressed: () {
                  _send();
                  Navigator.of(context).pop();
//                  print(DateTime.now().hour);
//                  print(DateTime.now().minute);
                },
                child: Text("Close"),
              ),

//          Flexible(
//            flex: 1,
//            child:FlatButton(
//              color: Colors.green,
//              textColor: Colors.black,
//
//              // disabledColor: Colors.grey,
//              // disabledTextColor: Colors.black,
//              padding: EdgeInsets.all(8.0),
//              splashColor: Colors.blueAccent,
//              shape: RoundedRectangleBorder(
//                  borderRadius: new BorderRadius.circular(50.0),
//                  side: BorderSide(color: Colors.black)
//              ),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//              child: Text("Close"),
//            ),
//          ),
//          ),
//              Flexible(
//                flex: 1,
//                child:FlatButton(
//                  color: Colors.green,
//                  textColor: Colors.black,
//
//                  // disabledColor: Colors.grey,
//                  // disabledTextColor: Colors.black,
//                  padding: EdgeInsets.all(8.0),
//                  splashColor: Colors.blueAccent,
//                  shape: RoundedRectangleBorder(
//                      borderRadius: new BorderRadius.circular(50.0),
//                      side: BorderSide(color: Colors.black)
//                  ),
//                  onPressed: () {
//                    Navigator.of(context).pop();
//                  },
//                  child: Text("Close"),
//                ),
//              )
            ],
          )

          ,
//          actions: <Widget>[
//            // usually buttons at the bottom of the dialog
//            new FlatButton(
//              color: Colors.green,
//              textColor: Colors.black,
//
//              // disabledColor: Colors.grey,
//              // disabledTextColor: Colors.black,
//              padding: EdgeInsets.all(8.0),
//              splashColor: Colors.blueAccent,
//              shape: RoundedRectangleBorder(
//                  borderRadius: new BorderRadius.circular(50.0),
//                  side: BorderSide(color: Colors.black)
//              ),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//              child: Text("Close"),
//            ),
//          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return
       Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.refresh), onPressed: () {
               setState(() {

               });
//                Fluttertoast.showToast(
//                    msg: statee.toString(),
//                    toastLength: Toast.LENGTH_SHORT,
//                    gravity: ToastGravity.CENTER,
//                    timeInSecForIosWeb: 1,
//                    backgroundColor: Colors.red,
//                    textColor: Colors.white,
//                    fontSize: 16.0
//                );
              },)
            ],
          ),
          body:SingleChildScrollView(
              child:  Column(
                children:List.generate(devics.length, (index){
                  return  Container(
                    //height: MediaQuery.of(context).size.height/8,
                    margin: new EdgeInsets.all(20.0),
                    decoration: new BoxDecoration(
                      color: Colors.green.withOpacity(0.9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          blurRadius: 10.0, // has the effect of softening the shadow
                          spreadRadius: 5.0, // has the effect of extending the shadow
                          offset: Offset(
                            0, // horizontal, move right 10
                            7, // vertical, move down 10
                          ),
                        )
                      ],

                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.bookmark),
                        Padding(padding: EdgeInsets.only(right: 30)),
                        Text(devics[index].toString(),style: TextStyle(fontSize: 20),),

                      ],
                    ),

                  );
                }),
              )
          )
    );
  }
}

