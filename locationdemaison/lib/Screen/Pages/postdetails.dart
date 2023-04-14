import 'package:flutter/material.dart';
import 'package:locationdemaison/Model/Personne.dart';
import 'package:locationdemaison/Model/Post.dart';
import 'package:locationdemaison/Screen/Pages/AjoutPost1.dart';
import 'package:locationdemaison/Screen/Pages/Chat/chat.dart';
import 'package:locationdemaison/Screen/Pages/ModifierPost.dart';
import 'package:locationdemaison/services/PostService.dart';
import 'package:locationdemaison/services/authentication.dart';

class postdetails extends StatefulWidget {
  String id;
  Post post;
  postdetails({super.key, required this.post, required this.id});


  @override
  State<postdetails> createState() => _postdetailsState();
}

class _postdetailsState extends State<postdetails> {
  String Nomproprietaire = "";
  Personne? onlineuser ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AuthenticationService _authenticationService = AuthenticationService();
    _authenticationService.readUserConnected(this.widget.post.uid!).then((value) {
      print("Recherche du proprietaire");
      print("Proprétaire : "+value.Nom);
      this.Nomproprietaire = value.Nom;
      return value;
      //Navigator.push(context, new MaterialPageRoute(builder: (context) => new chat(partenaire: value, id: this.widget.id)));
    });


    _authenticationService.readUserConnected(this.widget.id).then((value) {
      this.onlineuser = value;
      return value;
      //Navigator.push(context, new MaterialPageRoute(builder: (context) => new chat(partenaire: value, id: this.widget.id)));
    });

  }
  @override
  Widget build(BuildContext context) {
    getProprietaire() async{
      final proprietaire = await PostService().readProprietaire(this.widget.post).then((value) => value);
      print(proprietaire);
      return proprietaire;
    }


    AuthenticationService _authenticationService = AuthenticationService();

    PostService postService = PostService();




    final bool test = true;
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.post.Description.toString()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              //Container pour l'image de la maison
              Container(
                height: MediaQuery.of(context).size.height/2.5,
                width: MediaQuery.of(context).size.width,
                color: Colors.red,
                child: Card(
                  child: Image.network(this.widget.post.Image_maison.toString(),
                    fit: BoxFit.cover,),
                ),
              ),
              SizedBox(
                height: 50,
              ),

              //Container des images de pieces
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        color: Colors.green,
                        child: Card(
                          child: Image.network(this.widget.post.Image_piece1.toString(),fit: BoxFit.cover,),
                        ),

                      )
                      ,

                      Container(
                        width: 150,
                        height: 150,
                        child: Card(
                          child: Image.network("https://th.bing.com/th/id/OIP.Z0PLkCGpEDNcan8n3m-OIAHaFk?w=218&h=180&c=7&r=0&o=5&pid=1.7",fit: BoxFit.cover,),
                        ),
                      ),

                      Container(
                        width: 150,
                        height: 150,
                        child: Card(
                          child: Image.network("https://th.bing.com/th/id/OIP.Z0PLkCGpEDNcan8n3m-OIAHaFk?w=218&h=180&c=7&r=0&o=5&pid=1.7",fit: BoxFit.cover,),
                        ),
                      ),

                      Container(
                        width: 150,
                        height: 150,
                        child: Card(
                          child: Image.network(this.widget.post.Image_piece4.toString(),fit: BoxFit.cover,),
                        ),
                      ),



                    ],
                  ),
                ),
              ),

              IconButton(onPressed: (){
                print(this.widget.post.uid);
                _authenticationService.readUserConnected(this.widget.post.uid!).then((value) {
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new chat(partenaire: value, id: this.widget.id)));
                });
              },
                  icon: Icon(Icons.message)),
              Text("Nom de la location : "+this.widget.post.NomLocation),
              Text("Date du post : "+this.widget.post.Date_post!.toIso8601String()),
              Text("Pays : "+this.widget.post.Pays!),
              Text("Region : "+this.widget.post.Region!),
              Text("Ville : "+this.widget.post.Ville!),
              Text("Quartié : "+this.widget.post.Quartier),
              Text("Propriétaire : "+this.Nomproprietaire),


              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  this.onlineuser?.type_user == "vendeur" ?
                  ElevatedButton(onPressed: (){
                    postService.deletePost(this.widget.post);
                    Navigator.pop(context);

                  }, child: Text("Supprimer")) : new Container(),
                  SizedBox(
                    width: 50,
                  ),
                  this.onlineuser?.type_user == "vendeur" ?
                  ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ModifierPost(post: this.widget.post,) ));
                  }, child: Text("Modifier")) : new Container()
                ],
              )



            ],
          ),
        ),
      ),
    );
  }

  getUserid() async{
    final proprietaire = await PostService().readProprietaire(this.widget.post).then((value) => value);
  }
}







