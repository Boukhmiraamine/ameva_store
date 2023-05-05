import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as fbUser;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/usermodel.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class Firebase {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  final fbUser.FirebaseAuth _firebaseAuth = fbUser.FirebaseAuth.instance;
  final CollectionReference _userCollection =
  FirebaseFirestore.instance.collection('users');

  /*Future<List<User>> getUsers() async {
    List<User> users = [];

    try {
      // Récupération des utilisateurs Firebase Auth
      List<UserRecord> userRecords = await _firebaseAuth.userManager.users();
      for (UserRecord userRecord in userRecords) {
        User user = User(
          uid: userRecord.uid,
          email: userRecord.email,
          fname: userRecord.displayName?.split(" ")[0],
          lname: userRecord.displayName?.split(" ")[1],
        );
        users.add(user);
      }

      // Récupération des utilisateurs Firestore
      QuerySnapshot querySnapshot = await _userCollection.get();
      final snapshot = await _firestore.collection('users').get();
      final user =
          snapshot.docs.map((doc) => User.fromSnapshot(doc)).toList();
      users.add(user as User);

    } catch (e) {
      print('Error getting all users: $e');
    }

    return users;

}*/

  static Future<List<User>> getUsers() async {
    List<User> users = [];

    final snapshot = await _firestore.collection('users').get();
     users =
    snapshot.docs.map((doc) => User.fromSnapshot(doc)).toList();
    return users;
  }

  static Future<void> addUser(User user, {File? profileImage}) async {
    final ref = _storage.ref().child('users/${user.uid}.jpg');
    if (profileImage != null) {
      await ref.putFile(profileImage);
      final url = await ref.getDownloadURL();
      user = user.copyWith(profileImageUrl: url);
    }try {
      await _firestore.collection('users').add(user.toMap());
    } catch (e) {
      print(e);
    }
  }

  static Future<void> editUser(User user, {File? profileImage}) async {
    final userRef = _firestore.collection('users').doc(user.uid);
    if (profileImage != null) {
      final ref = _storage.ref().child('users/${user.uid}.jpg');
      await ref.putFile(profileImage);
      final url = await ref.getDownloadURL();
      user = user.copyWith(profileImageUrl: url);
    }
    try{
      await _firestore.collection('users').doc(user.uid).update(user.toMap());}
    catch (e) {
      print(e);
    }
  }

  /*static Future<void> updatePassword(String password) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _auth.currentUser?.updatePassword(newPassword);
    } else {
      throw Exception('Aucun utilisateur connecté');
    }
  }*/

  static Future<void> deleteUser(String? uid) async {
    await _firestore.collection('users').doc(uid).delete();
    final ref = _storage.ref().child('users/$uid.jpg');
    await ref.delete();
    try {
      final fbUser.User? user = await fbUser.FirebaseAuth.instance.currentUser;
      if (user != null && user.uid == uid) {
        await user.delete();
      }
    } catch (e) {
      print(e);
    }
  }
}