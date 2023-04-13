import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locationdemaison/Model/Post.dart';
import 'package:locationdemaison/services/PostService.dart';
import 'package:locationdemaison/services/authentication.dart';

import '../home/home_screen_vendeur.dart';
class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  final AuthenticationService _authenticationService = AuthenticationService();

  int indexpage = 0;
  late PageController _pageController;
  late String nom;

  final FirebaseAuth _auth = FirebaseAuth.instance;



  List<Map<String, dynamic>> _foundpost = [];
  @override
  void initState() {
    // TODO: implement initState
    final donnes = FirebaseFirestore.instance.collection("Post").where("uid",isEqualTo: _auth.currentUser?.uid).snapshots().map((snapshot) => snapshot.docs.map((doc) =>Post.fromJson(doc.data())).toList());
    super.initState();
  }

  void recherchedepuisfirebase(String query) async{
      final resultat = FirebaseFirestore.instance.collection("Post").where("uid",isEqualTo: _auth.currentUser?.uid).snapshots().map((snapshot) => snapshot.docs.map((doc) =>Post.fromJson(doc.data())).toList());
  }

  String name = "";


  @override
  Widget build(BuildContext context) {
    final PostService postService = PostService();
    final listedespost = postService.readPosts();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: TextField(
          decoration: InputDecoration(
            labelText: "Search",suffixIcon: Icon(Icons.search),

          ),
          onChanged: (value){
            setState((){
              name = value;
            });

          },
        ),

      ),
      body: Container(
        child:StreamBuilder<List<Post>>(

      stream: postService.readPosts(),
      builder: (context,snapshot){
        if(snapshot.hasError){
          print(snapshot.error);
          return Text("Une erreur s'est produite : ${snapshot.error}",);
        }
        else {
          final posts = snapshot.data!;
          return posts.isEmpty ? Center(child: Text("Aucun post trouver"),) : ListView.builder(
            itemCount: posts.map(AffichagePost).toList().length,
            itemBuilder: (BuildContext context, int index) {

              if(name.isEmpty){
                return Container(
                  child: Center(
                    child: Text("En attente de votre recherche..."),
                  ),
                );
              }else if(posts[index].NomLocation.toString().toLowerCase().startsWith(name.toLowerCase())){
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              width: MediaQuery.of(context).size.width*0.9,
                              height: 190,

                              child: Column(
                                children: [
                                  Container(

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(posts[index].Image_maison!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    height: 150,
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.all(1),
                                            width: 50,
                                            height: 50,
                                            child: Column(
                                              children: [
                                                Card(

                                                  color: Colors.yellow,
                                                  child: Text(posts[index].Prix.toString()),
                                                ),
                                              ],
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(posts[index].NomLocation),
                                          Text(posts[index].Pays!)
                                        ],
                                      )
                                    ],
                                  )



                                ],
                              ),
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }else{
                return Center(child: Text("Aucun résultat"),);
              }

            },

          );
        }
      },
    ),
      ),
    );
  }
}
