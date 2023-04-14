import 'dart:async';
import 'dart:math';
import 'package:cinetpay/cinetpay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locationdemaison/Model/Personne.dart';
import 'package:locationdemaison/Screen/splashscreen_wrapper.dart';
import 'package:locationdemaison/services/authentication.dart';
import 'package:locationdemaison/services/paiementservice.dart';

Future main() async {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController amountController = new TextEditingController();
  Map<String, dynamic>? response;
  Color? color;
  IconData? icon;
  bool show = false;
  Personne? onlineuser;
  PaiementService paiementService = PaiementService();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AuthenticationService _authenticationService = AuthenticationService();
    _authenticationService.readUserConnected(_auth.currentUser!.uid).then((value) {
      this.onlineuser = value;
      return value;
      //Navigator.push(context, new MaterialPageRoute(builder: (context) => new chat(partenaire: value, id: this.widget.id)));
    });

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String title = 'CinetPay Demo';
    return GetMaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text(title),
            centerTitle: true,
          ),
          body: SafeArea(
              child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          show ? Icon(icon, color: color, size: 150) : Container(),
                          show ? SizedBox(height: 50.0) : Container(),
                          SizedBox(height: 50.0),
                          SizedBox(height: 50.0),
                          new Text(onlineuser?.statuspaiment == false ?"Continuer vers le paiement" : ""),
                          SizedBox(height: 40.0),
                          onlineuser?.statuspaiment == false ?
                          ElevatedButton(
                            child: Text("Payer"),
                            onPressed: () async {
                              String amount = "200";
                              if(amount.isEmpty) {
                                // Mettre une alerte
                                return;
                              }
                              double _amount = double.tryParse(amount) as double;
                              try {
                                _amount = double.parse(amount);

                                if (_amount < 100) {
                                  // Mettre une alerte
                                  return;
                                }

                                if (_amount > 1500000) {
                                  // Mettre une alerte
                                  return;
                                }
                              }

                              catch (exception) {
                                return;
                              }

                              amountController.clear();

                              final String transactionId0 = Random().nextInt(100000000).toString(); // Mettre en place un endpoint à contacter cêté serveur pour générer des ID unique dans votre BD

                              await Get.to(CinetPayCheckout(
                                title: 'Payment Checkout',
                                titleStyle: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold
                                ),
                                titleBackgroundColor: Colors.green,
                                configData: <String, dynamic> {
                                  'apikey': '66623283664389d2a61b6a6.75178443',
                                  'site_id': 958655,
                                  'notify_url': 'https://github.com/ammanel/Auto-ecole-en-ligne'
                                },
                                paymentData: <String, dynamic> {
                                  'transaction_id': transactionId0,
                                  'amount': _amount,
                                  'currency': 'XOF',
                                  'channels': 'ALL',
                                  'description': 'Payment test',
                                },
                                waitResponse: (data) {
                                  if (mounted) {
                                    setState(() {
                                      response = data;
                                      print(response);
                                      icon = data['status'] == 'ACCEPTED' ? Icons.check_circle : Icons.mood_bad_rounded;
                                      color = data['status'] == 'ACCEPTED' ? Colors.green : Colors.redAccent;
                                      data['status'] == "ACCEPTED" ? paiementService.CreatePaiment(Telephone: onlineuser!.Numero_tel, montant: int.parse(amount), user_id: onlineuser!.id) : null;
                                      show = true;
                                      Get.back();
                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> Splashscreen()));

                                    });
                                  }
                                },
                                onError: (data) {
                                  if (mounted) {
                                    setState(() {
                                      response = data;
                                      print("Erreur : "+response.toString());
                                      icon = Icons.warning_rounded;
                                      color = Colors.yellowAccent;
                                      show = true;
                                      Get.back();
                                    });
                                  }
                                },
                              ));
                            },
                          ) : Text("Abonnement actif"),
                          ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("Retour"))
                        ],
                      ),
                    ],
                  )
              )
          )
      ),
    );
  }
}