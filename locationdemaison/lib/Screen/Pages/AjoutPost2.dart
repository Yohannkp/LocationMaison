import 'dart:io';

import 'package:flutter/material.dart';
import 'package:locationdemaison/Screen/Pages/AjoutPost1.dart';

import '../../Model/Post.dart';
import '../../services/PostService.dart';
import '../../services/authentication.dart';
import '../../utils/GetImage.dart';
class AjoutPost2 extends StatefulWidget {


  AjoutPost2(){
  }




  @override
  State<AjoutPost2> createState() => _AjoutPostState();
}

class _AjoutPostState extends State<AjoutPost2> {
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
  List<File> ImageaUpload = [file1,file2,file3,file4,file5];


  bool loading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                    Post post = Post(Pays: "", NomLocation: "", post_id: _AjoutPostState.path, Quartier: "", Region: "", Ville: "", Description: "", Image_maison: "", Image_piece1: "", Image_piece2: "", Image_piece3: "", Image_piece4: "", Date_post: DateTime.now(), Prix: 0, Nombre_chambres: 0, Nombre_likes: 0, Nombre_salon: 0, Nombre_vues: 0);

                    final Urlimage = await PostService().uploadImage(ImageaUpload[i], path: "Post", i: i, post: post);

                  }else if(i == 1){

                    Post post = Post(Pays: "", NomLocation: "", post_id: _AjoutPostState.path, Quartier: "", Region: "", Ville: "", Description: "", Image_maison: "", Image_piece1: "", Image_piece2: "", Image_piece3: "", Image_piece4: "", Date_post: DateTime.now(), Prix: 0, Nombre_chambres: 0, Nombre_likes: 0, Nombre_salon: 0, Nombre_vues: 0);
                    final Urlimage = await PostService().uploadImage(ImageaUpload[i], path: "Post", i: i, post: post);
                  }else if(i == 2){

                    Post post = Post(Pays: "", NomLocation: "", post_id: _AjoutPostState.path, Quartier: "", Region: "", Ville: "", Description: "", Image_maison: "", Image_piece1: "", Image_piece2: "", Image_piece3: "", Image_piece4: "", Date_post: DateTime.now(), Prix: 0, Nombre_chambres: 0, Nombre_likes: 0, Nombre_salon: 0, Nombre_vues: 0);

                    final Urlimage = await PostService().uploadImage(ImageaUpload[i], path: "Post", i: i, post: post);
                  }else if(i == 3){

                    Post post = Post(Pays: "", NomLocation: "", post_id: _AjoutPostState.path, Quartier: "", Region: "", Ville: "", Description: "", Image_maison: "", Image_piece1: "", Image_piece2: "", Image_piece3: "", Image_piece4: "", Date_post: DateTime.now(), Prix: 0, Nombre_chambres: 0, Nombre_likes: 0, Nombre_salon: 0, Nombre_vues: 0);
                    final Urlimage = await PostService().uploadImage(ImageaUpload[i], path: "Post", i: i, post: post);
                  }else if(i == 4){
                    Post post = Post(Pays: "", NomLocation: "", post_id: _AjoutPostState.path, Quartier: "", Region: "", Ville: "", Description: "", Image_maison: "", Image_piece1: "", Image_piece2: "", Image_piece3: "", Image_piece4: "", Date_post: DateTime.now(), Prix: 0, Nombre_chambres: 0, Nombre_likes: 0, Nombre_salon: 0, Nombre_vues: 0);
                    final Urlimage = await PostService().uploadImage(ImageaUpload[i], path: "Post", i: i, post: post);
                  }



                }




              },
                  child: Text("Valider"))
            ],
          ),
        ),
      ) : Center(child: CircularProgressIndicator(),),
    );
  }
}
