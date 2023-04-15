import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:locationdemaison/Model/Conversation.dart';
import 'package:locationdemaison/Model/Personne.dart';
import 'package:locationdemaison/Screen/Pages/Chat/chat.dart';
import 'package:locationdemaison/common/loading.dart';
import 'package:locationdemaison/services/authentication.dart';
import 'package:locationdemaison/services/messageservice.dart';
class Message extends StatefulWidget {

  String? id;
  Message(String? id){
    this.id = id;
  }
  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      this.widget.id = _auth.currentUser?.uid;
    });
  }
  static final base = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthenticationService _authenticationService = AuthenticationService();
  final base_conversation = base.child("conversation");
  MessageService messageService = MessageService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder(
          future: messageService.getDoc(this.widget.id!),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return new FirebaseAnimatedList(query: messageService.base_conversation.child(this.widget.id!),
                  sort: (a,b) {
                    Map converseb = b.value as Map;
                    Map conversea = a.value as Map;

                    return converseb["dateString"].compareTo(conversea["dateString"]);

                  },
                  itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double> animation,int index) {

                    if(snapshot.value != null)
                    {
                      Map conversation = snapshot.value as Map;
                      //Conversation conversation = new Conversation(personne: snapshot.value., last_message: '', id: '');
                      String subtitle = (conversation["monId"] == this.widget.id ? "Moi : ": "");
                      subtitle += conversation["last_message"] ?? "image envoyée";
                      return Container(

                        color: Colors.grey[100],
                        child: new ListTile(
                          leading: Text(conversation["Nom"]),
                          title: Text(conversation["Prenom"]),
                          subtitle: new Text(subtitle),
                          trailing: Text(conversation["dateString"]),
                          onTap: () async{
                            _authenticationService.readUserConnected(conversation["uid"]).then((value) {
                              Navigator.push(context, new MaterialPageRoute(builder: (context) => new chat(partenaire: value, id: this.widget.id!)));
                            } );

                          },
                        ),
                      );
                    }else{
                      print("Aucune discussion");
                      return Center(
                          child: Text("Aucune discussion pour le moment")
                      );
                    }

                  });
            }
            else{
              return new CircularProgressIndicator();
            }

      }),
    );
  }
}


Widget AffichagePersonne(Personne personne)=> ListTile(
  leading: CircleAvatar(child: Text("${personne.Nom}"),),
  title: Text(personne.Age.toIso8601String()),
);