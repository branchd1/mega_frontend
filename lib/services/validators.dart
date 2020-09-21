import 'dart:io';

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
    return val == null || val.length == 0 ? 'required' : null;
  }

  static String fileSizeValidator(File file, {double val: 2.5}){
    final double fileSizeInBytes = val * 1000000;
    if(fileSizeInBytes == null){
      throw 'maximum file size must be a number';
    }
    return file.lengthSync() > fileSizeInBytes ? 'file must be smaller than $fileSizeInBytes bytes (i.e. ${fileSizeInBytes/1000000} mb)' : null;
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