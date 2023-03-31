import 'package:flutter/material.dart';
import 'package:locationdemaison/services/authentication.dart';
class home_screen extends StatelessWidget {
  const home_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationService _authenticationService = AuthenticationService();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("Acceuil"),
        actions: <Widget>[
          TextButton.icon(onPressed: () async{
            await _authenticationService.signOut();
          },icon: Icon(Icons.person), label: Text("Logout"),)
        ],
      ),
    );
  }
}
