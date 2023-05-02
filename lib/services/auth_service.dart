
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{

  //Google Sign in
  signInWithGoogle() async{

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: ' 454027838879-s43dpqsdksslsqc0p5pcia71kv1si0gb.apps.googleusercontent.com',


      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
      hostedDomain: "",
      //clientIdIos: "454027838879-5lp87471b1fs4d95p684oho4uf248a26.apps.googleusercontent.com",
      //clientIdAndroid: "454027838879-7gkfpc969mc4aa155ahfvkptbkr8i1qf.apps.googleusercontent.com",
    );

    //begin interactive sign in process
    final GoogleSignInAccount? gUser = await googleSignIn.signIn();

    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create a new credential for user
    final credential= GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // sign in to Firebase with the credential
    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    // get the user object
    final User? user = userCredential.user;
print(user);

  }
}
