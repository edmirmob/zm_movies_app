import 'package:flutter/material.dart';

import 'package:movies_zm/ui/dashboard/movies_screen.dart';

import 'ui/add_movie_screen/add_movie_screen.dart';

Map<String, WidgetBuilder> routes = {
  MoviesScreen.route: (_) =>const MoviesScreen(),
  AddMovieScreen.route: (_) => AddMovieScreen(),

};
