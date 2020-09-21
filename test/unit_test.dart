import 'package:flutter_test/flutter_test.dart';
import 'package:mega/models/state_models/auth_token_state_model.dart';
import 'package:mega/services/validators.dart';

void main(){
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Validators', (){
    test('requiredValidator', (){
      expect(Validators.requiredValidator(''), 'required');
      expect(Validators.requiredValidator('test'), null);
      expect(Validators.requiredValidator('test2'), null);
    });

    test('minLengthValidator', (){
      expect(Validators.minLengthValidator('', 2), isNotNull);
      expect(Validators.minLengthValidator('t', 2), isNotNull);
      expect(Validators.minLengthValidator('te', 2), null);
      expect(Validators.minLengthValidator('tes', 2), null);
      expect(Validators.minLengthValidator('test', 2), null);
    });

    test('maxLengthValidator', (){
      expect(Validators.maxLengthValidator('', 2), null);
      expect(Validators.maxLengthValidator('t', 2), null);
      expect(Validators.maxLengthValidator('te', 2), null);
      expect(Validators.maxLengthValidator('tes', 2), isNotNull);
      expect(Validators.maxLengthValidator('test', 2), isNotNull);
    });

    test('exactLengthValidator', (){
      expect(Validators.exactLengthValidator('', 0), null);
      expect(Validators.exactLengthValidator('t', 1), null);
      expect(Validators.exactLengthValidator('te', 2), null);
      expect(Validators.exactLengthValidator('tes', 2), isNotNull);
      expect(Validators.exactLengthValidator('test', 9), isNotNull);
    });

    test('emailValidator', (){
      expect(Validators.emailValidator('test@test.com'), null);
      expect(Validators.emailValidator('t'), isNotNull);
      expect(Validators.emailValidator('te@te.test'), null);
      expect(Validators.emailValidator('tes@te'), isNotNull);
      expect(Validators.emailValidator('test@test.'), isNotNull);
    });

    test('numberValidator', (){
      expect(Validators.numberValidator('7828782730'), null);
      expect(Validators.numberValidator('td13rd3'), isNotNull);
      expect(Validators.numberValidator('00000000'), null);
      expect(Validators.numberValidator('33£&£&637&@&'), isNotNull);
      expect(Validators.numberValidator('0002323'), null);
    });
  });
}
