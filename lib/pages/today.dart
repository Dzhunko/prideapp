import 'package:flutter/material.dart';
import 'package:prideapp/ui/todo_screen.dart';


class ToDayPage extends StatefulWidget {
  @override
  ToDayPageState createState() => ToDayPageState();
}

class ToDayPageState extends State<ToDayPage>{
  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: new Container(
        padding: EdgeInsets.all(25.0),
        child: Text('Today tasks', style: TextStyle(fontSize: 36.0),),
      ),
      //TodoScreen(),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Add Item',
        onPressed: _showFormDialog,
        backgroundColor: Colors.black,
        child: new Icon(Icons.add),
                    ),
              );
            }
          
            void _showFormDialog() {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
                context: context, 
                builder: (context) {
                return Container(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: TextField(
                      autofocus: true,
                    ),
                  ),
                );
              }
              );
             }
}
