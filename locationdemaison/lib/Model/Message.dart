import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Message{
  String from;
  String to;
  String text;
  String imageurl;
  String dateString;


  Message({required this.from,required this.to,required this.text,required this.dateString,required this.imageurl});

  Map<String, dynamic> toJson(){
    return {
      "from" : from,
      "to" : to,
      "text" : text,
      "imageurl" : imageurl,
      "dateString" : dateString
    };
  }


  static Message fromJson(Map<String,dynamic> json) => Message(from: json["from"], to: json["to"], text: json["text"], imageurl: json["imageurl"], dateString: (json["dateString"]));



}
