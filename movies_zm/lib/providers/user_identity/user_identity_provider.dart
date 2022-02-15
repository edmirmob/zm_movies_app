import 'dart:async';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_notifier/state_notifier.dart';

import '../../common/alert_dialog.dart';
import '../../core/services/authentication_service.dart';
import 'user_identity_state.dart';

class UserIdentityProvider extends StateNotifier<UserIdentityState>
    with LocatorMixin {
  final _accessTokenSharedPreferencesKey = 'identity_access_token';

  UserIdentityProvider() : super(UserIdentityInitialState());

  Future<void> authenticate(
      String username, String password, bool isRembember) async {
    try {
      state = state.copyWith(authenticationInProgress: true);
      final token =
          await read<AuthenticationService>().authenticate(username, password);
      state = _decodeToken(token).copyWith(
        authenticationInProgress: false,
        authenticated: true,
      );
      if (isRembember) {
        await _saveIdentityToSharedPreferences(token.accessToken);
      }
    } on AuthenticationException {
      clearIdentity();
      showAlertDialog(
        ('Login Failed'),
        ('Invalid username or password.'),
      );
    } catch (_) {
      clearIdentity();
      showAlertDialog(
        ('Login Failed'),
        ('There was an error while authenticating. Please try again later.'),
      );
    }
  }

  Future<void> clearIdentity() async {
    state = UserIdentityInitialState();
    await _removeIdentityFromSharedPreferences();
  }

  bool isAuthenticated() {
    return state.accessToken != null;
  }


  UserIdentityState _decodeToken(
    Token accessToken,
  ) {
    return state.copyWith(
      id: accessToken.users.id,
      userName: accessToken.users.userName,
      email: accessToken.users.email,
      provider: accessToken.users.provider,
      confirmed: accessToken.users.confirmed,
      blocked: accessToken.users.blocked,
      accessToken: accessToken.accessToken,
    );
  }

  Future<void> _saveIdentityToSharedPreferences(
    String accessToken,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenSharedPreferencesKey, accessToken);
  }

  Future<void> _removeIdentityFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenSharedPreferencesKey);
  }
}
