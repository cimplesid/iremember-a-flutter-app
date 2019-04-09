import 'package:flutter/material.dart';
import 'ui/pages/home.dart';
import 'dart:async';
import 'ui/pages/login.dart';
import 'ui/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'ui/pages/itemdetail.dart';
// import 'ui/pages/additem.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'subscribe to pewdiepie',
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context,AsyncSnapshot<FirebaseUser> snapshot){
          if(!snapshot.hasData)return LoginPage();
          if(snapshot.hasData){
            if(snapshot.data!=null){
              if(snapshot.hasData)
              return  HomePage();
              else return CircularProgressIndicator();
            }else{
              return Scaffold(body:LoginPage());
            }
          }
        },
      ),
     // SplashScreen(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      routes: {
        "builder": (_) => HomePage(),
        "signup": (_) => SignupPage(),
      },
      
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginPage()));
    //  Navigator.of(context).pushReplacementNamed('_');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: new Center(
        child: Icon(
          Icons.whatshot,
          size: 200.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
// ->detail view
// ->item
//  .Title
//  .descripion
//  .picture
