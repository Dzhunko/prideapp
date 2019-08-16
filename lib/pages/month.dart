import 'package:flutter/material.dart';
import 'package:date_utils/date_utils.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';




class CalendarPageState extends StatelessWidget {
  @override
  Widget build (BuildContext context){
    Scaffold(
      body: Container(
      padding: EdgeInsets.all(25.0),
      child: TableCalendar(
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarStyle: CalendarStyle(
          selectedColor: Colors.black,
          todayColor: Colors.amber[800],
        ),
      ),
    ),
      floatingActionButton: new FloatingActionButton(
          onPressed: (){},
          backgroundColor: Colors.black,
          child: new Icon(Icons.add),
          ),
    );
  }
}
 