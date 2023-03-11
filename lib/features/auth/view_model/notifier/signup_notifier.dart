import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/auth/model/user_model.dart';
import 'package:i_shop_riverpod/features/auth/service/auth_repository.dart';
import 'package:i_shop_riverpod/features/auth/view_model/states/signup_state.dart';

class SignUpNofiier extends StateNotifier<SignupState> {
  SignUpNofiier(this._authRepository) : super(SignupState.initial());

  final AuthRepository _authRepository;

   void userRegister(UserModel model) async {
    // state = state.copyWith(
    //       loadState: NetworkState.loading,
    // );
    try {
      final response = await _authRepository.register(model);

      if (response.success) {
        state = state.copyWith(
          user: response.data,
          loadState: NetworkState.success,
          // userDataState: UserDataState.success,
        );
        return;
      }
      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
        // userDataState: UserDataState.error,
      );
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        // userDataState: UserDataState.error,
        message: e.toString(),
      );
    }
  }

  void updatedPasswordVisibility() {
    state = state.copyWith(isVisible: !state.isVisible);
    print(state.isVisible);
  }
}

final signUpNotifier = StateNotifierProvider<SignUpNofiier, SignupState>(
    (ref) => SignUpNofiier(ref.read(authRepository)));
