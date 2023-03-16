import 'package:flutter_test/flutter_test.dart';
import 'package:i_shop_riverpod/core/config/response/api_response.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/auth/model/user_model.dart';
import 'package:i_shop_riverpod/features/auth/service/auth_repository.dart';
import 'package:i_shop_riverpod/features/auth/view_model/notifier/signup_notifier.dart';
import 'package:mocktail/mocktail.dart';

class MockService extends Mock implements AuthRepositoryImpl {}

void main() {
  late MockService mockService;
  late SignUpNofiier signUpNofiier;

  setUp(() {
    mockService = MockService();
    signUpNofiier = SignUpNofiier(mockService);
  });
  group('SignUpNotifier-', () {
    final res = ApiResponse<UserModel>(
      success: true,
      data: UserModel(),
      message: "successfully!!!",
    );

    test("check if the initial values are correct", () {
      expect(signUpNofiier.state.isVisible, false);
      expect(signUpNofiier.state.loadState, NetworkState.idle);
      expect(signUpNofiier.state.user, isA<UserModel>());
      expect(signUpNofiier.state.message, null);
    });

    UserModel model = UserModel(email: "", password: "");
    test(
      """after userRegister is called,
        set loadState = to NetworkState.loading,
        when the response is successful,
        set loadState to NetworkState.success,
        set user to the data from the response,
        set message to  "successfully!!!"
      """,
      () async {
        when(() => mockService.register(model)).thenAnswer((_) async => res);

        final future = signUpNofiier.userRegister(model);

        expect(signUpNofiier.state.loadState, NetworkState.loading);
        await future;
        expect(signUpNofiier.state.loadState, NetworkState.success);

        expect(signUpNofiier.state.user, isA<UserModel>());
        expect(signUpNofiier.state.message, "successfully!!!");
      },
    );

    test("""when updatedPasswordVisibility is called,
            toggle isVisible state
         """, () {
      signUpNofiier.updatedPasswordVisibility();

      expect(signUpNofiier.state.isVisible, true);
    });
  });
}
