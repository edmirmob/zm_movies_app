import 'dart:convert';
import 'package:movies_zm/providers/user_identity/user_identity_state.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as baseHttp;

import './current_context.dart';

mixin Http {
  Future<T> get<T>(String url) async {
    final headers = await _getHeaders();
    return baseHttp
        .get(
      Uri.parse(url),
      headers: headers,
    )
        .then((response) {
      if (response.statusCode == 204) {
        return null;
      }
      if (response.statusCode != 200) {
        throw HttpException('${response.statusCode}');
      }
      return jsonDecode(response.body) as T;
    });
  }

  Future<void> update(String url, Map<String, dynamic> body) async {
    final headers = await _getHeaders();
    headers.putIfAbsent('Content-Type', () => 'application/json');
    return baseHttp
        .patch(
      Uri.parse(url),
      body: json.encode(body),
      headers: headers,
    )
        .then((response) {
      if (response.statusCode != 200) {
        throw HttpException('${response.statusCode}');
      }
    });
  }

  Future<void> add(String url, Map<String, dynamic> body) async {
    final headers = await _getHeaders();
    headers.putIfAbsent('Content-Type', () => 'application/json');
    return baseHttp
        .post(
      Uri.parse(url),
      body: json.encode(body),
      headers: headers,
    )
        .then((response) {
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw HttpException('${response.statusCode}');
      }
    });
  }

  Future<void> put(String url, Map<String, dynamic> body) async {
    final headers = await _getHeaders();
    headers.putIfAbsent('Content-Type', () => 'application/json');
    return baseHttp
        .put(
      Uri.parse(url),
      body: json.encode(body),
      headers: headers,
    )
        .then((response) {
      if (response.statusCode != 200) {
        throw HttpException('${response.statusCode}');
      }
    });
  }

  Future<void> delete(String url) async {
    final headers = await _getHeaders();
    return baseHttp
        .delete(
      Uri.parse(url),
      headers: headers,
    )
        .then((response) {
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw HttpException('${response.statusCode}');
      }
    });
  }

  Future<Map<String, String>> _getHeaders() async {
    final userIdentityState = getCurrentContext().read<UserIdentityState>();

    return {
      'authorization': 'Bearer ${userIdentityState.accessToken}',
    };
  }
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);
  @override
  String toString() {
    return message;
  }
}
