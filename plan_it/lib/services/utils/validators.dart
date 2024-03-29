class ValidatorClass {
  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Please enter your email";
    } else if (!RegExp('^[a-zA-Z0-9_.-]+@[a-zA-Z0-9.-]+.[a-z]')
        .hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? validateUserName(String? value) {
    if (value!.isEmpty) {
      return "Please enter your user name";
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%]').hasMatch(value)) {
      return "Please enter a valid user name";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Please enter your password";
    } else if (value.length < 6) {
      return "Password length atleast 6 characters";
    }
    return null;
  }

  String? validatorTaskName(String? value) {
    if (value!.isEmpty) {
      return "Please enter the task name rightly";
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%]').hasMatch(value)) {
      return "Please enter a valid user name";
    }
    return null;
  }

  String? noValidationRequired(String? value) {
    return null;
  }
}
