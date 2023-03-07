import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

void logOut() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('x-auth-token');

}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: InkWell(
          onTap: logOut,
          child: Text("Logout"),
        ),
      ),
    );
  }
}
