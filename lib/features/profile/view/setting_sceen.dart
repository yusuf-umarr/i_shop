import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/common_widget/custom_button.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/auth/view/auth_screen.dart';
import 'package:i_shop_riverpod/features/auth/view_model/auth_view_model.dart';
import 'package:i_shop_riverpod/features/profile/widget/edit_profile_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends ConsumerStatefulWidget {
  static const String routeName = '/settings';

  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  void logOut(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('x-auth-token');

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => AuthScreen(
                  prevPage: 'profile-screen',
                )),
        ModalRoute.withName('/auth-screen'));
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final authUserState = ref.watch(authViewModel);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Text("Settings"),
          ),
        ),
        body: ListView(
            padding: EdgeInsets.symmetric(vertical: defaultPadding),
            children: [
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      authUserState.user.profilePic != null
                          ? CircleAvatar(
                              backgroundImage:
                                  NetworkImage(authUserState.user.profilePic),
                              radius: 40.0,
                            )
                          : CircleAvatar(
                              backgroundImage: AssetImage(
                                "assets/images/profilePics.jpeg",
                              ),
                              radius: 40.0,
                            ),
                    ],
                  ),
                  Positioned(
                      right: 0,
                      child: IconButton(
                          onPressed: () {
                            showCustomDialog(
                                context: context,
                                onValue: (_) {
                                 
                                },
                                authUserState: authUserState,
                                ref: ref);
                          },
                          icon: Icon(Icons.edit)))
                ],
              ),
              ListTile(
                title: Text("Name"),
                trailing: (Text(authUserState.user.name!)),
              ),
              ListTile(
                title: Text("Email"),
                trailing: (Text(authUserState.user.email!)),
              ),
              ListTile(
                title: Text("Shipping Address"),
                trailing: (Text(authUserState.user.address!)),
              ),
            ]),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: CustomButton(
            text: 'Sign out',
            onTap: () {
              logOut(context);
            },
          ),
        ));
  }
}
