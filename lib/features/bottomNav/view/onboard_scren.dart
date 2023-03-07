import 'package:flutter/material.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/features/bottomNav/view/bottom_nav_bar.dart';

import 'package:lottie/lottie.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _onboardAnimationController;
  late Animation<double> _animateContainer;
  late Animation<double> _animateText;

  bool isOnboardLoaded = false;
  bool showWelcomeText = false;
  bool showOtherText = false;
  bool showFabBtn = false;

  setupAnimation() {
    _onboardAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));

    _onboardAnimationController.addListener(() {
      if (_onboardAnimationController.value > 0.7) {
        _onboardAnimationController.stop();
        isOnboardLoaded = true;
        setState(() {});
        Future.delayed(const Duration(milliseconds: 1400), () {
          showWelcomeText = true;
          setState(() {});
        });
        Future.delayed(const Duration(milliseconds: 1800), () {
          showOtherText = true;
          setState(() {});
        });
        Future.delayed(const Duration(milliseconds: 2000), () {
          showFabBtn = true;
          setState(() {});
        });
      }
    });

    _animateContainer = CurvedAnimation(
        parent: _onboardAnimationController, curve: const Interval(0.5, 1));
  }

  @override
  void initState() {
    setupAnimation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
          animation: Listenable.merge([_onboardAnimationController]),
          builder: (context, _) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.4,
                    ),
                    AnimatedOpacity(
                      duration: defaultDuration,
                      opacity: showOtherText ? 1 : 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          "Find the best product for your needs",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: AnimatedOpacity(
                    duration: defaultDuration,
                    opacity: showFabBtn ? 1 : 0,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, BottomBar.routeName, (route) => false);
                      },
                      child: Icon(Icons.forward),
                      backgroundColor: GlobalVariables.primaryColor,
                    ),
                  ),
                ),
                Column(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 1100),
                      height: isOnboardLoaded ? size.height / 1.7 : size.height,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(isOnboardLoaded ? 20 : 0),
                        gradient: GlobalVariables.appBarGradient,
                      ),
                      child: Column(
                        children: [
                          Lottie.asset(
                            'assets/cart_phone.json',
                            controller: _onboardAnimationController,
                            onLoaded: (composition) {
                              _onboardAnimationController
                                ..duration = composition.duration
                                ..forward();
                            },
                            // height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: AnimatedOpacity(
                              duration: defaultDuration,
                              opacity: showWelcomeText ? 1 : 0,
                              child: Text(
                                "Welcome to Avenza store",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 23, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
