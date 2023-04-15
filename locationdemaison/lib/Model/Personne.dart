import 'package:cloud_firestore/cloud_firestore.dart';

class Personne{
  String uid;
  String Numero_tel;
  String Nom;
  String Prenom;
  DateTime Age;
  String Sex;
  String? Mail;
  String type_user;
  String? image_profile;
  String id;
  DateTime fin_abonnement;
  bool statuspaiment;
  String password;
  Personne({required this.password,required this.fin_abonnement,required this.statuspaiment,required this.id,required this.uid, required this.image_profile, required this.Numero_tel, required this.Nom, required this.Prenom, required this.Age, required this.Sex, required this.Mail,required this.type_user,});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'id': id,
      "Nom": Nom,
      "Numero_tel": Numero_tel,
      "Prenom": Prenom,
      "Age": Age,
      "Sex": Sex,
      "Mail": Mail,
      "type_user" : type_user,
      "image_profile" : image_profile,
      "statuspaiment" : statuspaiment,
      "fin_abonnement" : fin_abonnement,
      "password" : password

    };
  }

  static Personne fromJson(Map<String,dynamic> json) => Personne(id: json["id"],uid: json["uid"], Numero_tel: json["Numero_tel"], Nom: json["Nom"], Prenom: json["Prenom"], Age: (json["Age"] as Timestamp).toDate(), Sex: json["Sex"], Mail: json["Mail"],type_user : json["type_user"], image_profile: json["image_profile"], statuspaiment: json["statuspaiment"], fin_abonnement: (json["fin_abonnement"] as Timestamp).toDate(), password: json["password"]);

}