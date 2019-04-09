import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthProvider
{

  FirebaseAuth _auth =FirebaseAuth.instance;
  Future<FirebaseUser> login(email,password){
    return
     _auth.signInWithEmailAndPassword(email: email,password: password);
    
  }

  Future<FirebaseUser> signup(String email,String password){
    return _auth.createUserWithEmailAndPassword(email: email,password: password);
  }
  Future<void> logout(){
    return _auth.signOut();










    
  }
  

}