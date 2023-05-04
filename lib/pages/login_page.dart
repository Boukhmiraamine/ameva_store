import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../services/auth_service.dart';
import '../square_tile_Google.dart';
import 'Forgot_pw_page.dart';


class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key,required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//for hide password
  bool _obscureText=true;

  final _formkey = GlobalKey<FormState>();
// text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isAdmin = false;


  Future signIn() async{
    if (_formkey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } catch (e) {
        // Afficher un message d'erreur stylé
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Erreur d'authentification"),
              content: Text("L'email ou le mot de passe est incorrect. Veuillez réessayer."),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }
  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon(Icons.android,size: 100,),
              SizedBox(height: 20),
              //Hello
              SizedBox(
                height: 190,
                width: 190,
                child:
                Lottie.asset('images/loginlottie.json'),
              ),
              Text("Commencer sur Ameva Store!", style: TextStyle(fontWeight:FontWeight.bold,fontSize: 23.0),),
              SizedBox(height: 7.0,),
              Text(
                'Entrez vos coordonées ci-dessous',
                style: TextStyle( fontSize: 18,),
              ),

              SizedBox(height: 20,),
              //email textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color:Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      border:InputBorder.none,
                      contentPadding: EdgeInsets.only(top:14),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 30.0,right: 10.0),
                        child: Icon(
                          Icons.mail_outline,
                          color: Colors.deepPurple,
                        ),
                      ),
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: Colors.black45,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                    ),

                    validator: (value){
                      bool emailValid =   RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!);
                      if(value!.isEmpty){
                        return "Entrer Email";
                      }
                      else if(!emailValid){
                        return "Entrer un Email valide ";
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 20,),
              //password textField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color:Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border:InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 30.0,right: 10.0),
                        child: Icon(
                          Icons.lock_outline,
                          color: Colors.deepPurple,
                        ),
                      ),
                      suffixIcon: GestureDetector(onTap: (){
                        setState(()
                        {
                          _obscureText=! _obscureText;
                        });

                      }, child: Icon(_obscureText? Icons.visibility: Icons.visibility_off),
                      ),
                      hintText: 'Mot de passe',
                      hintStyle: TextStyle(
                        color: Colors.black45,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                    ),

                    validator: (value){
                      if(value!.isEmpty){
                        return "Entrer Mot de passe";
                      }
                      else if(_passwordController.text.length <6){
                        return "La longueur du mot de passe doit être supérieure à 6 caractères";
                      }
                    },
                  ),
                ),
              ),

              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    GestureDetector(
                      onTap:(){
                        Navigator.push(context,MaterialPageRoute(builder: (context){
                          return ForgotPasswordPage();
                        }
                        ),
                        );
                      },
                      child: Text("Mot de passe oublié? ",
                        style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),
                      ),
                    )

                  ],
                ),
              ),
              SizedBox(height: 23,),
              //sign in button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:25.0),
                child: GestureDetector(
                  onTap: signIn,
                  /*(){
                    if(_formkey.currentState!.validate()) {
                    print("login");
                    signIn;

                    }
                },*/
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text('Se connecter',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,),
                      ),
                    ),
                  ),
                ),
              ),

              // continuer avecGOOGLE
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text("ou continuer avec",style: TextStyle(color:Colors.grey[700]),),
                    ),
                    Expanded(child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[700],
                    )
                    ),

                  ],
                ),
              ),
              SizedBox(height: 15,),
              //google sign in button
                 Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(
                    onTap: ()=> AuthService().signInWithGoogle(),
                    imagePath: "assets/images/google.png",),
                ],
              ),

              //google button
              SizedBox(height: 35,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Text("Vous n'avez pas de compte ? ",style: TextStyle(fontWeight: FontWeight.bold),),
                  GestureDetector(onTap: widget.showRegisterPage,
                      child: Text("S'inscrire ",
                        style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),
                      )
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
