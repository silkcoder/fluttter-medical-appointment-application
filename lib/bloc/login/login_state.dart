// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

class LoginState {
  Email email;
  Password password;
  LoginFormStatus formStatus;

  LoginState({
    required this.email,
    required this.password,
    this.formStatus = const InitialLoginFormStatus(),
  });

  LoginState copyWith({
    Email? email,
    Password? password,
    LoginFormStatus? formStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
