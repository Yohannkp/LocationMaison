import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:locationdemaison/Model/Post.dart';
import 'package:locationdemaison/Screen/Pages/AjoutPost2.dart';
import 'package:locationdemaison/common/constante.dart';
import 'package:locationdemaison/services/PostService.dart';
import 'package:locationdemaison/services/authentication.dart';
import 'package:geolocator/geolocator.dart';
class AjoutPost1 extends StatefulWidget {
  const AjoutPost1({Key? key}) : super(key: key);

  @override
  State<AjoutPost1> createState() => _AjoutPost1StateState();
}

class _AjoutPost1StateState extends State<AjoutPost1> {

  final PostService _postService = PostService();
  late final Post post;
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
    return Scaffold(
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
                      Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                        return new AjoutPost2();
                      })),
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
                SizedBox(height: 10.0,),
                Text(error,style: TextStyle(color: Colors.red),)
              ],
            ),
          ),
        ),
      ) : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
