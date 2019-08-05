import 'package:flutter/material.dart';
import './today.dart';
import './month.dart';
import './settings.dart';
import 'package:date_utils/date_utils.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';


void main(){
  new MaterialApp(debugShowCheckedModeBanner: false,);
  initializeDateFormatting().then((_)=> runApp(MyApp()));
  
} 


class MyApp extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      
      return MyAppState();
    }
}
  
class MyAppState extends State<MyApp> {
  int _selectedPage = 0;
  final _pageOptions= [
    //ToDayPageState(),
    ToDayPage(),
    CalendarPageState(),
    SettingsPageState(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pride',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryTextTheme: TextTheme(title: TextStyle(color: Colors.black)),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
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
              title: Container(height: 0.0)
              //icon: Icon(Icons.format_list_bulleted),
              
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(new AssetImage('images/menu_icon/calendar.png')),
              title: Container (height: 0.0)
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(new AssetImage('images/menu_icon/settings.png')),
              title: Container(height: 0.0)
            ),
          ],
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: (){},
          backgroundColor: Colors.black,
          child: new Icon(Icons.add),
          ),
      ),
    );
  }
}