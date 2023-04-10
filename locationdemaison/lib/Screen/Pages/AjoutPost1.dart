import 'dart:io';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:locationdemaison/Model/Personne.dart';
import 'package:locationdemaison/Model/Post.dart';
import 'package:locationdemaison/Screen/Pages/AjoutPost2.dart';
import 'package:locationdemaison/Screen/home/home_screen_vendeur.dart';
import 'package:locationdemaison/common/constante.dart';
import 'package:locationdemaison/services/PostService.dart';
import 'package:locationdemaison/services/authentication.dart';
import 'package:geolocator/geolocator.dart';
import '../../utils/GetImage.dart';
class AjoutPost1 extends StatefulWidget {
  const AjoutPost1({Key? key}) : super(key: key);

  @override
  State<AjoutPost1> createState() => _AjoutPost1StateState();
}

class _AjoutPost1StateState extends State<AjoutPost1> {
  static File file1 = File("");
  static File file2 = File("");
  static File file3 = File("");
  static File file4 = File("");
  static File file5 = File("");
  static String? path;
  bool statutimage0 = true;
  bool statutimage1 = true;
  bool statutimage2 = true;
  bool statutimage3 = true;
  bool statutimage4 = true;
  String? pathobjet;
  List<File> ImageaUpload = [file1,file2,file3,file4,file5];


  bool loading = true;
  final PostService _postService = PostService();
  late final Post post;
  final AuthenticationService _authenticationService = AuthenticationService();
  final _formkey = GlobalKey<FormState>();
  String error = '';
  String mail = "";
  String password = "";
  String telephone = "";
  DateTime ?date = new DateTime.now();
  bool dateset = false;
  String sex = "";

  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final DateController = TextEditingController();
  final SexController = TextEditingController();
  final descriptionController = TextEditingController();
  final prixController = TextEditingController();
  final quartierController = TextEditingController();
  bool showSignIn = true;
  var countryValue = null;
  var stateValue = null;
  var cityValue = null;


  dynamic result;
  bool page = true;

  @override
  void dispose(){
    nomController.dispose();
    prenomController.dispose();
    DateController.dispose();
    SexController.dispose();
    super.dispose();
  }

  void toggleView(){
    setState(() {
      _formkey.currentState?.reset();
      nomController.text = "";
      prenomController.text = "";
      DateController.text = "";
      SexController.text = "";
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    Null firebaseresponse;
    
    Future postasend;

    return page ? Scaffold(
      backgroundColor: Colors.white,
      body: loading ? SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 30.0),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: nomController,

                  decoration: textInputDecoration.copyWith(hintText: "Nom de l'appartement"),
                  validator: (value) =>value!.isEmpty ? "Entrer un nom s'il vous plait" : null,
                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: descriptionController,
                  maxLines: null,
                  validator: (value) =>value!.isEmpty ? "Ce champ est requis" : null,
                  keyboardType: TextInputType.multiline,

                  decoration: InputDecoration(
                    hintText: 'Décrivez votre appartement',
                    border: OutlineInputBorder(),

                  ),

                ),
                SizedBox(height: 10.0,),
                SelectState(
                  onCountryChanged: (value) {
                    setState(() {
                      countryValue = value;
                    });
                  },
                  onStateChanged:(value) {
                    setState(() {
                      stateValue = value;
                    });
                  },
                  onCityChanged:(value) {
                    setState(() {
                      cityValue = value;
                    });
                  },

                ),
                SizedBox(height: 10.0,),
                TextFormField(
                    controller: quartierController,
                    maxLines: null,
                    validator: (value) =>value!.isEmpty ? "Veillez décrire concrètement ou se situ la maison" : null,
                    keyboardType: TextInputType.multiline,

                    decoration: InputDecoration(
                      hintText: "Nécéssaire pour la retrouver",
                      border: OutlineInputBorder(),

                    )),

                TextFormField(
                  controller: prixController,
                  decoration: InputDecoration(
                    labelText: 'Entrer le prix mensuel de la location',
                  ),
                  validator: (value) =>value!.isEmpty ? "Entrer le prix" : null,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),

                SizedBox(height: 10.0,),
                ElevatedButton(onPressed: () async =>{
                  if(_formkey.currentState!.validate()){
                    setState(()=>{
                      loading = false,
                    } ),
                    post = Post(Pays: countryValue, NomLocation: nomController.text, post_id: "", Quartier: quartierController.text, Region: stateValue, Ville: cityValue, Description: descriptionController.text, Image_maison: "", Image_piece1: "", Image_piece2: "", Image_piece3: "", Image_piece4: "", Date_post: DateTime.now(), Prix: int.parse(prixController.text), Nombre_chambres: 0, Nombre_likes: 0, Nombre_salon: 0, Nombre_vues: 0),
                    postasend = _postService.AjoutPost(post),

                    print("Redirection vers une autre page"),
                    if (postasend!= null){
                      setState((){
                        page = false;
                        postasend.then((value) => this.pathobjet = value);
                      })
                      },

                    firebaseresponse = null,
                    if(firebaseresponse == null){

                      Future.delayed(Duration(seconds: 2), () {
                        // Code à exécuter après 5 secondes
                        setState((){
                          loading = true;
                        });

                        print("Loading end");
                      })

                    }

                  }

                }
                    , child: Text("Valider")),
                ElevatedButton(onPressed: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=> home_screen_vendeur()));
                  Navigator.pop(context);
                }, child: Text("Annuler")),
                SizedBox(height: 10.0,),
                Text(error,style: TextStyle(color: Colors.red),)
              ],
            ),
          ),
        ),
      ) : Center(
        child: CircularProgressIndicator(),
      ),
    ) : Scaffold(
      appBar: AppBar(
        title: Text(pathobjet!),
      ),
      body: loading ? Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(


                child: Column(
                    children:[
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            InkWell(
                              child: Container(
                                color: Colors.pink,
                                width: 350,
                                height: 250,
                                child:statutimage0 ?  Icon(Icons.add,color: Colors.white,) : Image.file(ImageaUpload[0],fit: BoxFit.cover,),
                              ),
                              onTap: () async {
                                final data = await showModalBottomSheet(context: context, builder: (ctx){
                                  return GetImage();



                                });

                                setState(() {
                                  ImageaUpload[0] = data;
                                  statutimage0 = false;
                                });
                                print(ImageaUpload);
                                /*
                                String? Urlimage = await PostService().uploadImage(data, path: "Post");
                                if(Urlimage != null){
                                  print("Update de limage");
                                    Post post = Post(Pays: "", NomLocation: "", post_id: "", Quartier: "", Region: "", Ville: "", Description: "", Image_maison: Urlimage, Image_piece1: "", Image_piece2: "", Image_piece3: "", Image_piece4: "", Date_post: DateTime.now(), Prix: 0, Nombre_chambres: 0, Nombre_likes: 0, Nombre_salon: 0, Nombre_vues: 0);
                                    postService.UpdateImageMaison(post);
                                }else{
                                  print("L'url est nul");
                                }*/
                                if(data!= null){
                                  loading = false;
                                  setState(() { });
                                  Future.delayed(Duration(seconds: 2), () {

                                    // Code à exécuter après 5 secondes
                                    setState(() {
                                      loading = true;
                                    });
                                  }
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Text("Choisissez une image de votre appartement"),
                      Text("vu de l'extérieur")
                    ]

                ),
              ),

              SizedBox(height: 50.0,),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Choisissez des photos d'intérieurs"),
                  ],
                ),
              ),
              SizedBox(height: 10.0,),
              Container(


                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                          color: Colors.pink,
                          width: 150,
                          height: 150,
                          child:statutimage1 ?  Icon(Icons.add,color: Colors.white,) : Image.file(ImageaUpload[1],fit: BoxFit.cover,),
                        ),
                        onTap: () async {
                          final data = await showModalBottomSheet(context: context, builder: (ctx){
                            return GetImage();



                          });

                          setState(() {
                            ImageaUpload[1] = data;
                            statutimage1 = false;
                          });
                          print(ImageaUpload);
                          /*
                                String? Urlimage = await PostService().uploadImage(data, path: "Post");
                                if(Urlimage != null){
                                  print("Update de limage");
                                    Post post = Post(Pays: "", NomLocation: "", post_id: "", Quartier: "", Region: "", Ville: "", Description: "", Image_maison: Urlimage, Image_piece1: "", Image_piece2: "", Image_piece3: "", Image_piece4: "", Date_post: DateTime.now(), Prix: 0, Nombre_chambres: 0, Nombre_likes: 0, Nombre_salon: 0, Nombre_vues: 0);
                                    postService.UpdateImageMaison(post);
                                }else{
                                  print("L'url est nul");
                                }*/
                          if(data!= null){
                            loading = false;
                            setState(() { });
                            Future.delayed(Duration(seconds: 2), () {

                              // Code à exécuter après 5 secondes
                              setState(() {
                                loading = true;
                              });
                            }
                            );
                          }
                        },
                      ),
                      SizedBox(width: 80.0,),
                      InkWell(
                        child: Container(
                          color: Colors.pink,
                          width: 150,
                          height: 150,
                          child:statutimage2 ?  Icon(Icons.add,color: Colors.white,) : Image.file(ImageaUpload[2],fit: BoxFit.cover,),
                        ),
                        onTap: () async {
                          final data = await showModalBottomSheet(context: context, builder: (ctx){
                            return GetImage();



                          });

                          setState(() {
                            ImageaUpload[2] = data;
                            statutimage2 = false;
                          });
                          print(ImageaUpload);
                          /*
                                String? Urlimage = await PostService().uploadImage(data, path: "Post");
                                if(Urlimage != null){
                                  print("Update de limage");
                                    Post post = Post(Pays: "", NomLocation: "", post_id: "", Quartier: "", Region: "", Ville: "", Description: "", Image_maison: Urlimage, Image_piece1: "", Image_piece2: "", Image_piece3: "", Image_piece4: "", Date_post: DateTime.now(), Prix: 0, Nombre_chambres: 0, Nombre_likes: 0, Nombre_salon: 0, Nombre_vues: 0);
                                    postService.UpdateImageMaison(post);
                                }else{
                                  print("L'url est nul");
                                }*/
                          if(data!= null){
                            loading = false;
                            setState(() { });
                            Future.delayed(Duration(seconds: 2), () {

                              // Code à exécuter après 5 secondes
                              setState(() {
                                loading = true;
                              });
                            }
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50.0,),
              Container(


                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                          color: Colors.pink,
                          width: 150,
                          height: 150,
                          child:statutimage3 ?  Icon(Icons.add,color: Colors.white,) : Image.file(ImageaUpload[3],fit: BoxFit.cover,),
                        ),
                        onTap: () async {
                          final data = await showModalBottomSheet(context: context, builder: (ctx){
                            return GetImage();



                          });

                          setState(() {
                            ImageaUpload[3] = data;
                            statutimage3 = false;
                          });
                          print(ImageaUpload);
                          /*
                                String? Urlimage = await PostService().uploadImage(data, path: "Post");
                                if(Urlimage != null){
                                  print("Update de limage");
                                    Post post = Post(Pays: "", NomLocation: "", post_id: "", Quartier: "", Region: "", Ville: "", Description: "", Image_maison: Urlimage, Image_piece1: "", Image_piece2: "", Image_piece3: "", Image_piece4: "", Date_post: DateTime.now(), Prix: 0, Nombre_chambres: 0, Nombre_likes: 0, Nombre_salon: 0, Nombre_vues: 0);
                                    postService.UpdateImageMaison(post);
                                }else{
                                  print("L'url est nul");
                                }*/
                          if(data!= null){
                            loading = false;
                            setState(() { });
                            Future.delayed(Duration(seconds: 2), () {

                              // Code à exécuter après 5 secondes
                              setState(() {
                                  loading = true;
                              });
                            }
                            );
                          }
                        },
                      ),
                      SizedBox(width: 80.0,),

                      InkWell(
                        child: Container(
                          color: Colors.pink,
                          width: 150,
                          height: 150,
                          child:statutimage4 ?  Icon(Icons.add,color: Colors.white,) : Image.file(ImageaUpload[4],fit: BoxFit.cover,),
                        ),
                        onTap: () async {
                          final data = await showModalBottomSheet(context: context, builder: (ctx){
                            return GetImage();



                          });

                          setState(() {
                            ImageaUpload[4] = data;
                            statutimage4 = false;
                          });
                          print(ImageaUpload);
                          /*
                                String? Urlimage = await PostService().uploadImage(data, path: "Post");
                                if(Urlimage != null){
                                  print("Update de limage");
                                    Post post = Post(Pays: "", NomLocation: "", post_id: "", Quartier: "", Region: "", Ville: "", Description: "", Image_maison: Urlimage, Image_piece1: "", Image_piece2: "", Image_piece3: "", Image_piece4: "", Date_post: DateTime.now(), Prix: 0, Nombre_chambres: 0, Nombre_likes: 0, Nombre_salon: 0, Nombre_vues: 0);
                                    postService.UpdateImageMaison(post);
                                }else{
                                  print("L'url est nul");
                                }*/
                          if(data!= null){
                            loading = false;
                            setState(() { });
                            Future.delayed(Duration(seconds: 2), () {

                              // Code à exécuter après 5 secondes
                              setState(() {
                                loading = true;
                              });
                            }
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),

              ElevatedButton(onPressed: () async{


                for(int i =0;i<ImageaUpload.length;i++){

                  if(i == 0){

                    Post post = Post(Pays: "", NomLocation: "", post_id: pathobjet, Quartier: "", Region: "", Ville: "", Description: "", Image_maison: "", Image_piece1: "", Image_piece2: "", Image_piece3: "", Image_piece4: "", Date_post: DateTime.now(), Prix: 0, Nombre_chambres: 0, Nombre_likes: 0, Nombre_salon: 0, Nombre_vues: 0);

                    final Urlimage = await PostService().uploadImage(ImageaUpload[i], path: "Post", i: i, post: post);

                  }else if(i == 1){

                    Post post = Post(Pays: "", NomLocation: "", post_id: pathobjet, Quartier: "", Region: "", Ville: "", Description: "", Image_maison: "", Image_piece1: "", Image_piece2: "", Image_piece3: "", Image_piece4: "", Date_post: DateTime.now(), Prix: 0, Nombre_chambres: 0, Nombre_likes: 0, Nombre_salon: 0, Nombre_vues: 0);
                    final Urlimage = await PostService().uploadImage(ImageaUpload[i], path: "Post", i: i, post: post);
                  }else if(i == 2){

                    Post post = Post(Pays: "", NomLocation: "", post_id: pathobjet, Quartier: "", Region: "", Ville: "", Description: "", Image_maison: "", Image_piece1: "", Image_piece2: "", Image_piece3: "", Image_piece4: "", Date_post: DateTime.now(), Prix: 0, Nombre_chambres: 0, Nombre_likes: 0, Nombre_salon: 0, Nombre_vues: 0);

                    final Urlimage = await PostService().uploadImage(ImageaUpload[i], path: "Post", i: i, post: post);
                  }else if(i == 3){

                    Post post = Post(Pays: "", NomLocation: "", post_id: pathobjet, Quartier: "", Region: "", Ville: "", Description: "", Image_maison: "", Image_piece1: "", Image_piece2: "", Image_piece3: "", Image_piece4: "", Date_post: DateTime.now(), Prix: 0, Nombre_chambres: 0, Nombre_likes: 0, Nombre_salon: 0, Nombre_vues: 0);
                    final Urlimage = await PostService().uploadImage(ImageaUpload[i], path: "Post", i: i, post: post);
                  }else if(i == 4){
                    Post post = Post(Pays: "", NomLocation: "", post_id: pathobjet, Quartier: "", Region: "", Ville: "", Description: "", Image_maison: "", Image_piece1: "", Image_piece2: "", Image_piece3: "", Image_piece4: "", Date_post: DateTime.now(), Prix: 0, Nombre_chambres: 0, Nombre_likes: 0, Nombre_salon: 0, Nombre_vues: 0);
                    final Urlimage = await PostService().uploadImage(ImageaUpload[i], path: "Post", i: i, post: post);
                  }



                }

                setState(() {
                  loading = false;
                });
                Future.delayed(Duration(seconds: 5), () {

                  // Code à exécuter après 5 secondes
                  setState(() {
                    loading = true;
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> home_screen_vendeur()));
                  });

                });

              },
                  child: Text("valider")),

            ],
          ),
        ),
      ) : Center(child: CircularProgressIndicator(),),

    );
  }
}
