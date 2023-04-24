import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailEtPassword extends StatefulWidget {
  const EmailEtPassword({Key? key}) : super(key: key);

  @override
  State<EmailEtPassword> createState() => _EmailEtPasswordState();
}

class _EmailEtPasswordState extends State<EmailEtPassword> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var numberForm = GlobalKey<FormState>();
  var email ;
  var pass ;
  var messageEmail;
  var messagePass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Numero De Telephone"),
        leading: Builder(
          builder: (BuildContext context){
            return IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back));
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
                "images/email.svg",
                height: 160,
                width: 160,
              ),
              SizedBox(height: 90.0,),
              Row(
                children: [
                  SizedBox(width: 15.0,),
                  Text(
                    "Changer votre email :",
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
                    return "Enter votre email !";
                },
                keyboardType: TextInputType.text,
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: messageEmail,
                  prefixIcon: Icon(Icons.arrow_right),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30,),
              Row(
                children: [
                  SizedBox(width: 15.0,),
                  Text(
                    "Changer votre mot de passe :",
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
                    return "Enter votre mot de passe !";
                },
                keyboardType: TextInputType.text,
                controller: passController,
                decoration: InputDecoration(
                  labelText: "Mot de Passe",
                  hintText: messagePass,
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
                      messageEmail=getEmail();
                      messagePass=getPass();
                    });
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
  String getEmail(){
    email = emailController.text ;
    return email ;
  }
  String getPass(){
    pass = passController.text ;
    return pass ;
  }
}
