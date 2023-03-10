import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/auth/view_model/notifier/user_notifier.dart';
import 'package:i_shop_riverpod/features/profile/view/setting_sceen.dart';
import 'package:i_shop_riverpod/features/profile/widget/orders.dart';
import 'package:i_shop_riverpod/features/profile/widget/top_profile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUserState = ref.watch(userNotifier);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: GlobalVariables.greyBackgroundColor,
        actions: [
          if (authUserState.loadState == NetworkState.success)
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  SettingScreen.routeName,
                );
              },
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
            )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            TopProfile(),
            if (authUserState.loadState == NetworkState.success)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Text(
                  'Orders',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (authUserState.loadState == NetworkState.success) Orders()
          ],
        ),
      ),
    );
  }
}
