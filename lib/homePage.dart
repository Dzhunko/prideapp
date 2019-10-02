import 'package:flutter/material.dart';

//Pages
import './pages/home.dart';
import './pages/month.dart';
import './pages/settings.dart';

//Firebase
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:bmnav/bmnav.dart' as bmnav;

import 'main.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState()=> HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedPage = 0;
  Widget currentScreen = ToDayPage();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isLoading = false;
  
  Future<Null> handleSignOut() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();

    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> MyApp()),
    (Route<dynamic> route)=> false);
  }
  final _pageTitle = [
    'Home',
    'Projects',
    'Profile',
  ];
  final _pageOptions = [
    //ToDayPageState(),
    ToDayPage(),
    CalendarPageState(),
    SettingsPageState(),
  ];
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(_pageTitle[_selectedPage]),
          backgroundColor: Colors.white,
        ),
        drawer: Drawer(
          child: RaisedButton(
            onPressed: handleSignOut,
            child: Text("Sign out", style: TextStyle(color:Colors.white),),
          ),
        ),
        backgroundColor: Colors.white,
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: bmnav.BottomNav(
          index: _selectedPage,
          onTap: (i) {
            setState(() {
              _selectedPage = i;
              currentScreen = _pageOptions[i];
            });
          },
          labelStyle: bmnav.LabelStyle(
              showOnSelect: true,
              onSelectTextStyle: TextStyle(color: Colors.amber)),
          iconStyle: bmnav.IconStyle(
              onSelectSize: 36.0,
              color: Colors.black,
              onSelectColor: Colors.amber,
              size: 32.0),
          items: [
            bmnav.BottomNavItem(Icons.home, label: 'Home'),
            bmnav.BottomNavItem(Icons.class_, label: 'Projects'),
            bmnav.BottomNavItem(Icons.account_circle, label: 'Profile'),
          ],
        ),
    );
  }
  //
}