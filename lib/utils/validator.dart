class Validator {
  static String? validateName({required String? name}) {
    if (name!.isEmpty) {
      return 'This field is required';
    }
    if (name.length < 3) {
      return 'Name must be at least 3 characters';
    }
    if (name.length > 50) {
      return 'Name must be not greater than 50 characters';
    }
    return null;
  }

  static String? validateEmail({required String? email}) {
    if (email!.isEmpty) {
      return 'Please enter your email address';
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePassword({required String? pass}) {
    if (pass!.isEmpty) {
      return 'This field is required';
    }
    if (pass.length < 8) {
      return 'Password must be at least 8 characters in length';
    }
    if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).*').hasMatch(pass)) {
      return 'Password must contain at least 1 Capital and number';
    }
    return null;
  }
}
