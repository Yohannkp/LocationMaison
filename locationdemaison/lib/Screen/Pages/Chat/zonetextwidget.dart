import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locationdemaison/Model/Personne.dart';
import 'package:locationdemaison/services/authentication.dart';
import 'dart:io';

import 'package:locationdemaison/services/messageservice.dart';


class zonetextwidget extends StatefulWidget {
  zonetextwidget({Key? key,required this.partenaire,required this.id}) : super(key: key);

  Personne partenaire;
  String id;


  @override
  State<zonetextwidget> createState() => _zonetextwidgetState();

}

class _zonetextwidgetState extends State<zonetextwidget> {
  TextEditingController _textController = TextEditingController();
  MessageService messageService = MessageService();
  FirebaseAuth _auth = FirebaseAuth.instance;

  late Personne moi;
  AuthenticationService _authenticationService = AuthenticationService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authenticationService.readOnlineUser().then((value) => {
      setState((){
        moi = value!;
      })
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.grey[300],
      padding: EdgeInsets.all(5.0),
      child: new Row(
        children: <Widget>[
          new IconButton(onPressed: null, icon: Icon(Icons.camera_enhance)),
          new IconButton(onPressed: null, icon: Icon(Icons.photo_library)),
          new Flexible(child:
          TextField(
            controller: _textController,
            decoration: InputDecoration.collapsed(
              hintText: "Ecrivez quelque chose",
            ),
            maxLines: null,
          )),
          new IconButton(onPressed: _sendButtonPressed, icon: Icon(Icons.send))
        ],
      ),
    );
  }

  _sendMessage(String string){
    print(_textController.text);
    //Envoyer message dans firebase
  }

  _sendButtonPressed(){
    if (_textController.text != null && _textController.text !=""){
      _sendMessage("Send");
      String text = _textController.text;
      messageService.sendMessage(this.widget.partenaire, moi, text, null);
      _textController.clear();
      FocusScope.of(context).requestFocus(new FocusNode());
    }else{
      print("Texte vide ou null");
    }
  }
}
