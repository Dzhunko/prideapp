import 'package:flutter/material.dart';
import './Pages/page1.dart';
import './Pages/page2.dart';
import './Pages/page3.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return MyAppState();
    }
}
  
class MyAppState extends State<MyApp>{
  int _selectedPage = 0;
  final _pageOptions = [
    Page1(),
    Page2(),
    Page3(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pride',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('All tasks'),),
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
                          _selectedPage = index;
                        });

          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.landscape),
              title: Text(''),
            ),
          ],
        ),
        ),
    );
  }
}

