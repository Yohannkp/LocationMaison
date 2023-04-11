import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:locationdemaison/Model/Personne.dart';
import 'package:locationdemaison/Screen/Pages/type_User.dart';
import 'package:locationdemaison/common/constante.dart';
import 'package:locationdemaison/services/authentication.dart';
class Informations extends StatefulWidget {
  const Informations({Key? key}) : super(key: key);

  @override
  State<Informations> createState() => _InformationsState();
}

class _InformationsState extends State<Informations> {
  final AuthenticationService _authenticationService = AuthenticationService();
  final _formkey = GlobalKey<FormState>();
  String error = '';
  bool loading = true;
  String mail = "";
  String password = "";
  String telephone = "";
  DateTime ?date = new DateTime.now();
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
                date = value;
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
              Container(
                    child: TextButton(onPressed: () { _showDate(); },
                    child: new Text(dateset ? date!=null ? "${date?.day.toString()}/${date?.month.toString()}/${date?.year.toString()}" : "Date" : "Date" )),
                width: 280,
              ),


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
                    _authenticationService.UpdateUser("", nomController.text, prenomController.text, date!, mail, dropdownValue,telephone),

                    Future.delayed(Duration(seconds: 2), () {
                        // Code à exécuter après 5 secondes
                        setState((){
                          loading = true;
                        });

                        print("Loading end");
                        }),
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Type_user())),


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
