import 'package:flutter/material.dart';
import 'package:prideapp/ui/todo_screen.dart';


class ToDayPage extends StatefulWidget {
  @override
  ToDayPageState createState() => ToDayPageState();
}

class ToDayPageState extends State<ToDayPage>{
  @override
  Widget build (BuildContext context){
    Scaffold(
      body: TodoScreen(),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Add Item',
        onPressed: _showFormDialog,
        backgroundColor: Colors.black,
        child: new Icon(Icons.add),
                    ),
              );
            }
          
            void _showFormDialog() {
  }
}
