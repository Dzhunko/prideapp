import 'package:flutter/material.dart';
import 'package:prideapp/ui/Home.dart';
import './pages/today.dart';
import './pages/month.dart';
import './pages/settings.dart';
import 'ui/loginPage.dart';
import 'package:date_utils/date_utils.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';



void main(){
  new MaterialApp( theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => LoginPage(),
        '/todoscreen': (BuildContext context) => ToDayPage(),
        
      },
      debugShowCheckedModeBanner: false,
      home: LoginPage(),);
  initializeDateFormatting().then((_)=> runApp(HomePage()));
  
} 
