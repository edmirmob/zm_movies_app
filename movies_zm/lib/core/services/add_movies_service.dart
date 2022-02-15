import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:provider/src/provider.dart';

import '../../common/alert_dialog.dart';
import '../../common/current_context.dart';
import '../../common/http.dart';
import '../../common/snackbar.dart';
import '../../environmet_config.dart';
import '../../providers/user_identity/user_identity_state.dart';
import '../models/add_movies_data.dart';

class MoviesServices with Http {
  Future<Map<String, String>> _getHeaders() async {
    final userIdentityState = getCurrentContext().read<UserIdentityState>();

    return {
      'authorization': 'Bearer ${userIdentityState.accessToken}',
    };
  }

  Future<void> addMovie(AddMoviesData dataMovie, String filePath) async {
    try {
      final headers = await _getHeaders();

      try {
        var uri = Uri.parse("${EnvironmentConfig.apiUrl}/movies");
        var request = http.MultipartRequest("POST", uri);

        Map movieData = {
          "name": dataMovie.name,
          "publicationYear": dataMovie.publicationYear
        };
        request.headers.addAll(headers);
        request.files.add(
          http.MultipartFile.fromBytes(
            'data',
            utf8.encode(json.encode(movieData)),
            contentType: MediaType(
              'application',
              'json',
              {'charset': 'utf-8'},
            ),
          ),
        );
        request.files.add(await http.MultipartFile.fromPath(
          'files.poster',
          filePath,
          contentType: MediaType(
            'multipart/',
            'form-data',
            {'charset': 'utf-8'},
          ),
        ));
        final response = await request.send();
        if (response.statusCode == 200) {
          if (kDebugMode) {
            print(await response.stream.bytesToString());
            showSnackbar('Movie added.');
          }
        } else {
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      } catch (error) {
        if (kDebugMode) {
          print('Error add project $error');
        }
        rethrow;
      }
    } on HttpException {
      showAlertDialog('Can\'t add movie',
          'There was an error while add movie. Please try again later.');
    }
  }

  Future<void> updateMovie(AddMoviesData dataMovie, String filePath) async {
    try {
      final headers = await _getHeaders();

      try {
        var uri =
            Uri.parse("${EnvironmentConfig.apiUrl}/movies/${dataMovie.id}");
        var request = http.MultipartRequest("PUT", uri);

        Map movieData = {
          "name": dataMovie.name,
          "publicationYear": dataMovie.publicationYear
        };
        request.headers.addAll(headers);
        request.files.add(
          http.MultipartFile.fromBytes(
            'data',
            utf8.encode(json.encode(movieData)),
            contentType: MediaType(
              'application',
              'json',
              {'charset': 'utf-8'},
            ),
          ),
        );
        if (filePath != '') {
          request.files.add(await http.MultipartFile.fromPath(
            'files.poster',
            filePath,
            contentType: MediaType(
              'multipart/',
              'form-data',
              {'charset': 'utf-8'},
            ),
          ));
        }

        final response = await request.send();

        if (response.statusCode == 200) {
          if (kDebugMode) {
            print(await response.stream.bytesToString());
            showSnackbar('Movie updated.');
          }
        } else {
          if (kDebugMode) {
            print(response.reasonPhrase);
          }
        }
      } catch (error) {
        if (kDebugMode) {
          print('Error add project $error');
        }
        rethrow;
      }
    } on HttpException {
      showAlertDialog('Can\'t update movie',
          'There was an error while update movie. Please try again later.');
    }
  }
}
