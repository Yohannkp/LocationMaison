import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:locationdemaison/Model/user.dart';
import 'package:locationdemaison/Screen/auth/auth.dart';

import 'package:async/async.dart';
import 'package:locationdemaison/Screen/splashscreen_wrapper.dart';
import 'package:locationdemaison/firebase_options.dart';
import 'package:locationdemaison/services/authentication.dart';
import 'package:provider/provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());

}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      value: AuthenticationService().user,
      initialData: null,
      child: MaterialApp(
        home: Splashscreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData
          (
          primarySwatch: Colors.blue,

        ),
      ),
    );
  }
}
