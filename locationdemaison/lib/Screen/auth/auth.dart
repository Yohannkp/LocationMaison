import 'package:flutter/material.dart';
import 'package:locationdemaison/common/constante.dart';
import 'package:locationdemaison/common/loading.dart';
import 'package:locationdemaison/services/authentication.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final AuthenticationService _authenticationService = AuthenticationService();
  final _formkey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  String mail = "";
  String password = "";

  final emailcontroller = TextEditingController();
  final passwordController = TextEditingController();
  bool showSignIn = true;

  dynamic result;

  @override
  void dispose(){
    emailcontroller.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toggleView(){
    setState(() {
      _formkey.currentState?.reset();
      emailcontroller.text = "";
      passwordController.text = "";
      showSignIn = !showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    Null firebaseresponse;
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation:
        0.0,
        title: Text(showSignIn ? "Connexion" : "Inscription"),
        actions: [
          TextButton(
              onPressed: ()=> toggleView(),
              child: Row(
                children: [
                  new Icon(Icons.person,size: 20,color: Colors.white,),
                  Text(showSignIn ? "Inscription" : "Connexion",style: TextStyle(color: Colors.white),),
                ],
              )
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 30.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: emailcontroller,
                decoration: textInputDecoration.copyWith(hintText: "Mail"),
                validator: (value) =>value!.isEmpty ? "Entrer votre mail" : null,
              ),
              SizedBox(height: 10.0,),
              TextFormField(
                controller: passwordController,
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                obscureText: true,
                validator: (value) =>value!.length < 6 ? "Entrez un momt de passe avec au moins 4 caractères" : null,
              ),
              ElevatedButton(onPressed: () async =>{
                if(_formkey.currentState!.validate()){
                  setState(()=>{
                    loading = true

                  } ),
                  password = passwordController.value.text,
                  mail = emailcontroller.value.text,

                  result = showSignIn
                      ? await _authenticationService.signInWithEmailAndPassword(mail, password) : await _authenticationService.registerInWithEmailAndPassword(mail, password),
                      
                  firebaseresponse = null,
                  if(firebaseresponse == null){
                    setState((){
                      loading = false;
                      error = "Erreur pendant la connexion";
                    })
                  }

                }

              }
                  , child: Text(showSignIn ? "Connexion" : "Inscription")),
              SizedBox(height: 10.0,),
              Text(error,style: TextStyle(color: Colors.red),)
            ],
          ),
        ),
      ),
    );
  }
}
