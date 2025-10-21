part of "auth_bloc.dart";

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStatusRequested extends AuthEvent {
  const AuthStatusRequested();
}

class AuthTokenAdded extends AuthEvent {
  final String accessToken;
  final String refreshToken;

  const AuthTokenAdded({required this.accessToken, required this.refreshToken});

  @override
  List<Object?> get props => [accessToken, refreshToken];
}

class AuthTokenRemoved extends AuthEvent {
  const AuthTokenRemoved();
}
