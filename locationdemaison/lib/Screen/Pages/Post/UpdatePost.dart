import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:locationdemaison/Model/Post.dart';
import 'package:locationdemaison/common/constante.dart';
import 'package:locationdemaison/services/PostService.dart';
import 'package:locationdemaison/services/authentication.dart';
import 'package:geolocator/geolocator.dart';
class UpdatePost extends StatefulWidget {
  Post postmodif;

  UpdatePost({required this.postmodif});

  @override
  State<UpdatePost> createState() => _UpdatePost();
}

class _UpdatePost extends State<UpdatePost> {

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nomController.text = this.widget.postmodif.NomLocation;
    descriptionController.text = this.widget.postmodif.Description!;
    countryValue = this.widget.postmodif.Pays!;
    stateValue = this.widget.postmodif.Region;
    cityValue = this.widget.postmodif.Ville;
    quartierController.text = this.widget.postmodif.Quartier;
    prixController.text = this.widget.postmodif.Prix.toString();

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Update post"),
      ),
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
                    post = Post(Pays: countryValue, NomLocation: nomController.text, post_id: this.widget.postmodif.post_id, Quartier: quartierController.text, Region: stateValue, Ville: cityValue, Description: descriptionController.text, Image_maison: this.widget.postmodif.Image_maison, Image_piece1: this.widget.postmodif.Image_piece1, Image_piece2: this.widget.postmodif.Image_piece2, Image_piece3: this.widget.postmodif.Image_piece3, Image_piece4: this.widget.postmodif.Image_piece4, Date_post: this.widget.postmodif.Date_post, Prix: int.parse(prixController.text), Nombre_chambres: this.widget.postmodif.Nombre_chambres, Nombre_likes: this.widget.postmodif.Nombre_likes, Nombre_salon: this.widget.postmodif.Nombre_salon, Nombre_vues: this.widget.postmodif.Nombre_vues),
                    _postService.UpdatePost(post),

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
