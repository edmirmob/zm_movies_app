import 'package:flutter/material.dart';
import 'package:movies_zm/ui/movies_theme.dart';

import 'current_context.dart';

void showSnackbar(String text) {
  ScaffoldMessenger.of(
    getCurrentContext(),
  ).showSnackBar(SnackBar(
    backgroundColor: MoviesTheme.cardColor,
    duration: const Duration(seconds: 6),
    content: Text(
      (text),
      style: Theme.of(getCurrentContext()).textTheme.subtitle1,
    ),
  ));
}
