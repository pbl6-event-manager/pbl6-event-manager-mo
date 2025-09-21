part of "auth_bloc.dart";

class AuthState extends Equatable {
  final AuthStatus status;

  const AuthState._({required this.status});

  const AuthState.unauthenticated()
    : this._(status: AuthStatus.unauthenticated);

  const AuthState.authenticated() : this._(status: AuthStatus.authenticated);

  @override
  List<Object?> get props => [status];
}
