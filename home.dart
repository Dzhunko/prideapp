import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ToDayPage extends StatefulWidget {
  final FirebaseUser user;
  ToDayPage({Key key, this.user});
  ToDayPageState createState() => ToDayPageState();
}

class ToDayPageState extends State<ToDayPage>
    with SingleTickerProviderStateMixin {
  FirebaseUser user;

  final _cloudFirestore = Firestore.instance.collection('todos').snapshots();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _textController = TextEditingController();
  final uid = Firestore.instance.collection('users').document().documentID;
  bool active = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: StreamBuilder(
        stream: _cloudFirestore,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                return Container(
                  child: Dismissible(
                    resizeDuration: Duration(milliseconds: 1000),
                    secondaryBackground: Card(
                      
                      child: Container(
                        // color: Colors.black26,
                        
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {},
                          color: Colors.redAccent,
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    ),
                    background: Card(
                      

                      // shape: BeveledRectangleBorder(
                      //     borderRadius: BorderRadius.circular(50.0)),
                      child: Container(
                        // color: Colors.black26,
                        
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {},
                          color: Colors.redAccent,
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    ),
                    key: Key(Firestore.instance
                        .collection('users')
                        .document()
                        .documentID),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Card(
                        
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Center(
                              child: ListTile(
                                onTap: () {
                                  print("List tile tapped!");
                                  print(Firestore.instance
                                      .collection('todos')
                                      .document());
                                },
                                title: Text(
                                  ds['task'].toString(),
                                  style: TextStyle(),
                                ),
                                
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      print("${ds['task']} is deleted");
                      Firestore.instance
                          .collection('todos')
                          .document(ds.documentID)
                          .delete();
                      // Working on showing snackbar when an item is deleted
                      // Scaffold.of(context).showSnackBar(SnackBar(
                      //   content: Text(ds['task'].toString()),
                      //   action: SnackBarAction(
                      //     label: "Undo",
                      //     onPressed: () {
                      //       Firestore.instance.collection('todos').add({
                      //         'task': ds['task'] == null
                      //             ? CircularProgressIndicator()
                      //             : ds['task'].toString()
                      //       });
                      //     },
                      //   ),
                      // ));
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 9.0,
        child: Icon(Icons.add),
        // backgroundColor: Colors.redAccent,
        backgroundColor: Color(0xFFF44336),
        onPressed: () {
          _showFormDialog();
        },
      ),
    );
  }

  _showFormDialog() {
    showBottomSheet(
        context: context,
        builder: (context) {
          return Form(
            key: _formkey,
              child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                       
                        height: 125,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.grey[300],
                                  spreadRadius: 5),
                            ]),
                        child: ListTile(
                            title: TextFormField(
                                controller: _textController,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'please enter something';
                                  }
                                  return null;
                                }))),
                    Row(children: <Widget>[
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
              child: Text("Save"),
              onPressed: () {
                if (_formkey.currentState.validate()) {
                  _handleSubmit();

                  _textController.clear();

                  Navigator.of(context).pop();
                }
              },
            )
                    ]),
                  ]));
          
        });
  }

  void _handleSubmit() {
    if (Firestore.instance.collection('todos').document() == null) {
      Firestore.instance.collection('todos').document().setData({"task": ""});
    } else {
      Firestore.instance
          .collection('todos')
          .document()
          .setData({'task': _textController.text.toString()});
      debugPrint("Item added");
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut().then((val) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/');
    }).catchError((e) {
      print(e);
    });
  }
}
