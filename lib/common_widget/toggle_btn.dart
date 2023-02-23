import 'package:flutter/material.dart';

class ToggleBotton extends StatelessWidget {
  const ToggleBotton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
        value: true,
        onChanged: (value) {
          // final provider = Provider.of<AuthViewModel>(context, listen: false);
          // provider.toggleUserRole(value);
        });
  }
}
