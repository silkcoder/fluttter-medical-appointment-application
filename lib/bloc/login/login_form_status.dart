abstract class LoginFormStatus {
  const LoginFormStatus();
}

class InitialLoginFormStatus extends LoginFormStatus {
  const InitialLoginFormStatus();
}

class LoginFormSubmitting extends LoginFormStatus {
  const LoginFormSubmitting();
}

//submitted
class LoginFormSubmitted extends LoginFormStatus {
  const LoginFormSubmitted();
}


class LoginFormSuccess extends LoginFormStatus {
  const LoginFormSuccess();
}

class LoginFormFailure extends LoginFormStatus {
  final String error;

  const LoginFormFailure(this.error);
}