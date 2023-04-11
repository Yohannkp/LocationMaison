import 'package:flutter/material.dart';
import 'package:locationdemaison/Screen/home/home_screen_client.dart';
import 'package:locationdemaison/Screen/home/home_screen_vendeur.dart';
import 'package:locationdemaison/services/authentication.dart';
class Type_user extends StatefulWidget {
  const Type_user({Key? key}) : super(key: key);

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
            ElevatedButton(onPressed: (){

              _authenticationService.SetType_user(type ? "Client": "Vendeur");
              type ? Navigator.push(context, MaterialPageRoute(builder: (context)=> home_screen_client())) : Navigator.push(context, MaterialPageRoute(builder: (context)=> home_screen_vendeur()));
              ;

            }, child: Text("Continuer"))
          ],
        )
      ),
    );
  }
}
