class AppValidators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return 'Name should be alphanumeric only';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$').hasMatch(value)) {
      return 'Password must contain both letters and numbers';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegExp = RegExp(r'^[0-9]{10}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  static String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter item\'s title';
    }
    return null;
  }

  static String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Price is required';
    }
    final double? price = double.tryParse(value);
    if (price == null) {
      return 'Invalid price format';
    }
    if (price < 0) {
      return 'Price must be positive';
    }
    return null;
  }

  static String? validateUpiId(String? value) {
    if (value == null || value.isEmpty) {
      return 'UPI ID is required';
    }
    if (!value.contains('@')) {
      return 'Enter a valid UPI ID';
    }
    List<String> parts = value.split('@');
    if (parts.length != 2) {
      return 'Enter a valid UPI ID';
    }
    return null;
  }

  static bool validateAtLeastOneImage(List<dynamic> images) {
    return images.isEmpty;
  }
}