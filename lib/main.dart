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

import 'homePage.dart';

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
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<FirebaseUser> handleSignIn() async {
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
      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
    }
    else {
      Fluttertoast.showToast(
        msg: "Sign in fail"
      );
      setState(() {
              isLoading = false;
            });
    }
    return firebaseUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget> [
          Center(
            child: GoogleSignInButton(
              onPressed: handleSignIn,
            ),
            ),
            Positioned(
              child: Center(
                              child: isLoading ?
                Container(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
                color: Colors.white.withOpacity(0.8),
                ):
                Container(),
              ),

            )
        ]
      )
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pride',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryTextTheme: TextTheme(title: TextStyle(color: Colors.black)),
      ),
      home: SignIn(),
    );
  }
}
