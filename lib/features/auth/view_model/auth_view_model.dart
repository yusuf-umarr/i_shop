import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/auth/model/user_model.dart';
import 'package:i_shop_riverpod/features/auth/service/auth_repository.dart';
import 'package:i_shop_riverpod/features/auth/view_model/auth_view_state.dart';

class AuthViewModel extends StateNotifier<AuthUserState> {
  AuthViewModel(this._authRepository) : super(AuthUserState.initial());

  final AuthRepository _authRepository;

  void userLogin(UserModel model) async {
    state = state.copyWith(
      loginState: LoginState.loading,
    );
    try {
      final response = await _authRepository.login(model);

      if (response.success) {
        state = state.copyWith(
          user: response.data,
          loadState: NetworkState.success,
          loginState: LoginState.success,
          message: response.message,
        );
        return;
      }
      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
        loginState: LoginState.error,
      );
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        loginState: LoginState.error,
        message: e.toString(),
      );
    }
  }

  void userRegister(UserModel model) async {
    state = state.copyWith(
      registerState: RegisterState.loading,
    );
    try {
      final response = await _authRepository.register(model);

      if (response.success) {
        state = state.copyWith(
          user: response.data,
          loadState: NetworkState.success,
          registerState: RegisterState.success,
        );
        return;
      }
      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
        registerState: RegisterState.error,
      );
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        registerState: RegisterState.error,
        message: e.toString(),
      );
    }
  }
}

final authViewModel = StateNotifierProvider<AuthViewModel, AuthUserState>(
    (ref) => AuthViewModel(ref.read(authRepository)));
