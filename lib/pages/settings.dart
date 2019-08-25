import 'package:flutter/material.dart';




class SettingsPageState extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
	body: new Container(
        padding: EdgeInsets.all(25.0),
        child: Text('Settings', style: TextStyle(fontSize: 36.0),),
      ),
      );
  }
}