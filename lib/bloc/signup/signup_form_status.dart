abstract class SignupFormStatus {
  const SignupFormStatus();
}

class SignupFormInitial extends SignupFormStatus {
  const SignupFormInitial();
}

class SignupFormSubmitting extends SignupFormStatus {
  const SignupFormSubmitting();
}

class SignupFormSubmitted extends SignupFormStatus {
  const SignupFormSubmitted();
}

class SignupFormSuccess extends SignupFormStatus {
  const SignupFormSuccess();
}

class SignupFormFailure extends SignupFormStatus {
  final String message;
  const SignupFormFailure(this.message);

  String get errorMessage => message;
}

