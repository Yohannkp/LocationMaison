import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locationdemaison/Model/user.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  AppUser? _userFromFireBaseUser(User? user){
    return user != null ? AppUser(uid: user.uid) : null;
  }

  Stream<AppUser?> get user{
    return _auth.authStateChanges().map(_userFromFireBaseUser);
  }

  Future signInWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFireBaseUser(user);
    }catch(exeption){
      print(exeption.toString());
    }
  }


  Future registerInWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result =
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFireBaseUser(user);
    }catch(exeption){
      print(exeption.toString());
      return null;
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(exeption){
      print(exeption.toString());
      return null;
    }
  }
}