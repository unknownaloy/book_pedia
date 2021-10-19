class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static _isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static String? validateEmail(String? email) {
    if (email == null || email == "") {
      return "Email is required";
    }

    if (!Validators._isValidEmail(email)) {
      return "Please enter a valid email";
    }

    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password == "") {
      return "Password is required";
    }

    if (password.length < 6) {
      return "Password must be up to 6 character";
    }

    return null;
  }
}