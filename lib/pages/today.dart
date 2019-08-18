import 'package:flutter/material.dart';
import 'package:prideapp/ui/todo_screen.dart';

class DecoratedTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        child: TextField(
          autofocus: true,
          decoration: InputDecoration.collapsed(
            hintText: 'What are we doing today?',
          ),
        ));
  }
}


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
              showBottomSheet(                
                context: context, 
                builder: (context) {
                return Container(
                  height: 250,
                  child: new Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 125,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          boxShadow: [
                            BoxShadow (
                              blurRadius: 10, color: Colors.grey[300], spreadRadius: 5),
                          ]
                        ),
                        child: Column(
                          children: <Widget>[
                            DecoratedTextField(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: ImageIcon(new AssetImage('images/creating_task_icon/undercell.png')),
                                  color: Colors.black,
                                  iconSize: 36.0,
                                ),
                                IconButton(
                                  icon: ImageIcon(new AssetImage('images/creating_task_icon/time.png')),
                                  color: Colors.black,
                                  iconSize: 36.0,
                                ),
                                IconButton(
                                  icon: ImageIcon(new AssetImage('images/creating_task_icon/importance.png')),
                                  color: Colors.black,
                                  iconSize: 36.0,
                                ),
                                IconButton(
                                  icon: ImageIcon(new AssetImage('images/creating_task_icon/cycle.png')),
                                  color: Colors.black,
                                  iconSize: 36.0,
                                ),
                                IconButton(
                                  //icon: Icon(Icons.arrow_forward_ios),
                                  icon: ImageIcon(new AssetImage('images/creating_task_icon/create_task.png')),
                                  //color: Colors.amber[800],
                                  iconSize: 36.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),             
                    ]
                      )
                );
                }
              );
              
             }
}
