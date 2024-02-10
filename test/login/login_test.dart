import 'package:chat_connect_app/features/login/service/login_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final ILoginService loginService;
  setUp(() {
    loginService = LoginService();
  });

  test('trying sign in', () {
    final response = loginService.signIn('emre@test.com', '123456');

    expect(response, true);
  });
}
