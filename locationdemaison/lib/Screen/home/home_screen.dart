import 'package:flutter/material.dart';
import 'package:locationdemaison/Model/Personne.dart';
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
      //Recuperer une liste d'utilisateurs
      body: Container(
        child: StreamBuilder<List<Personne>>(

          stream: _authenticationService.readUsers(),
          builder: (context,snapshot){
            if(snapshot.hasError){
              return Text("Une erreur s'est produite ${snapshot}",);
            }
              else if(snapshot.hasData){
                final users = snapshot.data!;
                return ListView(
                  children: users.map(AffichagePersonne).toList(),
                );
              }else{
                return Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      ),
      //Recuperer un utilisareur précis
      /*body: Container(
        child: Column(
          children: [
            FutureBuilder<Personne?>(
              future: _authenticationService.readUser(),
              builder: (context,snapshot){
                if(snapshot.hasError){
                  return Text("Une erreur s'est produite ${snapshot}",);
                }else if(snapshot.hasData){
                  final user = snapshot.data!;

                  return user == null? Center(child: Text("Aucun utilisateur trouvé"),) : AffichagePersonne(user);
                }else{
                  return Center(child: CircularProgressIndicator(),);
                }
              },
            ),
            ElevatedButton(onPressed: (){
              _authenticationService.UpdateUser("uid", "Nom", "Prenom", 5, "Mail", "Sex", "Tel");
            }, child: Text("Update")),
            ElevatedButton(onPressed: (){
              _authenticationService.DeleteUser();
            }, child: Text("Delete"))
          ],
        ),
      )*/
    );
  }
  Widget AffichagePersonne(Personne personne)=> ListTile(
    leading: CircleAvatar(child: Text("${personne.Age}"),),
    title: Text(personne.Numero_tel),
    subtitle: Text(personne.Prenom),
  );
}
