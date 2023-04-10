import 'package:flutter/material.dart';
import 'package:locationdemaison/Model/Personne.dart';
import 'package:locationdemaison/Model/Post.dart';
import 'package:locationdemaison/services/PostService.dart';
class postdetails extends StatelessWidget {
  const postdetails({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {

    getProprietaire() async{
      final proprietaire = await PostService().readProprietaire(post);
      print(proprietaire.Nom);
      return proprietaire.Nom;
    }
    final bool test = true;




    return Scaffold(
      appBar: AppBar(
        title: Text(post.Description.toString()),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            //Container pour l'image de la maison
            Container(
              height: MediaQuery.of(context).size.height/2.5,
              width: MediaQuery.of(context).size.width,
              color: Colors.red,
              child: Card(
                child: Image.network(post.Image_maison.toString(),
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
                        child: Image.network(post.Image_piece1.toString()),
                      ),

                    )
                    ,

                    Container(
                      width: 150,
                      height: 150,
                      child: Card(
                        child: Image.network(post.Image_piece2 != null ? post.Image_piece2.toString() : "" ),
                      ),
                    ),

                    Container(
                      width: 150,
                      height: 150,
                      child: Card(
                        child: Image.network(post.Image_piece3.toString()),
                      ),
                    ),

                    Container(
                      width: 150,
                      height: 150,
                      child: Card(
                        child: Image.network(post.Image_piece4.toString()),
                      ),
                    ),



                  ],
                ),
              ),
            ),

            Text("Nom de la location : "+post.NomLocation),
            Text("Date du post : "+post.Date_post!.toIso8601String()),
            Text("Pays : "+post.Pays!),
            Text("Region : "+post.Region!),
            Text("Ville : "+post.Ville!),
            Text("Quartié : "+post.Quartier),
            Text("Prix de la location : "+post.Prix.toString()+" FCFA"),


          ],
        ),
      ),
    );
  }
}




