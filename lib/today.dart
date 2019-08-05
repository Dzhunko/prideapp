import 'package:flutter/material.dart';

class ToDayPage extends StatefulWidget {
  @override
  ToDayPageState createState() => ToDayPageState();
}

class ToDayPageState extends State<ToDayPage>{
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