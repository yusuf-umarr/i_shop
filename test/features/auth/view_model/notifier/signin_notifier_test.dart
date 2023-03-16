import 'package:flutter_test/flutter_test.dart';
import 'package:i_shop_riverpod/core/config/response/api_response.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/auth/model/user_model.dart';
import 'package:i_shop_riverpod/features/auth/service/auth_repository.dart';
import 'package:i_shop_riverpod/features/auth/view_model/notifier/signin_notifier.dart';
import 'package:mocktail/mocktail.dart';

class MockService extends Mock implements AuthRepositoryImpl {}

void main() {
  late MockService mockService;
  late SignInNofiier signInNofiier;

  setUp(() {
    mockService = MockService();
    signInNofiier = SignInNofiier(mockService);
  });
  group('SignInNotifier-', () {
    final res = ApiResponse<UserModel>(
      success: true,
      data: UserModel(),
      message: "successfully!!!",
    );

    test("check if the initial values are correct", () {
      expect(signInNofiier.state.isVisible, false);
      expect(signInNofiier.state.loadState, NetworkState.idle);
      expect(signInNofiier.state.user, isA<UserModel>());
      expect(signInNofiier.state.message, null);
    });

    UserModel model = UserModel(email: "", password: "");
    test(
      """after userLogin is called,
        set loadState = to NetworkState.loading,
        when the response is successful,
        set loadState to NetworkState.success,
        set user to the data from the response,
        set message to  "successfully!!!"
      """,
      () async {
        when(() => mockService.login(model)).thenAnswer((_) async => res);

        final future = signInNofiier.userLogin(model);

        expect(signInNofiier.state.loadState, NetworkState.loading);
        await future;
        expect(signInNofiier.state.loadState, NetworkState.success);

        expect(signInNofiier.state.user, isA<UserModel>());
        expect(signInNofiier.state.message, "successfully!!!");
      },
    );

    test("""when updatedPasswordVisibility is called,
            toggle isVisible state
         """, () {
      signInNofiier.updatedPasswordVisibility();

      expect(signInNofiier.state.isVisible, true);
    });
  });
}
