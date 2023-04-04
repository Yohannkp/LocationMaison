
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:locationdemaison/Model/Post.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:path/path.dart' as Path;

class PostService{


  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final PostService postService = PostService();



  Stream<List<Post>> readPosts()=>FirebaseFirestore.instance.collection("Post").where("uid",isEqualTo: _auth.currentUser?.uid).snapshots().map((snapshot) => snapshot.docs.map((doc) =>Post.fromJson(doc.data())).toList());


  Future<String?> uploadImage(File file,{required String path,required int i,required Post post}) async {
      PostService postService = PostService();
      var time = DateTime.now();
      var ext = Path.basename(file.path).split(".").last;
      String image = path+"_"+Path.basename(file.path).split(".")[0].toString()+time.toString()+"."+ext;
      String? urlimage = path+"/"+image;
      print(urlimage);

      try{

        final ref = FirebaseStorage.instance.ref().child(path+"/").child(image);
        print("On upload l'image");
        UploadTask uploadTask = ref.putFile(file);
        uploadTask.then((res) async {
          final link = await res.ref.getDownloadURL();
          print(link);
          if(i == 0){
            post.Image_maison = link;
            postService.UpdateImageMaison(post);
          }else if(i == 1){
            post.Image_piece1 = link;
            postService.UpdateImagePiece1(post);
          }else if(i == 2){
            post.Image_piece2 = link;
            postService.UpdateImagePiece2(post);
            }else if(i == 3){
            post.Image_piece3 = link;
            postService.UpdateImagePiece3(post);
            }else if(i == 4){
            post.Image_piece4 = link;
            postService.UpdateImagePiece4(post);
            }
          return link;
          print("Cherchons l'image");
        });



      }catch(e){
        print("Voici l'erreur : "+e.toString());
        return null;
      }
  }

  Future UpdatePost(Post post) async{
    final docPost = FirebaseFirestore.instance.collection("Post").doc(post.post_id);

    docPost.update(
      {
        "NomLocation": post.NomLocation,
        "Description" : post.Description,
        "Ville" : post.Ville,
        "Quartier": post.Quartier,
        "Pays": post.Pays,
        "Prix" : post.Prix
      }
    );



  }



  Future<String> AjoutPost(Post post) async{
    final docPost = FirebaseFirestore.instance.collection("Post").doc();
    String path = docPost.path.split("/")[1];
    print(path);
    post.post_id = path;
    final data = post.toJson();
    docPost.set(
      data
    );

    return path;
  }

  Future UpdateImageMaison(Post post) async{
    final docPost = FirebaseFirestore.instance.collection("Post").doc(post.post_id);
    print("Update de l'image de la maison");
    docPost.update(
        {
          "Image_maison" : post.Image_maison,

        }
    );
    print("Update de l'image de la maison");
  }Future UpdateImagePiece1(Post post) async{
    final docPost = FirebaseFirestore.instance.collection("Post").doc(post.post_id);
    print("Update de l'image de la maison");
    docPost.update(
        {

          "Image_piece1" : post.Image_piece1,

        }
    );
    print("Update de l'image de la maison");
  }Future UpdateImagePiece2(Post post) async{
    final docPost = FirebaseFirestore.instance.collection("Post").doc(post.post_id);
    print("Update de l'image de la maison");
    docPost.update(
        {
          "Image_piece2" : post.Image_piece2,

        }
    );
    print("Update de l'image de la maison");
  }Future UpdateImagePiece3(Post post) async{
    final docPost = FirebaseFirestore.instance.collection("Post").doc(post.post_id);
    print("Update de l'image de la maison");
    docPost.update(
        {

          "Image_piece3" : post.Image_piece3,

        }
    );
    print("Update de l'image de la maison");
  }Future UpdateImagePiece4(Post post) async{
    final docPost = FirebaseFirestore.instance.collection("Post").doc(post.post_id);
    print("Update de l'image de la maison");
    docPost.update(
        {

          "Image_piece4" : post.Image_piece4,
        }
    );
    print("Update de l'image de la maison");
  }




}