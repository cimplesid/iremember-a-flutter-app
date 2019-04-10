import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../resources/firebase_auth_provider.dart';
import 'login.dart';
class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _emailc = TextEditingController();

  final TextEditingController _passwordc = TextEditingController();

  final TextEditingController _confirmpassc = TextEditingController();

  Widget _buildPageContent() {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.grey.shade800,
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Container(
                height: 100,
                child: Text(
                  "Signup".toUpperCase(),
                  style: TextStyle(
                      color: Colors.pink,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ListTile(
                  title: TextField(
                controller: _emailc,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Email address:",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.email,
                      color: Colors.white30,
                    )),
              )),
              Divider(
                color: Colors.grey.shade600,
              ),
              ListTile(
                  title: TextField(
                controller: _passwordc,
                style: TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password:",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.lock,
                      color: Colors.white30,
                    )),
              )),
              Divider(
                color: Colors.grey.shade600,
              ),
              ListTile(
                  title: TextField(
                style: TextStyle(color: Colors.white),
                controller: _confirmpassc,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Confirm Password:",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.lock,
                      color: Colors.white30,
                    )),
              )),
              Divider(
                color: Colors.grey.shade600,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: _signup,
                      color: Colors.cyan,
                      child: Text(
                        'Signup',
                        style: TextStyle(color: Colors.white70, fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _signup() async {


    try {
      FirebaseUser user =
          await FirebaseAuthProvider().signup(_emailc.text, _passwordc.text);

      if (user == null) {
        print('signup failed');
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
      }
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(),
    );
  }
}
