import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../environmet_config.dart';
import '../models/users_data.dart';

class AuthenticationService {
  Future<Token> authenticate(String email, String password) {
    return http.post(
      Uri.parse('${EnvironmentConfig.apiUrl}/auth/local'),
      body: {'identifier': email, 'password': password},
    ).then((result) {
      final authResult = jsonDecode(result.body);
      var users = authResult["user"] as dynamic;

      UsersData items;

      items = UsersData.fromMap(users);
      return Token(authResult['jwt'], items);
    });
  }
}

class Token {
  final String accessToken;
  final UsersData users;

  Token(
    this.accessToken,
    this.users,
  );
}

class AuthenticationException implements Exception {
  final String error;
  AuthenticationException(this.error);
}
