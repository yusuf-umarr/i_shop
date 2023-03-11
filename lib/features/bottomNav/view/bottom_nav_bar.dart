import 'package:flutter/material.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/features/home/view/home_screen.dart';
import 'package:i_shop_riverpod/features/profile/view/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  void checkSecondTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isSecondTime", true);
  }

  @override
  void initState() {
    checkSecondTime();
    super.initState();
  }

  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

//buyer
  List<Widget> pages = [
    const HomeScreen(),
    const ProfileScreen(),
  ];



  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      body:
      

          pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // HOME
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            label: '',
          ),

          // PROFILE
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: Icon(
                Icons.person_outline_outlined,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
