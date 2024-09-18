class ConfirmPassword {
  String value;
  bool isValid;
  String error;

  ConfirmPassword({
    required this.value,
    this.isValid = false,
    this.error = '',
  });

  //add validation method, do all the validation here and set isValid and error
  void validate(String password) {
    if (value.isEmpty) {
      isValid = false;
      error = 'Password confirmation required';
      return;
    }

    if (value != password) {
      isValid = false;
      error = 'Password does not match';
      return;
    }

    isValid = true;
    error = '';
    return;
  }

  ConfirmPassword.initial()
      : value = '',
        isValid = false,
        error = '';
}
