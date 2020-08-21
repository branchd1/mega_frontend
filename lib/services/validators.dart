
class Validators{
  static final RegExp emailRegex = RegExp(
    r"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$",
    caseSensitive: false,
    multiLine: false,
  );

  static final RegExp numberRegex = RegExp(
    r"^[0-9]+$",
    caseSensitive: false,
    multiLine: false,
  );

  static String requiredValidator(String val){
    return val.length == 0 ? 'required' : null;
  }

  static String minLengthValidator(String val, int len){
    return val.length < len ? 'must be more than ' + len.toString() + ' characters' : null;
  }

  static String maxLengthValidator(String val, int len){
    return val.length > len ? 'must be less than ' + len.toString() + ' characters' : null;
  }

  static String exactLengthValidator(String val, int len){
    return val.length != len ? 'must be exactly ' + len.toString() + ' characters' : null;
  }

  static String emailValidator(String value) {
    return Validators.emailRegex.hasMatch(value) ? null : 'Enter a valid email';
  }

  static String numberValidator(String value){
    return Validators.numberRegex.hasMatch(value) ? null : 'Enter a number';
  }

  static String passwordValidator(String value) {
    return Validators.emailRegex.hasMatch(value) ? null : 'Enter a valid password';
  }
}