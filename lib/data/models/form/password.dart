class Password {
  String value;
  bool isValid;
  String error;

  Password({
    required this.value,
    this.isValid = false,
    this.error = '',
  });

  //add validation method, do all the validation here and set isValid and error
  void validate() {
    if (value.isEmpty) {
      isValid = false;
      error = 'Password required';
      return;
    }

    //minimum 6 characters
    if (value.length < 6) {
      isValid = false;
      error = 'Minimum 6 characters required';
      return;
    }

    isValid = true;
    error = '';
    return;
  }

  Password.initial()
      : value = '',
        isValid = false,
        error = '';
}
