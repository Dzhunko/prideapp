import 'package:flutter/material.dart';



class SettingsPageState extends StatelessWidget {
  @override
  Widget build (BuildContext context){
    return Scaffold(/*appBar: AppBar(
    title: Text('Settings'),
    backgroundColor: Colors.white
    ),*/
    body: Container(
      padding: EdgeInsets.all(25.0),
      child: Text('Settings', style: TextStyle(fontSize: 36.0),),
    )
    
    );
  }
}