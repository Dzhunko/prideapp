import 'package:flutter/material.dart';
import './pages/today.dart';
import './pages/month.dart';
import './pages/settings.dart';
import 'package:date_utils/date_utils.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:bmnav/bmnav.dart' as bmnav;



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
  Widget currentScreen = ToDayPage();
  final _pageTitle=[
    'Today',
    'Month',
    'Settings',
  ];
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
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(_pageTitle[_selectedPage]),
          backgroundColor: Colors.white,
        ),
        drawer: Drawer(
          child: ListView(),
        ),
        backgroundColor: Colors.white,
        body:  _pageOptions[_selectedPage],
        bottomNavigationBar: bmnav.BottomNav(
          index: _selectedPage,
          onTap: (i) {
            setState(() {
              _selectedPage = i;
              currentScreen = _pageOptions[i];
                        });
          },
			     labelStyle: bmnav.LabelStyle(showOnSelect: true, onSelectTextStyle: TextStyle(color: Colors.amber)),
           iconStyle: bmnav.IconStyle(onSelectSize: 36.0, color: Colors.black, onSelectColor: Colors.amber, size: 32.0),
			items: [
				bmnav.BottomNavItem(Icons.home, label: 'Home'),
				bmnav.BottomNavItem(Icons.calendar_today, label: 'Calendar'),
				bmnav.BottomNavItem(Icons.settings, label: 'Settings'),				
			],
		),
	
        
      ),
    );
  }
}