

mixin Validator {
  final String _emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
 

  String validateEmail(String email) {
    if (email == null || email.isEmpty) {
      return "Please enter E-mail address";
    } else if (!RegExp(_emailPattern).hasMatch(email)) {
      return "Enter valid email address";
    }
    return null;
  }

  String validatePassword(String password) {
    if (password?.isEmpty == true) {
      return "Please enter password";
    } else if (password != null && password.length < 6) {
      return "Password should be at least 6 characters";
    } else if (password != null && password.length > 20) {
      return "Password should not be greater than 20 characters";
    }
    return null;
  }

}
