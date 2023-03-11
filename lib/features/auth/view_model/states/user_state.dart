// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/auth/model/user_model.dart';

class UserState {
  final NetworkState loadState;
  final UserModel user;
  final String? message;
  final UpdateUserState updateUserState;
  UserState({
    required this.loadState,
    required this.user,
    required this.message,
    required this.updateUserState,
  });

  factory UserState.initial() {
    return UserState(
      user: UserModel(
        id: "",
        token: "",
        name: "",
        email: "",
        password: "",
        address: "",
        type: "",
        cart: [],
        v: null,
      ),
      loadState: NetworkState.loading,
      message: null,
      updateUserState: UpdateUserState.idle,
    );
  }

  UserState copyWith({
    NetworkState? loadState,
    UserModel? user,
    String? message,
    UpdateUserState? updateUserState,
  }) {
    return UserState(
      loadState: loadState ?? this.loadState,
      user: user ?? this.user,
      message: message ?? this.message,
      updateUserState: updateUserState ?? this.updateUserState,
    );
  }
}
