import 'package:flutter/material.dart';
import 'package:locationdemaison/Model/Personne.dart';
import 'package:locationdemaison/Screen/home/home_screen_client.dart';
import 'package:locationdemaison/Screen/home/home_screen_vendeur.dart';
import 'package:locationdemaison/services/authentication.dart';
class Type_user extends StatefulWidget {

    Personne personne;
    Type_user({required this.personne});

  @override
  State<Type_user> createState() => _Type_userState();
}

class _Type_userState extends State<Type_user> {
  AuthenticationService _authenticationService = new AuthenticationService();
  bool type = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Vendeur"),
                Switch(
                  value: type,
                  activeColor: Colors.pink,
                  inactiveThumbColor: Colors.orange,
                  inactiveTrackColor:Colors.orange,
                  onChanged: (bool b){
                    setState(() {
                      type = b;
                    });
                  },

                ),
                Text("Client")
              ],
            ),
            SizedBox(height: 10.0,),
            ElevatedButton(onPressed: () async{
              type == false? this.widget.personne.type_user = "vendeur" : this.widget.personne.type_user = "client";
              await _authenticationService.registerInWithEmailAndPassword(this.widget.personne.Mail!, this.widget.personne.password,this.widget.personne.Numero_tel,this.widget.personne);
              //_authenticationService.SetType_user(type ? "Client": "Vendeur");

              type ? Navigator.push(context, MaterialPageRoute(builder: (context)=> home_screen_client())) : Navigator.push(context, MaterialPageRoute(builder: (context)=> home_screen_vendeur()));
              ;


            }, child: Text("Continuer")),
            Container(
              child: Column(
                children: [
                  Text("Nom : "+this.widget.personne.Nom),
                  Text("Prenom : "+this.widget.personne.Prenom),
                  Text("Age : "+this.widget.personne.Age.toIso8601String()),
                  Text("Type_user : "+this.widget.personne.type_user),
                  Text("Telephone : "+this.widget.personne.Numero_tel),
                  Text("Fin abon : "+this.widget.personne.fin_abonnement.toIso8601String()),
                  Text("Sex : "+this.widget.personne.Sex),
                  Text("Satatu payement : "+this.widget.personne.statuspaiment.toString()),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
