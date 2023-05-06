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

  static Future<List<User>> getUsers() async {
    final snapshot = await _firestore.collection('users').get();
    final users =
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

  Future<String> uploadImage(File imageFile, String? uid) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = FirebaseStorage.instance.ref().child('users/$fileName');
      UploadTask uploadTask = reference.putFile(imageFile);
      TaskSnapshot storageTaskSnapshot = await uploadTask;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e.toString());
      return 'An error occurred. Please try again later.';
    }
  }

  Future<void> updateUser(User user) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      await users.doc(user.uid).update({
        'fname': user.fname,
        'lname': user.lname,
        'email': user.email,
        'phone': user.phone,
        'adresse': user.adresse,
        'pw': user.pw,
        'imageUrl': user.profileImageUrl,
      });
    } catch (e) {
      print(e.toString());
    }
  }


}