import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locationdemaison/Model/DartHelper.dart';
import 'package:locationdemaison/Model/Message.dart';
import 'package:locationdemaison/Model/Personne.dart';
import 'package:locationdemaison/Screen/Pages/paiement/Cinetpay.dart';
class Chatbublle extends StatelessWidget {

  Message message;
  Personne partenaire;
  String monId;
  bool statutpaiment;

  Chatbublle({required this.monId,required this.partenaire,required this.message,required this.statutpaiment});


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
              child: Column(
                children: [
                  (message.imageurl == "") ? new Text(
                    statutpaiment ?
                    message.text ?? "" : "Pour discuter avec cet utilisateur\n vous devez souscrir a un abonnenement\n cliquez sur le boutton ci-dessous",
                    style: new TextStyle(
                        color: textcolor,
                        fontSize: 15.0,
                        fontStyle: FontStyle.italic
                    ),
                  ) : new Text(""),
                  statutpaiment ? new Container(height: 0,width: 0,) : FutureBuilder(builder: (context,snapshot){
                      return ElevatedButton(onPressed:() {Navigator.push(context, MaterialPageRoute(builder: (context)=> MyApp()));}, child: Text("Payer votre abonnement"));
                  })


                ],
              )),
          )
        ],
      ))
    ];

  }
}
