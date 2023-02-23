import 'package:flutter/material.dart';
import 'package:i_shop_riverpod/core/config/route/route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/features/bottomNav/view/bottom_nav_bar.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
    
        primarySwatch: Colors.blue,
      ),
            onGenerateRoute: (settings) => generateRoute(settings),

      home: const BottomBar(),
    );
  }
}
