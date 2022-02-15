import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:movies_zm/core/services/add_movies_service.dart';
import 'package:movies_zm/providers/movies/movies.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import 'core/repositories/movies_repository.dart';
import 'core/services/authentication_service.dart';
import 'providers/user_identity/user_identity_provider.dart';
import 'providers/user_identity/user_identity_state.dart';

List<SingleChildWidget> repositoryProviders = [
  Provider<MoviesRepository>(
    create: (_) => MoviesRepository(),
  ),
];

List<SingleChildWidget> serviceProviders = [
  Provider<AuthenticationService>(
    create: (_) => AuthenticationService(),
  ),
    Provider<MoviesServices>(
    create: (_) => MoviesServices(),
  ),
];

List<SingleChildWidget> stateNotifierProviders = [
  StateNotifierProvider<UserIdentityProvider, UserIdentityState>(
    create: (_) => UserIdentityProvider(),
  ),
    StateNotifierProvider<MoviesProvider, MoviesState>(
    create: (_) => MoviesProvider(),
  ),
];
