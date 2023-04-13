import 'package:firebase_database/firebase_database.dart';
import 'package:locationdemaison/Model/Personne.dart';

class Conversation{

  late String id;
  late String last_message;
  late Personne personne;


  Conversation({required this.personne,required this.last_message,required this.id});

  Map<String, dynamic> toJson(){
    return {
      "id" : id,
      "last_message" : last_message,
      "personne" : personne,
    };
  }
}