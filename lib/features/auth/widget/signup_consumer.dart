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

Consumer signUpConsumer(signUpFormKey, nameController, emailController,
    passwordController, tottalAmount, prevPage) {
  return Consumer(builder: (context, ref, child) {
    ref.listen<AuthUserState>(authViewModel, (prev, state) {
      if (state.registerState == RegisterState.error) {
        showSnackBar(context, state.message.toString());
      } else if (state.registerState == RegisterState.success) {
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
        key: signUpFormKey,
        child: Column(
          children: [
            CustomTextField(
              controller: nameController,
              hintText: 'Name',
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: emailController,
              hintText: 'Email',
            ),
            const SizedBox(height: 10),
            CustomTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true),
            const SizedBox(height: 10),
            Consumer(builder: (context, val, _) {
              final authState = ref.watch(authViewModel);

              return CustomButton(
                text: authState.loginState == LoginState.idle
                    ? 'Sign Up'
                    : authState.loginState == LoginState.loading
                        ? 'Please wait'
                        : "Sign Sign Up",
                onTap: () async {
                  FocusScope.of(context).unfocus();

                  if (signUpFormKey.currentState!.validate()) {
                    UserModel model = UserModel(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text);

                    ref.read(authViewModel.notifier).userRegister(model);
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
