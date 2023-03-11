import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/auth/view/auth_screen.dart';
import 'package:i_shop_riverpod/features/auth/view_model/notifier/user_notifier.dart';

class TopProfile extends ConsumerWidget {
  TopProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUserState = ref.watch(userNotifier);

    final Size size = MediaQuery.of(context).size;

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
              if (authUserState.loadState == NetworkState.success) ...[
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      authUserState.user.profilePic != null
                          ? authUserState.user.profilePic
                          : defaultPic),
                  radius: 40.0,
                ),
              ],
              if (authUserState.loadState != NetworkState.success)
                CircleAvatar(
                  backgroundImage: AssetImage(
                    defaultPic,
                  ),
                  radius: 40.0,
                ),
              SizedBox(
                width: defaultPadding,
              ),
              if (authUserState.loadState == NetworkState.success)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.55,
                      child: Text(
                        authUserState.user.name!,
                        style: Theme.of(context).textTheme.headlineMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
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
              if (authUserState.loadState != NetworkState.success)
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
