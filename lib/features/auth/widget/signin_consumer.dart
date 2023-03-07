import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/common_widget/custom_button.dart';
import 'package:i_shop_riverpod/common_widget/custom_textfield.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/core/constants/utils.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/bottomNav/view/bottom_nav_bar.dart';
import 'package:i_shop_riverpod/features/payment/view/address_screen.dart';
import 'package:i_shop_riverpod/features/auth/model/user_model.dart';
import 'package:i_shop_riverpod/features/auth/view_model/auth_view_model.dart';
import 'package:i_shop_riverpod/features/auth/view_model/auth_view_state.dart';

Consumer signInConsumer(signInFormKey, emailController, passwordController,
    tottalAmount, prevPage) {
  return Consumer(builder: (context, ref, child) {
    ref.listen<AuthUserState>(authViewModel, (prev, state) {
      if (state.loginState == LoginState.error) {
        showSnackBar(context, state.message.toString());
      } else if (state.loginState == LoginState.success) {
        showSnackBar(context, state.message.toString());

        Timer(const Duration(milliseconds: 300), () {
          if (prevPage == "cart-screen") {
            Navigator.pushReplacementNamed(context, AddressScreen.routeName,
                arguments: tottalAmount);
          } else {
            Navigator.pushReplacementNamed(context, BottomBar.routeName,
                arguments: tottalAmount);
          
          }
        });
      }
    });
    return Container(
      padding: const EdgeInsets.all(8),
      color: GlobalVariables.backgroundColor,
      child: Form(
        key: signInFormKey,
        child: Column(
          children: [
            CustomTextField(
              controller: emailController,
              hintText: 'Email',
            ),
            const SizedBox(height: 10),
            CustomTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: false),
            const SizedBox(height: 10),
            Consumer(builder: (context, val, _) {
              final authState = ref.watch(authViewModel);
              return CustomButton(
                text: authState.loginState == LoginState.idle
                    ? 'Sign In'
                    : authState.loginState == LoginState.loading
                        ? 'Please wait'
                        : "Sign In",
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  // var provider = Provider.of<AuthViewModel>(context,
                  //     listen: false);

                  if (signInFormKey.currentState!.validate()) {
                    UserModel model = UserModel(
                        email: emailController.text,
                        password: passwordController.text);

                    ref.read(authViewModel.notifier).userLogin(model);
                  }
                },
                color: GlobalVariables.primaryColor,
              );
            })
          ],
        ),
      ),
    );
  });
}
