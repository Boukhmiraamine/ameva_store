import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _emailController = TextEditingController();

@override
  void dispose() {
  _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async{
    try{
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text('Lien de réinitialisation du mot de passe envoyé Vérifiez votre e-mail'),
        );
      },
      );

    } on FirebaseAuthException catch(e){
      print(e);
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,

        children: [
          //SizedBox(height: 35,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text('Entrez votre email et nous vous enverrons un lien de réinitialisation de mot de passe',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),),
          ),

          SizedBox(height: 15,),
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
              ),
            ),
          ),
          SizedBox(height: 10,),
          MaterialButton(onPressed: passwordReset,
            child: Text('Réinitialiser le mot de passe', style: TextStyle(fontSize: 18),),
            color: Colors.deepPurple[200],
          ),
        ],
      ),
    );
  }
}
