import 'package:flutter/material.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = '/checkout';

  CheckoutScreen({super.key});

  // late WebViewController controller;

  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(paymentUrl));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Payment"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
