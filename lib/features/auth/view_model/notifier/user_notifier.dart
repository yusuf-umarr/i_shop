import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/auth/model/user_model.dart';
import 'package:i_shop_riverpod/features/auth/service/auth_repository.dart';
import 'package:i_shop_riverpod/features/auth/view_model/notifier/signin_notifier.dart';
import 'package:i_shop_riverpod/features/auth/view_model/notifier/signup_notifier.dart';
import 'package:i_shop_riverpod/features/auth/view_model/states/user_state.dart';

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier(this._authRepository, this.ref) : super(UserState.initial());

  final AuthRepository _authRepository;
  final StateNotifierProviderRef ref;  //===========>this 

  void updateFetchDataLogin() async {
    final signInState = ref.read(signInNotifier.notifier).state;

    try {
      state = state.copyWith(
        user: signInState.user,
        loadState: signInState.loadState,
      );
      return;
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        message: e.toString(),
      );
    }
  }

  void updateFetchDataRegister() async {
    final signUpState = ref.read(signUpNotifier.notifier).state;

    try {
      state = state.copyWith(
        user: signUpState.user,
        loadState: signUpState.loadState,
      );
      return;
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
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

  void updateUserDetail(UserModel model) async {
    state = state.copyWith(
      updateUserState: UpdateUserState.loading,
    );
    try {
      final response = await _authRepository.updateUser(model);

      if (response.success) {
        state = state.copyWith(
          user: response.data,
          loadState: NetworkState.success,
          updateUserState: UpdateUserState.success,
        );

        Future.delayed(const Duration(seconds: 1), () {
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
        );
        return;
      }
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        message: e.toString(),
      );
    }
  }
}

final userNotifier = StateNotifierProvider<UserNotifier, UserState>(
    (ref) => UserNotifier(ref.read(authRepository), ref));
