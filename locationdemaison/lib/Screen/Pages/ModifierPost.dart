import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:locationdemaison/Model/Post.dart';
import 'package:locationdemaison/common/constante.dart';
import 'package:locationdemaison/services/PostService.dart';
import 'package:locationdemaison/services/authentication.dart';
class ModifierPost extends StatefulWidget {
  final Post post;
  ModifierPost({Key? key, required this.post}) : super(key: key);

  @override
  State<ModifierPost> createState() => _ModifierPostState();
}

class _ModifierPostState extends State<ModifierPost> {

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

  bool pagechange = false;
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
  void initState() {
    // TODO: implement initState

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Null firebaseresponse;
    /*this.nomController.text = this.widget.post.NomLocation;
    this.descriptionController.text = this.widget.post.Description!;
    this.quartierController.text = this.widget.post.Quartier;
    this.prixController.text = this.widget.post.Prix.toString();
    this.countryValue = this.widget.post.Pays!;
    this.stateValue = this.widget.post.Region!;
    this.cityValue = this.widget.post.Ville!;*/
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Modification de : "+this.widget.post.NomLocation),
      ),
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
                ElevatedButton(onPressed: ()  {
                  Post posenvoi = Post(Pays: countryValue, NomLocation: nomController.text, post_id: this.widget.post.post_id, Quartier: quartierController.text, Region: stateValue, Ville: cityValue, Description: descriptionController.text, Image_maison: this.widget.post.Image_maison, Image_piece1: "", Image_piece2: "", Image_piece3: "", Image_piece4: "", Date_post: this.widget.post.Date_post, Prix: int.parse(prixController.text), Nombre_chambres: 0, Nombre_likes: 0, Nombre_salon: 0, Nombre_vues: 0);


                  try{
                    _postService.UpdatePostUser(posenvoi);
                    Navigator.pop(context);
                    Navigator.pop(context);

                  }catch(e){
                    print(e.toString());
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
