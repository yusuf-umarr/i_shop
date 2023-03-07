import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/auth/model/user_model.dart';
import 'package:i_shop_riverpod/features/auth/service/auth_repository.dart';
import 'package:i_shop_riverpod/features/auth/view_model/auth_view_state.dart';

class AuthViewModel extends StateNotifier<AuthUserState> {
  AuthViewModel(this._authRepository) : super(AuthUserState.initial());

  final AuthRepository _authRepository;

  void userLogin(UserModel model) async {
    state = state.copyWith(loginState: LoginState.loading);
    try {
      final response = await _authRepository.login(model);

      if (response.success) {
        state = state.copyWith(
          user: response.data,
          loadState: NetworkState.success,
          loginState: LoginState.success,
          userDataState: UserDataState.success,
          message: response.message,
        );
        return;
      }
      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
        loginState: LoginState.error,
        userDataState: UserDataState.error,
      );
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        loginState: LoginState.error,
        userDataState: UserDataState.error,
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
          userDataState: UserDataState.success,
        );
        return;
      }
      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
        registerState: RegisterState.error,
        userDataState: UserDataState.error,
      );
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        registerState: RegisterState.error,
        userDataState: UserDataState.error,
        message: e.toString(),
      );
    }
  }

  void updateUserAddress(String userAddress) async {
    try {
      final response = await _authRepository.updateAddress(userAddress);

      if (response.success) {
        state = state.copyWith(
          user: response.data,
          loadState: NetworkState.success,
          userAddessState: UserAddressState.success,
        );
        return;
      }
      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
        userAddessState: UserAddressState.error,
      );
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        userAddessState: UserAddressState.error,
        message: e.toString(),
      );
    }
  }

  void updateUserDetail(UserModel model) async {
    try {
      final response = await _authRepository.updateUser(model);

      if (response.success) {
        state = state.copyWith(
          user: response.data,
          loadState: NetworkState.success,
          updateUserState: UpdateUserState.success,
        );

        Future.delayed(Duration(seconds: 1), () {
          state = state.copyWith(
            updateUserState: UpdateUserState.idle,
          );
        });

        return;
      }
      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
        updateUserState: UpdateUserState.error,
      );
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        updateUserState: UpdateUserState.error,
        message: e.toString(),
      );
    }
  }

  void fetchUserData() async {
    try {
      final response = await _authRepository.getUserData();

      if (response.success) {
        state = state.copyWith(
          user: response.data,
          loadState: NetworkState.success,
          userDataState: UserDataState.success,
        );
        return;
      }
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        userDataState: UserDataState.error,
        message: e.toString(),
      );
    }
  }
}

final authViewModel = StateNotifierProvider<AuthViewModel, AuthUserState>(
    (ref) => AuthViewModel(ref.read(authRepository)));
