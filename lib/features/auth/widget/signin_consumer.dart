import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/common_widget/custom_button.dart';
import 'package:i_shop_riverpod/common_widget/custom_textfield.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/core/constants/utils.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/auth/view_model/notifier/signin_notifier.dart';
import 'package:i_shop_riverpod/features/auth/view_model/notifier/user_notifier.dart';
import 'package:i_shop_riverpod/features/auth/view_model/states/signin_state.dart';
import 'package:i_shop_riverpod/features/bottomNav/view/bottom_nav_bar.dart';
import 'package:i_shop_riverpod/features/payment/view/address_screen.dart';
import 'package:i_shop_riverpod/features/auth/model/user_model.dart';

Consumer signInConsumer(signInFormKey, emailController, passwordController,
    tottalAmount, prevPage) {
  return Consumer(builder: (context, ref, child) {
    ref.listen<SignInState>(signInNotifier, (prev, state) {
      if (state.loadState == NetworkState.error) {
        showSnackBar(context, state.message.toString());
      } else if (state.loadState == NetworkState.success) {
        ref.read(userNotifier.notifier).updateFetchDataLogin();
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
            Consumer(builder: (context, ref, _) {
              final signinState = ref.watch(signInNotifier);

              return CustomTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: !signinState.isVisible,
                surfixIcon: IconButton(
                  onPressed: () {
                    ref
                        .read(signInNotifier.notifier)
                        .updatedPasswordVisibility();
                  },
                  icon: Icon(signinState.isVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              );
            }),
            const SizedBox(height: 10),
            Consumer(builder: (context, val, _) {
              final signinState = ref.watch(signInNotifier);
              return CustomButton(
                text: signinState.loadState == NetworkState.idle
                    ? 'Sign In'
                    : signinState.loadState == NetworkState.loading
                        ? 'Please wait'
                        : "Sign In",
                onTap: () async {
                  FocusScope.of(context).unfocus();

                  if (signInFormKey.currentState!.validate()) {
                    UserModel model = UserModel(
                        email: emailController.text,
                        password: passwordController.text);

                    ref.read(signInNotifier.notifier).userLogin(model);
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
