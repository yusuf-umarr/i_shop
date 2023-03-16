import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:i_shop_riverpod/core/config/response/api_response.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/auth/model/user_model.dart';
import 'package:i_shop_riverpod/features/auth/service/auth_repository.dart';
import 'package:i_shop_riverpod/features/auth/view_model/notifier/user_notifier.dart';
import 'package:i_shop_riverpod/features/auth/view_model/states/user_state.dart';
import 'package:mocktail/mocktail.dart';

class MockService extends Mock implements AuthRepositoryImpl {}

void main() {
  late MockService mockService;
  late UserNotifier userNotifier;

  setUp(() {
    mockService = MockService();
    userNotifier = UserNotifier(mockService, );
  });
  group('SignUpNotifier-', () {
    final res = ApiResponse<UserModel>(
      success: true,
      data: UserModel(),
      message: "successfully!!!",
    );

    test("check if the initial values are correct", () {
      expect(userNotifier.state.loadState, NetworkState.idle);
      expect(userNotifier.state.user, isA<UserModel>());
      expect(userNotifier.state.message, null);
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

        userNotifier.updateFetchDataLogin();

        expect(userNotifier.state.loadState, NetworkState.success);

        expect(userNotifier.state.user, isA<UserModel>());
      },
    );
  });
}
