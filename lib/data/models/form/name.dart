class Name {
  String value;
  bool isValid;
  String error;

  Name({
    required this.value,
    this.isValid = false,
    this.error = '',
  });

  Name.initial()
      : value = '',
        isValid = false,
        error = '';

  void setValue(String value) {
    this.value = value;
  }

  void validate() {
    
    if (value.isEmpty) {
      isValid = false;
      error = 'Name required';
      return;
    }

    isValid = true;
    error = '';
    return;
  }
}
