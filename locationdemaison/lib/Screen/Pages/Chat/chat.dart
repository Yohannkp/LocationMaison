import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:locationdemaison/Model/Message.dart';
import 'package:locationdemaison/Model/Personne.dart';
import 'package:locationdemaison/Model/Post.dart';
import 'package:locationdemaison/Screen/Pages/Chat/zonetextwidget.dart';
import 'package:locationdemaison/services/messageservice.dart';
import 'package:locationdemaison/utils/chatbubble.dart';
class chat extends StatefulWidget {
  Personne partenaire;
  String id;
  chat({Key? key, required this.partenaire,required this.id}) : super(key: key);

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  MessageService message_service = MessageService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.partenaire.Nom),
      ),
      body: Container(
        child: new InkWell(
          //Commande pour fermer un clavier
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: new Column(
            children: <Widget>[
              new Flexible(child:
              new FirebaseAnimatedList(
                  reverse: true
                  ,query: message_service.base_message.child(message_service.getMessageRef(widget.id, widget.partenaire.id)),
                  sort: (a,b) => b.key!.compareTo(a.key!),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,Animation<double> animation,int index){
                    Map conversation = snapshot.value as Map;
                    return Chatbublle(monId: widget.id, partenaire: widget.partenaire, message: Message(from: conversation["from"],to: conversation["to"],text: conversation["text"] ,dateString: conversation["dateString"],imageurl: ""));
                  } )),
              new Divider(height: 1.5,),
              new zonetextwidget(partenaire: this.widget.partenaire,id: widget.id,)
            ],
          ),
        ),
      ),
    );
  }
}
