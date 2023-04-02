import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locationdemaison/Model/Personne.dart';
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
      _auth.authStateChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
          print('User ID: ${user.uid}');
        }
      });
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFireBaseUser(user);
    }catch(exeption){
      print(exeption.toString());
    }
  }


  Future registerInWithEmailAndPassword(String email,String password,String Telephone) async{
    try{
      print("Inscription");
      _auth.authStateChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
          print('User ID: ${user.uid}');
        }
      });

      UserCredential result =
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      User? user = result.user;

      CreateUser(Telephone: Telephone, mail: email,user_id: user?.uid);
      return _userFromFireBaseUser(user);
    }catch(exeption){
      print(exeption.toString());
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

  Stream<List<Personne>> readUsers()=>FirebaseFirestore.instance.collection("Users").snapshots().map((snapshot) => snapshot.docs.map((doc) =>Personne.fromJson(doc.data())).toList());


  Future<Personne?> readUser() async {

    final docUser = FirebaseFirestore.instance.collection("Users").doc(_auth.currentUser?.uid);
    final snapshot = await docUser.get();

    if(snapshot.exists)
    {
      return Personne.fromJson(snapshot.data()!);
    }



    }

  Future CreateUser({required String Telephone,required String mail, required String? user_id}) async{
      final docUser = FirebaseFirestore.instance.collection("Users").doc(user_id);

      final Personne personne = new Personne(uid: user_id, Numero_tel: Telephone, Nom: "", Prenom: "", Age: DateTime.now(), Sex: "", Mail: mail, type_user: '');
      final data =  personne.toJson();



      docUser.set(data);
      //await docUser.set(json);
      print("Ajout du telephone");
  }

  Future SetType_user(String type_user) async{
    final docUser = FirebaseFirestore.instance.collection("Users").doc(_auth.currentUser?.uid);
    docUser.update(
      {
        "type_user" : type_user
      }
    );
  }

  Future UpdateUser(String? uid,String Nom,String Prenom,DateTime Age,String Mail,String Sex,String? Tel) async{

    final docUser = FirebaseFirestore.instance.collection("Users").doc(_auth.currentUser?.uid);

    final Personne personne = new Personne(uid: uid, Numero_tel: "Tel", Nom: Nom, Prenom: Prenom, Age: Age, Sex: Sex, Mail: _auth.currentUser?.email, type_user: '');
    final data =  personne.toJson();



    docUser.update({
      "Nom": Nom,
      "Prenom" : Prenom,
      "Sex" : Sex,
      "Age" : Age
    });
    }





  }

  Future DeleteUser() async{
    final docUser = FirebaseFirestore.instance.collection("Users").doc("kmd64twPVefeHHWAQa2zGEzaSJX2");
    docUser.delete();
  }




