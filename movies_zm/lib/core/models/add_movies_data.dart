import 'package:flutter/material.dart';

class AddMoviesData {
  final String id;
  final String name;
  final String publicationYear;

  AddMoviesData({
    this.id,
    @required this.name,
    @required this.publicationYear,
  });

  static AddMoviesData fromMap(Map<String, Object> data) {
    return AddMoviesData(
      id: data['id'].toString(),
      name: data['name'].toString(),
      publicationYear: data["publicationYear"].toString(),
    );
  }

 
}
