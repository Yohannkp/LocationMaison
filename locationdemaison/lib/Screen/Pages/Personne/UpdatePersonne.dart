import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:locationdemaison/Model/Personne.dart';
import 'package:locationdemaison/Screen/Pages/type_User.dart';
import 'package:locationdemaison/common/constante.dart';
import 'package:locationdemaison/services/authentication.dart';
class UpdatePersonne extends StatefulWidget {

  Personne personne;
  UpdatePersonne({required this.personne});

  @override
  State<UpdatePersonne> createState() => _UpdatePersonne();
}

class _UpdatePersonne extends State<UpdatePersonne> {
  final AuthenticationService _authenticationService = AuthenticationService();
  final _formkey = GlobalKey<FormState>();
  String error = '';
  bool loading = true;
  String mail = "";
  String password = "";
  String telephone = "";
  DateTime date = DateTime.now();
  bool dateset = false;
  String sex = "";


  bool showSignIn = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  String Nom = "";
  String Prenom = "";
  String Age = "";
  String type_user = "";
  String Sex = "";

  Future<Personne> getOnlineUser() async{
    Personne personne = await _authenticationService.readUser();
    setState(() {
      Nom = personne.Nom!;
      Prenom = personne.Prenom!;
      Age = personne.Age.toIso8601String();
      type_user = personne.type_user!;
      Sex = personne.Sex!;
    });
    return personne;


  }

  dynamic result;

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

  List<String> items = [
    'Homme',
    'Femme'
  ];
  String dropdownValue = 'Homme';

  void _showDate(){
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now()).then((value) => {
      setState((){
        date = value!;
        dateset = true;

      })
    });

  }


  void dropdown(String? select){
    if(select is String){
      setState(() {
        sex = select;
      });
    }
  }

  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final DateController = TextEditingController();
  final SexController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nomController.text = this.widget.personne.Nom;
    prenomController.text = this.widget.personne.Prenom;
    DateController.text = this.widget.personne.Age.toIso8601String();

  }
  @override
  Widget build(BuildContext context) {
    Null firebaseresponse;

    return Scaffold(
      backgroundColor: Colors.white,
      body: loading ? Container(
        padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 30.0),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10.0,),
              TextFormField(
                controller: nomController,
                initialValue: null,
                decoration: textInputDecoration.copyWith(hintText: "Nom"),
                validator: (value) =>value!.isEmpty ? "Entrer votre nom" : null,
              ),
              SizedBox(height: 10.0,),

              TextFormField(
                controller: prenomController,
                decoration: textInputDecoration.copyWith(hintText: "Prenom"),
                obscureText: true,
                validator: (value) =>value!.length < 6 ? "Entrez votre prenom" : null,
              ),
              SizedBox(height: 10.0,),
              DropdownButton<String>(
                value: dropdownValue,
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue ?? '';
                  });
                },
              ),

              SizedBox(height: 10.0,),
              ElevatedButton(onPressed: () async =>{
                if(_formkey.currentState!.validate()){
                  setState(()=>{
                    loading = false,
                  } ),


                  firebaseresponse = null,
                  if(firebaseresponse == null){
                    //_authenticationService.UpdateUser("", nomController.text, prenomController.text, date!, mail, dropdownValue,telephone),

                    Future.delayed(Duration(seconds: 2), () {
                      // Code à exécuter après 5 secondes
                      setState((){
                        loading = true;
                      });

                      print("Loading end");
                    }),

                    this.widget.personne.Nom = nomController.text,
                    this.widget.personne.Prenom = prenomController.text,
                    this.widget.personne.Sex = dropdownValue,


                    _authenticationService.UpdateUser(this.widget.personne)

                  }

                }

              }
                  , child: Text("Valider")),
              SizedBox(height: 10.0,),
              Text(error,style: TextStyle(color: Colors.red),)
            ],
          ),
        ),
      ) : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
