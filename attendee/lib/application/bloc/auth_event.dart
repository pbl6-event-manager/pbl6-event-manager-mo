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
  final String token;

  const AuthTokenAdded(this.token);

  @override
  List<Object?> get props => [token];
}

class AuthTokenRemoved extends AuthEvent {
  const AuthTokenRemoved();
}
