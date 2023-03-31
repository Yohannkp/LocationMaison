import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locationdemaison/Model/user.dart';
import 'package:locationdemaison/Screen/auth/auth.dart';
import 'package:locationdemaison/Screen/home/home_screen.dart';
import 'package:provider/provider.dart';
class Splashscreen extends StatelessWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser?>(context);

    if(user == null){
      return Auth();
    }else{
      print(user.uid);
      return home_screen();
    }
  }
}
