import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:locationdemaison/Model/DartHelper.dart';
import 'package:locationdemaison/Model/Personne.dart';
class MessageService{
  static final base = FirebaseDatabase.instance.ref();
  final base_message = base.child("messages");
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final base_conversation = base.child("conversation");

  sendMessage(Personne receveur,Personne moi,String text,imageurl){
    String date = new DateTime.now().millisecondsSinceEpoch.toString();

    Map map = {
      "from" : moi.uid,
      "to": receveur.id,
      "text" : text,
      "imageurl" : "imageurl",
      "dateString" : date
    };

    base_message.child(getMessageRef(moi.uid, receveur.id)).child(date).set(map);
    date = DateHelper().getDate(date);
    base_conversation.child(moi.uid).child(receveur.id).set(getConversation(moi.uid, receveur, text, date));
    base_conversation.child(receveur.id).child(moi.uid).set(getConversation(moi.uid,moi,text,date));
  }

  Map getConversation(String sender,Personne user, String text,String date){
    Map map = user.toJson();
    map["monId"] = sender;
    map["last_message"] = text;
    map["dateString"] = date;
    map["Age"] = date;
    return map;
  }

  String getMessageRef(String from,String to){
    String resultat = "";
    List<String> liste = [from,to];
    liste.sort((a,b) => a.compareTo(b));
    for (var x in liste){
      resultat += x + "+";
    }
    print(resultat);
    return resultat;

  }
}