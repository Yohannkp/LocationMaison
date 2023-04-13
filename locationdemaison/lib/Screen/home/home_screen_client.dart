import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locationdemaison/Model/Personne.dart';
import 'package:locationdemaison/Model/Post.dart';
import 'package:locationdemaison/Screen/Pages/AjoutPost1.dart';
import 'package:locationdemaison/Screen/Pages/Informations.dart';
import 'package:locationdemaison/Screen/Pages/postdetails.dart';
import 'package:locationdemaison/services/PostService.dart';
import 'package:locationdemaison/services/authentication.dart';
class home_screen_client extends StatefulWidget {
  const home_screen_client({Key? key}) : super(key: key);

  @override
  State<home_screen_client> createState() => _home_screen_clientState();
}

class _home_screen_clientState extends State<home_screen_client> {

  final AuthenticationService _authenticationService = AuthenticationService();
  final PostService postService = PostService();
  int indexpage = 0;
  late PageController _pageController;
  late String nom;


  @override
  void initState(){

    _pageController = PageController();
    super.initState();


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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final datas = postService.readAllPosts();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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

                  stream: postService.readAllPosts(),
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> postdetails( post: posts[index],)));
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
                child: FutureBuilder(
                  future: getOnlineUser(),
                  builder: (context,snapshot){
                    if(snapshot.hasData) {
                      if(snapshot.data != null){
                        return Column(
                          children: [
                            Text("Nom : " + snapshot.data!.Nom),
                            Text("Prenom : " + snapshot.data!.Prenom),
                            Text("Date de naissance : " +
                                snapshot.data!.Age.toIso8601String()),
                            Text("Sex : " + snapshot.data!.Sex),
                            Text("Type d'utilisateur : " +
                                snapshot.data!.type_user),
                            ElevatedButton(onPressed: () {
                              Personne p = new Personne(id: "",uid: "uid",
                                  image_profile: "image_profile",
                                  Numero_tel: "Numero_tel",
                                  Nom: "Nom",
                                  Prenom: "Prenom",
                                  Age: DateTime.now(),
                                  Sex: "Sex",
                                  Mail: "Mail",
                                  type_user: "type_user");
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => Informations()));
                            }, child: Text("Modifier son profil")),
                          ],
                        );
                      }else{return Center(child: CircularProgressIndicator(),);}

                    }else{
                      return Center(child: CircularProgressIndicator(),);
                    }


                  }
                ),
              ),

              Container(
                color: Colors.green,
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

            ],
          ),

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

