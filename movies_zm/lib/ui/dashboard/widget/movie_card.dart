import 'package:flutter/material.dart';

import '../../../core/models/movies_data.dart';
import '../../../shared/content/content.dart';
import '../../add_movie_screen/add_movie_screen.dart';
import '../../movies_theme.dart';

class MovieCard extends StatelessWidget {
  final String id;
  final String name;
  final String url;
  final String publicationYear;
  final bool loading;

  const MovieCard({
    Key key,
    @required this.id,
    @required this.name,
    @required this.url,
    @required this.publicationYear,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final image = loading != true ? url : null;
    return Content(
      loading: loading,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            AddMovieScreen.route,
            arguments: MoviesData(
              id: id,
              title: name,
              publicationYear: publicationYear,
              url: url,
            ),
          );
        },
        child: Card(
          color: MoviesTheme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  child: image != null
                      ? Image.network(
                          image,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                        )
                      : Image.asset(
                          'assets/images/no_data.png',
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: 170,
                        ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Content(
                          loading: loading,
                          child: Text(
                            name,
                            maxLines: 2,
                            style: textTheme.bodyText2,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Content(
                          loading: loading,
                          child: Text(
                            publicationYear,
                            maxLines: 2,
                            style: textTheme.subtitle2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
