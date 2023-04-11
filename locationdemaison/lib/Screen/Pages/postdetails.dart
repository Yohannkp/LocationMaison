import 'package:flutter/material.dart';
import 'package:locationdemaison/Model/Personne.dart';
import 'package:locationdemaison/Model/Post.dart';
import 'package:locationdemaison/Screen/Pages/AjoutPost1.dart';
import 'package:locationdemaison/Screen/Pages/ModifierPost.dart';
import 'package:locationdemaison/services/PostService.dart';
class postdetails extends StatelessWidget {
  const postdetails({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {

    getProprietaire() async{
      final proprietaire = await PostService().readProprietaire(post).then((value) => value);
      print(proprietaire);
      return proprietaire;
    }

    PostService postService = PostService();

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
                        child: Image.network(post.Image_piece1.toString(),fit: BoxFit.cover,),
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
                        child: Image.network(post.Image_piece4.toString(),fit: BoxFit.cover,),
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

            FutureBuilder(
                future: postService.readProprietaire(post),
                builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasData){
                      return Text(snapshot.data!.Nom);
                    }else{
                      return Text("Propriétaire indisponible");
                    }
                  }else{
                    return CircularProgressIndicator();
                  }
                },
            ),

            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                  postService.deletePost(post);
                  Navigator.pop(context);

                }, child: Text("Supprimer")),
                SizedBox(
                  width: 50,
                ),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ModifierPost(post: post,) ));
                }, child: Text("Modifier"))
              ],
            )



          ],
        ),
      ),
    );
  }

  getUserid() async{
    final proprietaire = await PostService().readProprietaire(post).then((value) => value);
  }
}






