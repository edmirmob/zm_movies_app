import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/movies_data.dart';
import '../../providers/movies/movies_provider.dart';
import '../../providers/movies/movies_state.dart';
import '../../providers/user_identity/user_identity_provider.dart';
import '../../shared/bottom_animation.dart';
import '../add_movie_screen/add_movie_screen.dart';
import 'widget/movie_card.dart';
import 'widget/no_data.dart';

class MoviesScreen extends StatefulWidget {
  static const route = '/moviesScreen';
  const MoviesScreen({Key key}) : super(key: key);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesScreen> {
  @override
  void initState() {
    super.initState();
    final moviesProvider = context.read<MoviesProvider>();

    if (!moviesProvider.isMoviesLoaded()) {
      Future.delayed(Duration.zero).then((_) {
        moviesProvider.loadMovies();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final moviesProvider = context.read<MoviesProvider>();
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        body: NotificationListener<ScrollNotification>(
          onNotification: (sn) {
            if (sn.metrics.pixels + 300 >= sn.metrics.maxScrollExtent) {
              moviesProvider.loadMoreMovies();
            }
            return true;
          },
          child: RefreshIndicator(
            onRefresh: moviesProvider.refreshMovies,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "My movies",
                                  style: textTheme.headline4,
                                ),
                                IconButton(
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed(AddMovieScreen.route),
                                  icon: const Icon(Icons.add_circle_outline,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<UserIdentityProvider>()
                                        .clearIdentity();
                                  },
                                  icon: const Icon(Icons.logout,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(AddMovieScreen.route);
                        },
                      ),
                    ),
                  ),
                  Selector<MoviesState, bool>(
                    selector: (_, state) => state.loadingFirstPage,
                    builder: (_, loadingFirstPage, __) {
                      if (loadingFirstPage) {
                        return SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (ctx, index) {
                              return const MovieCard(
                                id: 'id',
                                name: 'Name',
                                url: 'Url',
                                publicationYear: 'Publication Year',
                                loading: true,
                              );
                            },
                            childCount: 40,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 300,
                                  childAspectRatio: 0.8,
                                  crossAxisSpacing: 3,
                                  mainAxisSpacing: 5),
                        );
                      }

                      return const SliverToBoxAdapter();
                    },
                  ),
                  Selector<MoviesState, List<MoviesData>>(
                      selector: (_, state) => state.movies,
                      builder: (_, movieList, __) {
                        if (movieList.isEmpty) {
                          return const SliverToBoxAdapter(child: NoData());
                        }

                        return SliverPadding(
                          padding: const EdgeInsets.only(bottom: 20),
                          sliver: SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (ctx, index) {
                                final movie = movieList[index];
                                return MovieCard(
                                  id: movie.id,
                                  name: movie.title,
                                  url: movie.url,
                                  publicationYear: movie.publicationYear,
                                );
                              },
                              childCount: movieList.length,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 300,
                                    childAspectRatio: 0.8,
                                    crossAxisSpacing: 3,
                                    mainAxisSpacing: 5),
                          ),
                        );
                      }),
                  Selector<MoviesState, bool>(
                    selector: (_, state) => state.loadingMoreData,
                    builder: (_, loadingMoreData, __) {
                      if (loadingMoreData) {
                        return SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (ctx, index) {
                              return const Padding(
                                padding: EdgeInsets.only(
                                  bottom: 20,
                                ),
                                child: MovieCard(
                                  id: 'id',
                                  name: 'Name',
                                  url: 'Url',
                                  publicationYear: 'Publication Year',
                                  loading: true,
                                ),
                              );
                            },
                            childCount: 1,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 300,
                                  childAspectRatio: 0.8,
                                  crossAxisSpacing: 3,
                                  mainAxisSpacing: 5),
                        );
                      }

                      return const SliverToBoxAdapter();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const BottomAnimation(),
      ),
    );
  }
}
