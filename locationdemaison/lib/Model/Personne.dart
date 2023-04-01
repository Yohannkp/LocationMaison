class Personne{
  final String? uid;
  final String Numero_tel;
  final String Nom;
  final String Prenom;
  final int Age;
  final String Sex;
  final String Mail;

  Personne({required this.uid, required this.Numero_tel, required this.Nom, required this.Prenom, required this.Age, required this.Sex, required this.Mail});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'Numero_tel': Numero_tel,
      "Nom": Nom,
      "Prenom": Prenom,
      "Age": Age,
      "Sex": Sex,
      "Mail": Mail
    };
  }

  static Personne fromJson(Map<String,dynamic> json) => Personne(uid: json["id"], Numero_tel: json["Numero_tel"], Nom: json["Nom"], Prenom: json["Prenom"], Age: json["Age"], Sex: json["Sex"], Mail: json["Mail"]);

}