import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prideapp/pages/today.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences preferences ; 
  bool loading = false;
  bool isLogedin = false;
  @override
  void initState(){
    super.initState();
    isSignedIn();
  }
  void isSignedIn() async{
   setState(() {
     loading = true;
   });

   preferences = await SharedPreferences.getInstance();
   isLogedin = await googleSignIn.isSignedIn();
   if(isLogedin){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ToDayPage()));
   }

   setState(() {
     loading = false;

   });
  }

  Future handleSignIn() async{
 preferences = await SharedPreferences.getInstance();

 setState(() {
   loading = true;
 });

 GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
 GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
 FirebaseUser firebaseUser = await firebaseAuth.signInWithGoogle(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);

 if(firebaseUser != null){
  final QuerySnapshot result = await FireStore.instance.collection("users").where("id", isEqualTo: firebaseUser.uid).getDocuments();
  final List<DocumentSnapshot> documents = result.documents;
  if(documents.length == 0){
    FireStore.instance.collection("users").dociment(firebaseUser.uid).setData({
      "id": firebaseUser.uid,
      "username": firebaseUser.displayName,
      "profilePicture": firebaseUser.photoUrl
    });
    await preferences.setString("id", firebaseUser.uid);
    await preferences.setString("username", firebaseUser.displayName);
    await preferences.setString("photoPicture", firebaseUser.displayName);
  }
  else{
    await preferences.setString("id", documents[0]['id']);
    await preferences.setString("username", documents[0]['username']);
    await preferences.setString("photoPicture", documents[0]['photoUrl']);
  }
  Fluttertoast.showToast(msg:"Login was successful");
  setState(() {
    loading = false;
  });
  
 }
 else{

 }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF44336),

        title: Text(
          "Prideapp",
          style: TextStyle(
              fontSize: 25.0, fontWeight: FontWeight.w700, letterSpacing: 1.66),
        ),
        // leading: Text(""),
        centerTitle: true,
      ),
      body: Stack(
      children: <Widget>[
        Center(
          child: FlatButton(
            color: Colors.black,
            onPressed: (){
             handleSignIn();
             child: Text("Sign in / Sign up with google", style: TextStyle(color: Colors.white));
            },
          ),
          ),
          Visibility(
            visible: loading ?? true,
            child: Container(
              color: Colors.white.withOpacity(0.7),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
               ),
              )
              )

      ],
                  
      )
    );
             
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((FirebaseUser user) {
        print(user.email);
        Navigator.of(context).pop();
        
        Navigator.of(context).pushReplacementNamed('/todoscreen');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ToDayPage()));
      }).catchError((e) {
        print(e);
      });
    }
  }
}
