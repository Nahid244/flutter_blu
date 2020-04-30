import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return My();
  }
  // This widget is the root of your application.
  
}
class My extends State<MyApp>{
   FlutterBlue flutterBlue=FlutterBlue.instance;
   BluetoothDevice device;
   BluetoothState statee;
   BluetoothDeviceState deviceState;
  // List<BluetoothDevice> devices = [];
List<String> devics=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    flutterBlue.state.listen((state) {
      statee=state;
      devics.clear();
      if (state == BluetoothState.on) {

        flutterBlue.startScan();
        flutterBlue.scanResults.listen((res){
          setState(() {
            for(var i in res ){
              devics.add(i.device.name);
            }
          });
        });
        flutterBlue.stopScan();

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

      @override
      Widget build(BuildContext context) {

        // TODO: implement build
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
            backgroundColor: Colors.red,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.refresh), onPressed: () {

                Fluttertoast.showToast(
                    msg: statee.toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
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
          ),
        );
      }
    }

