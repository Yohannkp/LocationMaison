import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locationdemaison/Model/Personne.dart';
import 'package:locationdemaison/Model/Post.dart';
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


  Future registerInWithEmailAndPassword(String email,String password,String Telephone,Personne p) async{
    try{
      print("Inscription");
      _auth.authStateChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
          print('User ID: ${user.uid}');
          p.uid = user.uid;
          p.id = user.uid;
          CreateUser(personne: p);
        }
      });

      UserCredential result =
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      User? user = result.user;
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

  Stream<List<Personne>> readUsers()=>
      FirebaseFirestore.instance.collection("Users").snapshots()
           .map((snapshot) => snapshot.docs.map((doc) =>Personne.fromJson(doc.data())).toList());



  readUser() async {

    final docUser = FirebaseFirestore.instance.collection("Users").doc(_auth.currentUser?.uid);
    final snapshot = await docUser.get();

    if(snapshot.exists)
    {
      return Personne.fromJson(snapshot.data()!);
    }

    }

  Future<Personne> readUserConnected(String uid) async{

    final docUser = FirebaseFirestore.instance.collection("Users").doc(uid);
    final snapshot = await docUser.get();


    return Personne.fromJson(snapshot.data()!);

  }


  Future<Personne?> readOnlineUser() async {

    print("Nous recherchon l'utilisarteur : "+_auth.currentUser!.uid);
    final docUser = FirebaseFirestore.instance.collection("Users").doc(_auth.currentUser?.uid);
    final snapshot = await docUser.get();

    if(snapshot.exists)
    {
      return Personne.fromJson(snapshot.data()!);
    }

    return null;


  }


  Future CreateUser({required Personne personne}) async{
      final docUser = FirebaseFirestore.instance.collection("Users").doc(personne.uid);
      //final docPost = FirebaseFirestore.instance.collection("Post").doc(_auth.currentUser?.uid);
      //final Personne personne = new Personne(uid: user_id!,id: user_id, Numero_tel: Telephone, Nom: "", Prenom: "", Age: DateTime.now(), Sex: "", Mail: mail, type_user: '', image_profile: '', statuspaiment: false, fin_abonnement: DateTime.now(), password: '');

      //final Post post = new Post(NomLocation: '',uid: _auth.currentUser?.uid,Pays: "Togo", Quartier: "Hedranawoe", Region: "Maritime", Ville: "Lomé", Description: "Avion", Image_maison: "", Image_piece1: "", Image_piece2: "", Image_piece3: "", Image_piece4: "", Date_post: DateTime.now(), Prix: 0, Nombre_chambres: 0, Nombre_likes: 0, Nombre_salon: 0, Nombre_vues: 0, post_id: docPost.id);
      //String path = docPost.path.split("/")[1];
      //print(path);
      //post.post_id = path;
      final dataUser =  personne.toJson();
      //Tfinal dataPost = post.toJson();



      docUser.set(dataUser);
      //docPost.set(dataPost);
      //await docUser.set(json);
      print("Ajout personne");
  }

  Future SetType_user(String type_user) async{
    final docUser = FirebaseFirestore.instance.collection("Users").doc(_auth.currentUser?.uid);
    docUser.update(
      {
        "type_user" : type_user
      }
    );
  }



  Future UpdateUser(Personne personne) async{

    final docUser = FirebaseFirestore.instance.collection("Users").doc(_auth.currentUser?.uid);

    //final Personne personne = new Personne(id: uid,uid: uid, Numero_tel: "Tel", Nom: Nom, Prenom: Prenom, Age: Age, Sex: Sex, Mail: _auth.currentUser?.email, type_user: '', image_profile: '', statuspaiment: false, fin_abonnement: DateTime.now(), password: '');
    final data =  personne.toJson();



    docUser.update({
      "Nom": personne.Nom,
      "Prenom" : personne.Prenom,
    });
    }





  }

  Future DeleteUser() async{
    final docUser = FirebaseFirestore.instance.collection("Users").doc("kmd64twPVefeHHWAQa2zGEzaSJX2");
    docUser.delete();
  }




