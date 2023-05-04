import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  late final String fname;
  late final String lname;
  late final String email;
  late final String phone;
  late final String pw;
  late final String address;
  final String profileImageUrl;

  User({
    required this.uid,
    required this.fname,
    required this.lname,
    required this.email,
    required this.phone,
    required this.pw,
    required this.address,
    required this.profileImageUrl,
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
      address: data['address'],
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
      'address': address,
      'profileImageUrl': profileImageUrl,
    };
  }

  User copyWith({
    String? fname,
    String? lname,
    String? email,
    String? phone,
    String? pw,
    String? address,
    String? profileImageUrl,
  }) {
    return User(
      uid: this.uid,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      pw: pw ?? this.pw,
      address: address ?? this.address,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
}
