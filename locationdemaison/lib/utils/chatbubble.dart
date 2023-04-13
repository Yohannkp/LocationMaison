import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locationdemaison/Model/DartHelper.dart';
import 'package:locationdemaison/Model/Message.dart';
import 'package:locationdemaison/Model/Personne.dart';
class Chatbublle extends StatelessWidget {

  Message message;
  Personne partenaire;
  String monId;

  Chatbublle({required this.monId,required this.partenaire,required this.message});


  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.all(10.0),
        child: new Row(
          children: widgetBubble(message.from == monId),
        ),
    );
  }

  List<Widget> widgetBubble(bool moi){
    CrossAxisAlignment alignment = (moi) ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    Color? bubblecolor = (moi) ? Colors.pink[400] : Colors.blue[400];
    Color? textcolor = (moi) ? Colors.black : Colors.grey[200];

    return <Widget> [
      new Expanded(child: new Column(
        crossAxisAlignment: alignment,
        children: [
          new Text(message.dateString),
          new Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            color: bubblecolor,
            child: new Container(
              padding: EdgeInsets.all(10.0),
              child: (message.imageurl == "") ? new Text(
                message.text ?? "",
                style: new TextStyle(
                  color: textcolor,
                  fontSize: 15.0,
                  fontStyle: FontStyle.italic
                ),
              ) : new Image.network(message.imageurl),
            ),
          )
        ],
      ))
    ];

  }
}
