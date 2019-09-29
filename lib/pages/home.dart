import 'package:flutter/material.dart';


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
  String result = "";
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
                  height: 200,
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
                             new TextField(
                             onChanged: (String str){
                               setState(() {
                                result = str; 
                                // вот текст, введенный с клавы
                               });
                             }
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.format_list_bulleted),
                                  color: Colors.black,
                                  iconSize: 24.0,
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(Icons.access_time),
                                  color: Colors.black,
                                  iconSize: 24.0,
                                  onPressed: () {},
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.pin_drop),
                                  iconSize: 24.0,
                                  color: Colors.black,
                                ),
                                IconButton(
                                  icon: Icon(Icons.refresh),
                                  color: Colors.black,
                                  iconSize: 24.0,
                                  onPressed: () {},
                                ),
                                IconButton(
                                  //icon: Icon(Icons.arrow_forward_ios),
                                  icon: Icon(Icons.arrow_forward_ios),
                                  color: Colors.amber,
                                  iconSize: 24.0,
                                  onPressed: () {},
                                ),
                                IconButton(
                                  //icon: Icon(Icons.arrow_forward_ios),
                                  icon: Icon(Icons.arrow_forward_ios),
                                  color: Colors.amber,
                                  iconSize: 24.0,
                                  onPressed: () {
                                    new Text(result);
                                    //здесь мы его сохраняем
                                  },
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
