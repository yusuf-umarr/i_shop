import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/common_widget/custom_button.dart';
import 'package:i_shop_riverpod/common_widget/custom_textfield.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/core/constants/utils.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/auth/model/user_model.dart';
import 'package:i_shop_riverpod/features/auth/view_model/auth_view_model.dart';
import 'package:i_shop_riverpod/features/auth/view_model/auth_view_state.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends ConsumerStatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  // final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  bool isWait = false;

  @override
  Widget build(BuildContext context) {
    // ref.listen<AuthUserState>(authViewModel, (prev, state) {
    //   if (state.loginState == LoginState.error) {
    //     showSnackBar(context, state.message.toString());
    //   } else if (state.loginState == LoginState.success) {
    //     showSnackBar(context, state.message.toString());

    //     // Timer(Duration(milliseconds: 300), () {});
    //   }

    //   if (state.registerState == RegisterState.error) {
    //     showSnackBar(context, state.message.toString());
    //   } else if (state.registerState == RegisterState.success) {
    //     showSnackBar(context, state.message.toString());

    //     // Timer(Duration(milliseconds: 300), () {});
    //   }
    // });
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                const Text(
                  'Login or Create account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),
                ListTile(
                  tileColor: _auth == Auth.signup
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundCOlor,
                  title: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signup,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signup)
                  Consumer(builder: (context, ref, child) {
                    ref.listen<AuthUserState>(authViewModel, (prev, state) {
                      if (state.registerState == RegisterState.error) {
                        showSnackBar(context, state.message.toString());
                      } else if (state.registerState == RegisterState.success) {
                        showSnackBar(context, state.message.toString());

                        // Timer(Duration(milliseconds: 300), () {});
                      }
                    });
                    return Container(
                      padding: const EdgeInsets.all(8),
                      color: GlobalVariables.backgroundColor,
                      child: Form(
                        key: _signUpFormKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _nameController,
                              hintText: 'Name',
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: _emailController,
                              hintText: 'Email',
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                                controller: _passwordController,
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

                                  if (_signUpFormKey.currentState!.validate()) {
                                    UserModel model = UserModel(
                                        name: _nameController.text,
                                        email: _emailController.text,
                                        password: _passwordController.text);

                                    ref
                                        .read(authViewModel.notifier)
                                        .userRegister(model);
                                  }
                                },
                              );

                              // CustomButton(
                              //   text: isWait ? "please wait..." : 'Sign Up',
                              //   onTap: () async {
                              //     setState(() {
                              //       isWait = true;
                              //     });

                              //     Timer(const Duration(seconds: 3), () {
                              //       setState(() {
                              //         isWait = false;
                              //       });
                              //     });
                              //     FocusScope.of(context).unfocus();
                              //     if (_signUpFormKey.currentState!.validate()) {

                              //     }
                              //   },
                              // );
                            })
                          ],
                        ),
                      ),
                    );
                  }),
                ListTile(
                  tileColor: _auth == Auth.signin
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundCOlor,
                  title: const Text(
                    'Sign-In.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signin)
                  Consumer(builder: (context, ref,child) {
                    ref.listen<AuthUserState>(authViewModel, (prev, state) {
                      if (state.loginState == LoginState.error) {
                        showSnackBar(context, state.message.toString());
                      } else if (state.loginState == LoginState.success) {
                        showSnackBar(context, state.message.toString());

                        // Timer(Duration(milliseconds: 300), () {});
                      }
                    });
                    return Container(
                      padding: const EdgeInsets.all(8),
                      color: GlobalVariables.backgroundColor,
                      child: Form(
                        key: _signInFormKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _emailController,
                              hintText: 'Email',
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                                controller: _passwordController,
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

                                  if (_signInFormKey.currentState!.validate()) {
                                    UserModel model = UserModel(
                                        email: _emailController.text,
                                        password: _passwordController.text);

                                    ref
                                        .read(authViewModel.notifier)
                                        .userLogin(model);
                                  }
                                },
                              );
                            })
                          ],
                        ),
                      ),
                    );
                  }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
