import 'package:flutter_test/flutter_test.dart';
import 'package:mega/models/state_models/auth_token_state_model.dart';

void main(){
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Test AuthTokenStateModel stores token', () async {
    AuthTokenStateModel model = AuthTokenStateModel();

    // set the token
    model.setToken('test');

    // check that it is stored
    expect(model.token, 'test');
  });
}
