import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:locationdemaison/Model/Personne.dart';
import 'package:locationdemaison/Model/Post.dart';
import 'package:locationdemaison/Screen/Pages/AjoutPost1.dart';
import 'package:locationdemaison/Screen/Pages/Chat/chat.dart';
import 'package:locationdemaison/Screen/Pages/Chat/message.dart';
import 'package:locationdemaison/Screen/Pages/Informations.dart';
import 'package:locationdemaison/Screen/Pages/Personne/UpdatePersonne.dart';
import 'package:locationdemaison/Screen/Pages/info_post_1.dart';
import 'package:locationdemaison/Screen/Pages/postdetails.dart';
import 'package:locationdemaison/Screen/Pages/searchpage.dart';
import 'package:locationdemaison/common/loading.dart';
import 'package:locationdemaison/services/PostService.dart';
import 'package:locationdemaison/services/authentication.dart';
import 'package:locationdemaison/services/paiementservice.dart';

import '../../utils/settings_page.dart';
class home_screen_vendeur extends StatefulWidget {
  const home_screen_vendeur({Key? key}) : super(key: key);

  @override
  State<home_screen_vendeur> createState() => _home_screen_vendeurState();
}

class _home_screen_vendeurState extends State<home_screen_vendeur> {
  final AuthenticationService _authenticationService = AuthenticationService();
  final PostService postService = PostService();
  int indexpage = 0;
  late PageController _pageController;
  late String nom;


  Personne? onlineuser = new Personne(password: "", fin_abonnement: DateTime.now(), statuspaiment: false, id: "", uid: "", image_profile: "", Numero_tel: "", Nom: "", Prenom: "", Age: DateTime.now(), Sex: "", Mail: "", type_user: "client");
  PaiementService paiementService = PaiementService();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController = PageController();

    AuthenticationService _authenticationService = AuthenticationService();
    _authenticationService.readUserConnected(_auth.currentUser!.uid).then((value) {
      this.onlineuser = value;
      return value;
      //Navigator.push(context, new MaterialPageRoute(builder: (context) => new chat(partenaire: value, id: this.widget.id)));
    });

  }


  String name = "";

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }


    String Nom = "";
  String Prenom = "";
  String Age = "";
  String type_user = "";
  String sex = "";

    Future<Personne> getOnlineUser() async{
      Personne personne = await _authenticationService.readUser();
      setState(() {
        Nom = personne.Nom!;
        Prenom = personne.Prenom!;
        Age = personne.Age.toIso8601String();
        type_user = personne.type_user!;
        sex = personne.Sex!;

      });
      return personne;

  }


  @override
  Widget build(BuildContext context) {
    getOnlineUser();
    final datas = FirebaseFirestore.instance.collection("Post").where("uid",isEqualTo: _auth.currentUser?.uid).snapshots().map((snapshot) => snapshot.docs.map((doc) =>Post.fromJson(doc.data())).toList());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text("Page vendeur",style: TextStyle(color: Colors.black),),
          actions: <Widget>[
            TextButton.icon(onPressed: () async{
              await _authenticationService.signOut();
              Navigator.pop(context);
            },icon: Icon(Icons.person), label: Text("Logout"),)
          ],
        ),
        body: SizedBox(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index){
              setState(() {
                indexpage = index;
              });
            },
            children: [



              //Page home
              Container(
                child: StreamBuilder<List<Post>>(

                  stream: postService.readPosts(),
                  builder: (context,snapshot){
                    if(snapshot.hasError){
                      print(snapshot.error);
                      return Text("Une erreur s'est produite : ${snapshot.error}",);
                    }
                    else if(snapshot.hasData){
                      final posts = snapshot.data!;
                      return posts.isEmpty ? Center(child: Text("Aucun enregistrement trouvé"),) : ListView.builder(
                        itemCount: posts.map(AffichagePost).toList().length,
                        itemBuilder: (BuildContext context, int index) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Card(
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

                                                width: MediaQuery.of(context).size.width,
                                                height : 150,
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
                                                      Text(posts[index].NomLocation!),

                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Icon(Icons.monitor_heart),
                                                          Icon(Icons.access_time_rounded)
                                                        ],
                                                      )
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
                                  ),
                                  onTap: (){
                                    print("Touché container numero : "+index.toString());
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> postdetails( post: posts[index],id: _auth.currentUser!.uid,)));
                                  },
                                )
                              ],
                            ),
                          );
                        },

                      );
                    }else{
                      return Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              ),





              //Page paramètres
              Container(
                child: Column(
                  children: [
                    FutureBuilder(builder: (context,snapshot){
                      return Text(onlineuser!.statuspaiment ? "Payé" : "Non payé");
                    }),

                    Text("Nom : "+Nom),
                    Text("Prenom : "+Prenom),
                    Text("Date de naissance : "+Age),
                    Text("Sex : "+sex),
                    Text("Type d'utilisateur : "+type_user),
                    //text("Fin de l'abonnement : "+)
                    ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdatePersonne(personne: onlineuser!,)));
                    }, child: Text("Modifier son profil")),
                  ],
                ),
              ),

              //Page Discussions
              Container(
                child: FutureBuilder(builder: (context,snapshot){
                  if(_auth.currentUser!.uid != null){
                    return Message(_auth.currentUser!.uid);
                  }else{
                    return Center(
                      child: Text("Aucun message"),
                    );
                  }

                })
              ),


              //Page De recherche
              Container(
                child: StreamBuilder<List<Post>>(

                  stream: datas,
                  builder: (context,snapshot){
                    if(snapshot.hasError){
                      print(snapshot.error);
                      return Text("Une erreur s'est produite : ${snapshot.error}",);
                    }
                    else if(snapshot.hasData){
                      final posts = snapshot.data!;
                      return posts.isEmpty ? Center(child: Text("Aucun enregistrement trouvé"),) : Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Search",suffixIcon: Icon(Icons.search),

                            ),
                            onChanged: (value){
                              setState((){
                                name = value;
                              });

                            },
                          ),
                          //Utilisation de Expanded pour oqp toute la place disponible
                          Expanded(
                            child: ListView.builder(
                              itemCount: posts.map(AffichagePost).toList().length,
                              itemBuilder: (BuildContext context, int index) {
                                if(name.isEmpty){

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
                                        ),

                                      ],
                                    ),
                                  );

                                }
                                else if(posts[index].Quartier.toLowerCase().toString().startsWith(name.toLowerCase())){
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
                                        ),

                                      ],
                                    ),
                                  );
                                }else{
                                  return Container(
                                    child: Center(
                                      child: Text(""),
                                    ),
                                  );
                                }

                              },

                            ),
                          ),
                        ],
                      );
                    }else{
                      return Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              ),


             Container(
                color: Colors.lightGreenAccent,
              ),
            ],
          ),

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            print("Boutton");
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AjoutPost1()));
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(

          currentIndex: indexpage,
          iconSize: 25,
          selectedFontSize: 15,
          items: [
            BottomNavigationBarItem(

              icon: Icon(Icons.home),
              backgroundColor: Colors.blue,
              label: "Acceuil",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              backgroundColor: Colors.black,
              label: "Parametre",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              backgroundColor: Colors.red,
              label: "Discussions",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              backgroundColor: Colors.green,
              label: "Recherche",
            ),

          ],

          onTap: (index){
            setState((){
              indexpage = index;
              _pageController.jumpToPage(index);
            });
            print(indexpage);
          },
        ),
      ),
    );
  }
}

  Widget AffichagePost(Post post)=> /*ListTile(
    leading: CircleAvatar(child: Text("${post.Pays.toString()}"),),
    title: Text(post.NomLocation),
    subtitle: Text(post.Prix.toString()),
  );*/Container(
    color: Colors.red,
    child: Container(
      height: 50,
      color: Colors.green,

    ),

  );


  Widget AffichagePersonne(Personne personne)=> ListTile(
    leading: CircleAvatar(child: Text("${personne.Nom}"),),
    title: Text(personne.Age.toIso8601String()),
  );

