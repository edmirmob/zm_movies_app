import 'package:flutter/material.dart';

import '../../add_movie_screen/add_movie_screen.dart';
import '../../movies_theme.dart';

class NoData extends StatelessWidget {
  const NoData({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: MediaQuery.of(context).size.height - 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Your movie list is empty",
              style: textTheme.headline3,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: MoviesTheme.headlineHeight6),
          ElevatedButton(
            autofocus: true,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(AddMovieScreen.route);
            },
            child: SizedBox(
              height: 24,
              child: Text(
                'Add a new movie',
                style: textTheme.headline6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
