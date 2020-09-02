import 'package:flutter/material.dart';

typedef void SetErrorTextCallback(String text);

typedef String ValidatorCallback(String text);

typedef void DropDownChangedCallback(String val);

typedef void CreatableCallback({VoidCallback doAfter});

typedef void TapCardCallback(BuildContext context, dynamic item);

typedef Future<void> FutureVoidCallback();