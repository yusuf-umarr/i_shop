import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/auth/model/user_model.dart';
import 'package:i_shop_riverpod/features/auth/service/auth_repository.dart';
import 'package:i_shop_riverpod/features/auth/view_model/states/signin_state.dart';

class SignInNofiier extends StateNotifier<SignInState> {
  SignInNofiier(this._authRepository) : super(SignInState.initial());

  final AuthRepository _authRepository;

  void userLogin(UserModel model) async {
    state = state.copyWith(loadState: NetworkState.loading);
    try {
      print(state.loadState);
      final response = await _authRepository.login(model);

      if (response.success) {
        state = state.copyWith(
          user: response.data,
          loadState: NetworkState.success,
          message: response.message,
        );

        return;
      }
      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
      );
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        message: e.toString(),
      );
    }
  }

  void updatedPasswordVisibility() {
    state = state.copyWith(isVisible: !state.isVisible);
    print(state.isVisible);
  }
}

final signInNotifier = StateNotifierProvider<SignInNofiier, SignInState>(
    (ref) => SignInNofiier(ref.read(authRepository)));
