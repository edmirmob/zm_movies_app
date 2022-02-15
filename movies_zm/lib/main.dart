
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'common/current_context.dart';
import 'dependency_injection.dart';
import 'providers/user_identity/user_identity_state.dart';
import 'routes.dart';
import 'ui/login/login_screen.dart';
import 'ui/movies_screen/movies_screen.dart';
import 'ui/movies_theme.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ...repositoryProviders,
        ...serviceProviders,
        ...stateNotifierProviders,
      ],
     
        child: const MyApp(),
      
      
    ),
  );
}

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _VscAppState createState() => _VscAppState();
}

class _VscAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown
]);
    return MaterialApp(
      title: 'Movie ZM',
      navigatorKey: navigatorStateGlobalKey,
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('hr', 'hr_Hr'),
      ],
      theme: MoviesTheme().build(context),
      home: Selector<UserIdentityState, bool>(
        selector: (_, state) => state.authenticated,
        builder: (_, authenticated, __) {
          if (authenticated) {
            return const MoviesScreen();
          }
          return  LoginScreen();
        },
      ),
      routes: routes,
    );
  }
}
