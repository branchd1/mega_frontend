import 'dart:io';

/// Contains validator methods
class Validators {
  /// Email format regex
  static final RegExp emailRegex = RegExp(
    r"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$",
    caseSensitive: false,
    multiLine: false,
  );

  /// Number only regex
  static final RegExp numberRegex = RegExp(
    r"^[0-9]+$",
    caseSensitive: false,
    multiLine: false,
  );

  /// Required validator
  ///
  /// val must no be empty
  static String requiredValidator(String val){
    return val == null || val.length == 0 ? 'required' : null;
  }

  /// Validate file size
  ///
  /// file size must be less than the specified value
  static String fileSizeValidator(File file, {double val: 2.5}){
    // convert file size to bytes
    final double fileSizeInBytes = val * 1000000;

    if(fileSizeInBytes == null){
      throw 'maximum file size must be a number';
    }
    return file.lengthSync() > fileSizeInBytes ?
    'file must be smaller than $fileSizeInBytes bytes (i.e. ${fileSizeInBytes/1000000} mb)' : null;
  }

  /// Validate string length is less than the specified length
  static String minLengthValidator(String val, int len){
    return val.length < len ? 'must be more than ' + (len-1).toString() + ' characters' : null;
  }

  /// Validate string length is more than the specified length
  static String maxLengthValidator(String val, int len){
    return val.length > len ? 'must be less than ' + (len+1).toString() + ' characters' : null;
  }

  /// Validate string is exact length as specified
  static String exactLengthValidator(String val, int len){
    return val.length != len ? 'must be exactly ' + len.toString() + ' characters' : null;
  }

  /// Validate string is correct email format
  static String emailValidator(String value) {
    return Validators.emailRegex.hasMatch(value) ? null : 'Enter a valid email';
  }

  /// Validate string is has only numeric characters
  static String numberValidator(String value){
    return Validators.numberRegex.hasMatch(value) ? null : 'Enter a number';
  }
}