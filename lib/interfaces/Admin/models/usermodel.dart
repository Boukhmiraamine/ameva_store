import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? uid;
  late final String? fname;
  late final String? lname;
  late final String? email;
  late final String? phone;
  late final String? pw;
  late final String? adresse;
  final String? profileImageUrl;

  User({
     this.uid,
     this.fname,
     this.lname,
     this.email,
     this.phone,
     this.pw,
     this.adresse,
     this.profileImageUrl,
  });

  factory User.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      uid: doc.id,
      fname: data['first name'],
      lname: data['last name'],
      email: data['email'],
      phone: data['phone'],
      pw: data['pw'],
      adresse: data['adresse'],
      profileImageUrl: data['profileImageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'first name': fname,
      'last name': lname,
      'email': email,
      'phone':phone,
      'pw': pw,
      'adresse': adresse,
      'profileImageUrl': profileImageUrl,
    };
  }

  User copyWith({
    String? fname,
    String? lname,
    String? email,
    String? phone,
    String? pw,
    String? adresse,
    String? profileImageUrl,
  }) {
    return User(
      uid: this.uid,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      pw: pw ?? this.pw,
      adresse: adresse ?? this.adresse,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
}
