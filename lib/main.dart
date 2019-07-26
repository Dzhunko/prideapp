import 'package:flutter/material.dart';
import './today.dart';
import './month.dart';
import './settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      
      return MyAppState();
    }
}
  
class MyAppState extends State<MyApp> {
  int _selectedPage = 0;
  final _pageOptions= [
    ToDayPageState(),
    CalendarPageState(),
    SettingsPageState(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryTextTheme: TextTheme(title: TextStyle(color: Colors.black)),
      ),
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Pride App'),
          backgroundColor: Colors.white,
          ),
        body:  _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          selectedItemColor: Colors.amber[800],
          onTap: (int index){
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(new AssetImage('images/menu_icon/day.png')),
              //icon: Icon(Icons.format_list_bulleted),
              title: Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(new AssetImage('images/menu_icon/calendar.png')),
              title: Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(new AssetImage('images/menu_icon/settings.png')),
              title: Container(height: 0.0),
            ),
          ],
        ),
      ),
    );
  }
}


