class Personne{
  final String? uid;
  final String Numero_tel;
  final String Nom;
  final String Prenom;
  final DateTime Age;
  final String Sex;
  final String? Mail;
  final String? type_user;

  Personne({required this.uid, required this.Numero_tel, required this.Nom, required this.Prenom, required this.Age, required this.Sex, required this.Mail,required this.type_user,});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      "Nom": Nom,
      "Numero_tel": Numero_tel,
      "Prenom": Prenom,
      "Age": Age,
      "Sex": Sex,
      "Mail": Mail,
      "type_user" : type_user
    };
  }

  static Personne fromJson(Map<String,dynamic> json) => Personne(uid: json["id"], Numero_tel: json["Numero_tel"], Nom: json["Nom"], Prenom: json["Prenom"], Age: json["Age"], Sex: json["Sex"], Mail: json["Mail"],type_user : json["type_user"]);

}