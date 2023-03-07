import 'package:flutter/material.dart';
import 'package:i_shop_riverpod/core/config/route/route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/core/config/theme/app_theme.dart';
import 'package:i_shop_riverpod/features/auth/view_model/auth_view_model.dart';
import 'package:i_shop_riverpod/features/bottomNav/view/bottom_nav_bar.dart';
import 'package:i_shop_riverpod/features/bottomNav/view/onboard_scren.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isSecondTime = await prefs.getBool("isSecondTime") ?? false;
  runApp(ProviderScope(child: MyApp(isSecondTime: isSecondTime)));
}

class MyApp extends ConsumerStatefulWidget {
  final bool isSecondTime;
  const MyApp({
    super.key,
    required this.isSecondTime,
  });

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    ref.read(authViewModel.notifier).fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Avenza Store',
       theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: widget.isSecondTime ? const BottomBar() : OnboardScreen(),
      // home: LogoScreen(),
    );
  }
}
