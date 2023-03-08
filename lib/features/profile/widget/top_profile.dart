import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/auth/view/auth_screen.dart';
import 'package:i_shop_riverpod/features/auth/view_model/auth_view_model.dart';

class TopProfile extends ConsumerWidget {
  const TopProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUserState = ref.watch(authViewModel);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
      ).copyWith(bottom: defaultPadding),
      decoration: BoxDecoration(
        color: GlobalVariables.greyBackgroundColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              if (authUserState.userDataState == UserDataState.success) ...[
                CircleAvatar(
                  backgroundImage: NetworkImage(authUserState.user.profilePic !=
                          null
                      ? authUserState.user.profilePic
                      : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                  radius: 40.0,
                ),
              ],

              if (authUserState.userDataState != UserDataState.success)
                CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/profilePics.jpeg",
                  ),
                  radius: 40.0,
                ),
            
              SizedBox(
                width: defaultPadding,
              ),
              if (authUserState.userDataState == UserDataState.success)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authUserState.user.name!,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: defaultPadding / 2,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 7,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)),
                              color: Colors.orange.withOpacity(0.5)),
                        ),
                        Container(
                            height: 7,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            )),
                        SizedBox(width: defaultPadding),
                        Text(
                          "50/100",
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    )
                  ],
                ),
              if (authUserState.userDataState != UserDataState.success)
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AuthScreen.routeName,
                          arguments: "profile-screen");
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding,
                            vertical: defaultPadding),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(defaultPadding),
                            color: Colors.white),
                        child: Text("Lggin/Create Account")))
            ],
          ),
        ],
      ),
    );
  }
}
