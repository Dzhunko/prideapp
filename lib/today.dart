import 'package:flutter/material.dart';



class ToDayPageState extends StatelessWidget {
  @override
  Widget build (BuildContext context){
    return Scaffold(appBar: AppBar(
    title: Text('Today tasks'),
    backgroundColor: Colors.white
    ),
    
    
    body: Container(
      padding: EdgeInsets.all(25.0),
      child: Text('Today tasks', style: TextStyle(fontSize: 36.0),),
    ),
    );
  }
}