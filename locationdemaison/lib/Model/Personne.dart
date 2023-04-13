import 'package:cloud_firestore/cloud_firestore.dart';

class Personne{
  final String uid;
  final String? Numero_tel;
  final String Nom;
  final String Prenom;
  final DateTime Age;
  final String Sex;
  final String? Mail;
  final String type_user;
  final String? image_profile;
  final String id;
  Personne({required this.id,required this.uid, required this.image_profile, required this.Numero_tel, required this.Nom, required this.Prenom, required this.Age, required this.Sex, required this.Mail,required this.type_user,});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      "Nom": Nom,
      "Numero_tel": Numero_tel,
      "Prenom": Prenom,
      "Age": Age,
      "Sex": Sex,
      "Mail": Mail,
      "type_user" : type_user,
      "image_profile" : image_profile,
    };
  }

  static Personne fromJson(Map<String,dynamic> json) => Personne(id: json["id"],uid: json["uid"], Numero_tel: json["Numero_tel"], Nom: json["Nom"], Prenom: json["Prenom"], Age: (json["Age"] as Timestamp).toDate(), Sex: json["Sex"], Mail: json["Mail"],type_user : json["type_user"], image_profile: json["image_profile"]);

}