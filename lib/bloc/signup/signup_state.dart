part of 'signup_bloc.dart';

class SignupState {

  Name name;
  Email email;
  Password password;
  ConfirmPassword confirmPassword;
  SignupFormStatus formStatus;

  SignupState({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.formStatus = const SignupFormInitial(),
  });

  SignupState copyWith({
    Name? name,
    Email? email,
    Password? password, 
    ConfirmPassword? confirmPassword,
    SignupFormStatus? formStatus,
  }) {
    return SignupState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      formStatus: formStatus ?? this.formStatus,
    );
  }
  
}

