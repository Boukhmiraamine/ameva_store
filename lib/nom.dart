import 'package:flutter/material.dart';
import 'package:app11/mydrawerheader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Nom extends StatefulWidget {
  Nom({Key? key}) : super(key: key);
  // late final String? messageNom;
  // late final String? messagePrenom;
  @override
  State<Nom> createState() => _NomState();
}

class _NomState extends State<Nom> {
  var nomController = TextEditingController();
  var prenomController = TextEditingController();
  var numberForm = GlobalKey<FormState>();
  var nom ;
  var prenom ;
  var messageNom;
  var messagePrenom;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nom et Prenom"),
        leading: Builder(
          builder: (BuildContext context){
            return IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)) ;
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: numberForm,
          child: Column(
            children: [
              SizedBox(height: 60.0,),
              SvgPicture.asset(
                  "images/name.svg",
                height: 160,
                width: 160,
              ),
              SizedBox(height: 90.0,),
              Row(
                children: [
                  SizedBox(width: 15.0,),
                  Text(
                    "Changer votre nom :",
                    style: GoogleFonts.questrial(
                        fontWeight: FontWeight.w600,
                        fontSize: 25
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                //onChanged: (){},
                validator: (val) {
                  if (val!.isEmpty)
                    return "Enter votre nom !";
                },
                keyboardType: TextInputType.text,
                controller: nomController,
                decoration: InputDecoration(
                  labelText: "Nom",
                  //hintText: messageNom,
                  prefixIcon: Icon(Icons.arrow_right),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30,),
              Row(
                children: [
                  SizedBox(width: 15.0,),
                  Text(
                    "Changer votre prenom :",
                    style: GoogleFonts.questrial(
                        fontWeight: FontWeight.w600,
                        fontSize: 25
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                validator: (val) {
                  if (val!.isEmpty)
                    return "Enter votre prenom !";
                },
                keyboardType: TextInputType.text,
                controller: prenomController,
                decoration: InputDecoration(
                  labelText: "Prenom",
                  //hintText: messagePrenom,
                  prefixIcon: Icon(Icons.arrow_right),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                width: 30,
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  if(numberForm.currentState!.validate()){
                    setState(() {
                      messageNom=getNom();
                      messagePrenom=getPrenom();
                    });
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyDrawerHeader(profileNom: widget.messageNom,profilePrenom: widget.messagePrenom,)));
                  }
                },
                style: ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.fromLTRB(140.0, 5.0, 140.0, 5.0)),
                ),
                child: Text(
                  "Modifier",
                  style: TextStyle(fontSize: 15),
              ),
              ),
              SizedBox(
                width: 20.0,
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
  String getNom(){
    nom = nomController.text ;
    return nom ;
  }
  String getPrenom(){
    prenom = prenomController.text ;
    return prenom ;
  }
}
