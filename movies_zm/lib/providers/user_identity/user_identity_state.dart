import 'package:flutter/foundation.dart';

class UserIdentityState {
  final String id;
  final String userName;
  final String email;
  final String provider;
  final bool confirmed;
  final bool blocked;
  final String accessToken;
  final bool authenticated;
  final bool authenticationInProgress;

  UserIdentityState({
    @required this.id,
    @required this.userName,
    @required this.email,
    @required this.provider,
    @required this.blocked,
    @required this.confirmed,
    @required this.accessToken,
    @required this.authenticated,
    @required this.authenticationInProgress,
  });

  UserIdentityState copyWith({
    String id,
    String userName,
    String email,
    String provider,
    bool confirmed,
    bool blocked,
    String accessToken,
    bool authenticated,
    bool authenticationInProgress,
  }) {
    return UserIdentityState(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      provider: provider ?? this.provider,
      accessToken: accessToken ?? this.accessToken,
      confirmed: confirmed ?? this.confirmed,
      blocked: blocked ?? this.blocked,
      authenticated: authenticated ?? this.authenticated,
      authenticationInProgress:
          authenticationInProgress ?? this.authenticationInProgress,
    );
  }
}

class UserIdentityInitialState extends UserIdentityState {
  UserIdentityInitialState()
      : super(
          id: null,
          userName: null,
          email: null,
          provider: null,
          accessToken: null,
          confirmed: false,
          authenticated: false,
          blocked: false,
          authenticationInProgress: false,
        );
}
