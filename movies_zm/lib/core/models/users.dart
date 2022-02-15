import 'package:flutter/material.dart';

class Users {
  final String id;
  final String userName;
  final String email;
  final String provider;
  final bool confirmed;
  final bool blocked;

  Users({
    @required this.id,
    @required this.userName,
    @required this.email,
    @required this.provider,
    @required this.blocked,
    @required this.confirmed,
  });

  static Users fromMap(Map<String, Object> data) {
    return Users(
      id: data['id'].toString(),
      userName: data["username"].toString(),
      email: data["email"].toString(),
      provider: data["provider"].toString(),
      confirmed: data["confirmed"] as bool,
      blocked: data["confirmed"] as bool,
    );
  }
}
