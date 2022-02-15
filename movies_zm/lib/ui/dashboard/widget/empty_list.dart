import 'package:flutter/material.dart';

import '../../add_movie_screen/add_movie_screen.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({
    Key key,
    this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Your movie list is empty",
          style: textTheme.headline3,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          autofocus: true,
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(AddMovieScreen.route);
          },
          child: Text(
            'Add a new movie',
            style: textTheme.headline6,
          ),
        ),
      ],
    );
  }
}
