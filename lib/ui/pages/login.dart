import 'package:flutter/material.dart';
import '../../resources/firebase_auth_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailc = TextEditingController();
  TextEditingController _passwordc = TextEditingController();

  Widget _buildPageContent(BuildContext context) {
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
                  "LOGIN",
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
                style: TextStyle(color: Colors.white),
                controller: _emailc,
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
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: _login,
                      color: Colors.cyan,
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white70, fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                'Forgot your password?',
                style: TextStyle(color: Colors.grey.shade500),
              ),
              SizedBox(
                height: 40,
              ),
              FlatButton(
                child: Text(
                  "Not registered? Signup",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pushNamed(context, 'signup'),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _login() async {
    try {
      
          await FirebaseAuthProvider().login(_emailc.text, _passwordc.text);
    } catch (e) {
      _scaffoldkey.currentState
          .showSnackBar(new SnackBar(content: Text(e.message)));
      // print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: _buildPageContent(context),
    );
  }
}
