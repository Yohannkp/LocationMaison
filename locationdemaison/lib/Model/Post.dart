import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  String NomLocation;
  String? Description;
  String? Image_maison;
  String? Image_piece1;
  String? Image_piece2;
  String? Image_piece3;
  String? Image_piece4;
  String? Ville;
  String? Pays;
  String? Region;
  DateTime? Date_post;
  int? Prix;
  int? Nombre_chambres;
  int? Nombre_likes;
  int? Nombre_salon;
  int? Nombre_vues;
  String? uid;
  String Quartier;
  String? post_id;

  Post({required this.Pays,required this.NomLocation,required this.post_id,required this.Quartier,required this.Region,required this.Ville,required this.Description,required this.Image_maison,required this.Image_piece1,required this.Image_piece2,required this.Image_piece3,required this.Image_piece4,required this.Date_post,required this.Prix, required this.Nombre_chambres, required this.Nombre_likes, required this.Nombre_salon, required this.Nombre_vues, this.uid});

  Map<String, dynamic> toJson() {
    return {
      'Description': Description,
      "Image_maison": Image_maison,
      "Image_piece1": Image_piece1,
      "Image_piece2": Image_piece2,
      "Image_piece3": Image_piece3,
      "Image_piece4": Image_piece4,
      "Pays": Pays,
      "Region": Region,
      "Ville": Ville,
      "Date_post" : Date_post,
      "Quartier":Quartier,
      "Prix" : Prix,
      "Nombre_chambres" : Nombre_chambres,
      "Nombre_likes" : Nombre_likes,
      "Nombre_salon" : Nombre_salon,
      "Nombre_vues" : Nombre_vues,
      "uid" : uid,
      "post_id" : post_id,
      "NomLocation":NomLocation
    };
  }

  static Post fromJson(Map<String,dynamic> json) => Post(uid: json["uid"],NomLocation: json["NomLocation"],post_id: json["post_id"], Description: json["Description"], Image_maison: json["Image_maison"], Image_piece1: json["Image_piece1"], Date_post: (json["Date_post"] as Timestamp).toDate(), Image_piece2: json["Image_piece2"], Image_piece3: json["Image_piece3"],Image_piece4: json["Image_piece4"],Pays : json["Pays"],Region : json["Region"],Ville : json["Ville"], Nombre_chambres: json["Nombre_chambres"],Nombre_likes: json["Nombre_likes"],Nombre_salon: json["Nombre_salon"],Nombre_vues: json["Nombre_vues"],Prix: json["Prix"],Quartier: json["Quartier"]);

}