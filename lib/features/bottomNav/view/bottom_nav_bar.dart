import 'package:flutter/material.dart';
import 'package:i_shop_riverpod/core/constants/global_variables.dart';
import 'package:i_shop_riverpod/features/home/view/home_screen.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

//buyer
  List<Widget> pages = [
    HomeScreen(),
    Container(
      child: Text("Account"),
    ),
    Container(
      child: Text("Chat"),
    ),
  ];

//seller
  List<Widget> sellerPages = [
    Container(
      child: Text("post screen"),
    ),
    Container(
      child: Text("Analytic screen"),
    ),
    Container(
      child: Text("Order screen"),
    ),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final usermodel = context.watch<AuthViewModel>().userModel;

    int cartLenght = 0;

    // if(usermodel!=null){

    //   cartLenght= usermodel.cart!.length;

    // }

    // final user = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body:
          // user.userModel == null
          //     ? const Loader()
          //     : user.isSeller == true
          //         ? sellerPages[_page]
          //         :

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
          // ACCOUNT
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: Icon(
                // user.isSeller == true
                //     ? Icons.analytics_outlined
                //     :
                Icons.person_outline_outlined,
              ),
            ),
            label: '',
          ),
          // CART
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
              child: Badge(
                // elevation: 0,
                label:
                    Text("user.isSeller == true ? " " : cartLenght.toString()"),
                // badgeContent: Text(userCartLen.toString()),
                backgroundColor: Colors.white,
                child: Icon(
                  // user.isSeller == true
                  //     ? Icons.all_inbox_outlined
                  //     :

                  Icons.shopping_cart_outlined,
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
