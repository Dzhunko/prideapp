import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Pages
import './pages/home.dart';
import './pages/month.dart';
import './pages/settings.dart';

import 'package:date_utils/date_utils.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:bmnav/bmnav.dart' as bmnav;
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

//Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  new MaterialApp(
    debugShowCheckedModeBanner: false,
  );
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class SignIn extends StatefulWidget {
  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool isLoading = false;
  bool isLogged = false;

  SharedPreferences prefs;
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    isSignIn();
  }

  void isSignIn() async {
    setState(() {
      isLoading = true;
    });
    prefs = await SharedPreferences.getInstance();

    isLogged = await _googleSignIn.isSignedIn();
    if (isLoading) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SettingsPageState()));
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<Null> handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;

    if (firebaseUser != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection('user')
          .where('id', isEqualTo: firebaseUser.uid)
          .getDocuments();

      List<DocumentSnapshot> documents = result.documents;
      if(documents.length == 0) {
        Firestore.instance.collection('user').document(firebaseUser.uid).setData({
          'id': firebaseUser.uid,
          'username': firebaseUser.displayName,
          'photoUrl': firebaseUser.photoUrl
        });

        //Data to local
        currentUser = firebaseUser;
        await prefs.setString('id', currentUser.uid);
        await prefs.setString('username', currentUser.displayName);
        await prefs.setString('photoUrl', currentUser.photoUrl);
      }
      else {
        await prefs.setString('id', documents[0]['id']);
        await prefs.setString('username', documents[0]['username']);
        await prefs.setString('photoUrl', documents[0]['photoUrl']);
      }
      Fluttertoast.showToast(
        msg: "Sign in success"
      );
      setState(() {
              isLoading = false;
            });
      Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPageState()));
    }
    else {
      Fluttertoast.showToast(
        msg: "Sign in fail"
      );
      setState(() {
              isLoading = false;
            });
    }
  }

  @override
  Widget build(BuildContext context) {}
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
  final _pageTitle = [
    'Today',
    'Month',
    'Settings',
  ];
  final _pageOptions = [
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
            bmnav.BottomNavItem(Icons.calendar_today, label: 'Calendar'),
            bmnav.BottomNavItem(Icons.settings, label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
