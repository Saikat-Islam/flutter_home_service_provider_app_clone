import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  final String name;
  final String email;
  final String phoneNumber;

  UserModel(
      {required this.email,
      required this.name,
      required this.phoneNumber});

  toJson() {
    return {
      "name" : name,
      "email" : email,
      "phoneNumber" : phoneNumber,
    };

    
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>>document){
    final data = document.data();
    return UserModel(email: data!["email"], name: data["name"], phoneNumber: data["phone"]);
  }
}
