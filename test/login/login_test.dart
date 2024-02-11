import 'package:chat_connect_app/features/login/service/login_service.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final ILoginService loginService;

  setUp(() async {
    loginService = LoginService();
  });

  test('trying sign in', () async {
    final response = await loginService.signIn('emre@test.com', '123456');

    expect(response, true);
  });
}
