import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/common_widget/custom_button.dart';
import 'package:i_shop_riverpod/common_widget/custom_textfield.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/core/constants/utils.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/auth/model/user_model.dart';
import 'package:i_shop_riverpod/features/auth/view_model/auth_view_model.dart';

void showCustomDialog(
    {required BuildContext context,
    required ValueChanged onValue,
    required authUserState,
    required ref}) {
  final TextEditingController nameController =
      TextEditingController(text: authUserState.user.name!);
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController =
      TextEditingController(text: authUserState.user.address!);
  final TextEditingController emailController =
      TextEditingController(text: authUserState.user.email!);

  final updateKey = GlobalKey<FormState>();

  File? images;

  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      return StatefulBuilder(builder: (context, setState) {
        return Consumer(builder: (context, ref, _) {
          final state = ref.watch(authViewModel);

          if (state.updateUserState == UpdateUserState.success) {
            
            Navigator.of(context).pop();
          }
          return Center(
            child: Container(
              height: 620,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 30),
                    blurRadius: 60,
                  ),
                  const BoxShadow(
                    color: Colors.black45,
                    offset: Offset(0, 30),
                    blurRadius: 60,
                  ),
                ],
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Form(
                      key: updateKey,
                      child: Column(
                        children: [
                          const Text(
                            "Update Profile",
                            style: TextStyle(
                              fontSize: 32,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: defaultPadding * 1.2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  var res = pickSingleImage();

                                  images = await res;
                                  setState(() {});
                                },
                                child: images != null
                                    ? CircleAvatar(
                                        backgroundImage: new FileImage(images!),
                                        radius: 40.0,
                                      )
                                    : authUserState.user.profilePic != null
                                        ? CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                authUserState.user.profilePic),
                                            radius: 40.0,
                                          )
                                        : CircleAvatar(
                                            backgroundImage: AssetImage(
                                              "assets/images/profilePics.jpeg",
                                            ),
                                            radius: 40.0,
                                          ),
                              ),
                            ],
                          ),
                          SizedBox(height: defaultPadding),
                          CustomTextField(
                            controller: nameController,
                            hintText: 'Name',
                          ),
                          SizedBox(height: defaultPadding),
                          CustomTextField(
                            controller: emailController,
                            hintText: 'Email',
                          ),
                          SizedBox(height: defaultPadding),
                          CustomTextField(
                            controller: addressController,
                            hintText: 'Address',
                          ),
                          SizedBox(height: defaultPadding),
                          CustomTextField(
                            controller: passwordController,
                            hintText: 'Password',
                            obscureText: true,
                          ),
                          SizedBox(height: defaultPadding),
                          CustomButton(
                            text: 'Done',
                            onTap: () {
                              UserModel user = UserModel(
                                  name: nameController.text,
                                  email: emailController.text,
                                  address: addressController.text,
                                  password: passwordController.text,
                                  profilePic: images != null
                                      ? images
                                      : authUserState.user.profilePic != null
                                          ? authUserState.user.profilePic
                                          : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png");
                              if (updateKey.currentState!.validate()) {
                                ref
                                    .read(authViewModel.notifier)
                                    .updateUserDetail(user);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      left: 0,
                      right: 0,
                      bottom: -48,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      });
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;

      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);

      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: anim, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
  ).then(onValue);
}
