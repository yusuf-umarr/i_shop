// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/auth/model/user_model.dart';

class AuthUserState {
  final NetworkState loadState;
  final UserModel user;
  final String? message;
  final LoginState loginState;
  final RegisterState registerState;
  final UserAddressState userAddessState;
  final UserDataState userDataState;
  final UpdateUserState updateUserState;
  AuthUserState({
    required this.loadState,
    required this.user,
    required this.message,
    required this.loginState,
    required this.registerState,
    required this.userAddessState,
    required this.userDataState,
    required this.updateUserState,
  });

  factory AuthUserState.initial() {
    return AuthUserState(
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
      loginState: LoginState.idle,
      registerState: RegisterState.idle,
      userAddessState: UserAddressState.idle,
      userDataState: UserDataState.idle,
      updateUserState: UpdateUserState.idle,
    );
  }









  AuthUserState copyWith({
    NetworkState? loadState,
    UserModel? user,
    String? message,
    LoginState? loginState,
    RegisterState? registerState,
    UserAddressState? userAddessState,
    UserDataState? userDataState,
    UpdateUserState? updateUserState,
  }) {
    return AuthUserState(
      loadState: loadState ?? this.loadState,
      user: user ?? this.user,
      message: message ?? this.message,
      loginState: loginState ?? this.loginState,
      registerState: registerState ?? this.registerState,
      userAddessState: userAddessState ?? this.userAddessState,
      userDataState: userDataState ?? this.userDataState,
      updateUserState: updateUserState ?? this.updateUserState,
    );
  }
}
