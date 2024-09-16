class Email {
  String value;
  bool isValid;
  String error;

  Email({
    required this.value,
    this.isValid = false,
    this.error = '',
  });

  Email.initial()
      : value = '',
        isValid = false,
        error = '';

  void setValue(String value) {
    this.value = value;
  }

  void validate() {
    
    if (value.isEmpty) {
      isValid = false;
      error = 'Email address required';
      return;
    }

    // Email regex pattern
    final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailPattern.hasMatch(value)) {
      isValid = false;
      error = 'Valid email address required';
      return;
    }

    isValid = true;
    error = '';
    return;
  }
}
