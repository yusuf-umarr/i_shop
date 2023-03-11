// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/auth/model/user_model.dart';

class SignupState {
  final NetworkState loadState;
  final UserModel user;
  final String? message;
  final bool isVisible;
  SignupState({
    required this.loadState,
    required this.user,
    required this.message,
     this.isVisible =false,

  });

  factory SignupState.initial() {
    return SignupState(
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
      loadState: NetworkState.idle,
      message: null,
      isVisible: false,
    );
  }

 

  SignupState copyWith({
    NetworkState? loadState,
    UserModel? user,
    String? message,
    bool? isVisible,
  }) {
    return SignupState(
      loadState: loadState ?? this.loadState,
      user: user ?? this.user,
      message: message ?? this.message,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}
