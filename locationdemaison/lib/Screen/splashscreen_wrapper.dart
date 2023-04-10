import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locationdemaison/Model/Post.dart';
import 'package:locationdemaison/Model/user.dart';
import 'package:locationdemaison/Screen/Pages/AjoutPost1.dart';
import 'package:locationdemaison/Screen/Pages/Informations.dart';
import 'package:locationdemaison/Screen/Pages/info_post_1.dart';
import 'package:locationdemaison/Screen/Pages/info_post_2.dart';
import 'package:locationdemaison/Screen/Pages/searchpage.dart';
import 'package:locationdemaison/Screen/auth/auth.dart';
import 'package:locationdemaison/Screen/home/home_screen_vendeur.dart';
import 'package:provider/provider.dart';
import 'package:locationdemaison/Screen/Pages/AjoutPost2.dart';
import 'Pages/type_User.dart';
class Splashscreen extends StatelessWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser?>(context);

    if(user == null){
      return Auth();
    }else{
      print(user.uid);
      return home_screen_vendeur();
    }
  }
}
