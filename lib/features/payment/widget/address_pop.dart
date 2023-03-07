  import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/common_widget/custom_textfield.dart';
import 'package:i_shop_riverpod/core/constants/utils.dart';

payPop(context, cardFormKey, totalPrice) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          final height = MediaQuery.of(context).size.height;

          // AuthViewModel provider = context.watch<AuthViewModel>();

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              content: Container(
                height: height * 0.4,
                width: 90,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: SingleChildScrollView(
                  child: Form(
                    key: cardFormKey,
                    child: Column(
                      children: [
                        const FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            "Are uyou",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                      
                   
                        const SizedBox(height: 25),
                        Consumer(builder: (context, val, _) {
                          return ElevatedButton(
                            onPressed: () {
                              // Provider.of<AuthViewModel>(context, listen: false)
                              //     .setLoading(true);

                              if (cardFormKey.currentState!.validate()) {
                                // Provider.of<AuthViewModel>(context,
                                //         listen: false)
                                //     .placeOrder(
                                //   context,
                                //   addressToBeUsed,
                                //   double.parse(widget.totalAmount),
                                // );

                                // if (provider.isLoading == false) {
                                //   // Navigator.pop(context);

                                //   print("done");

                                //  navigateToHome();
                                // }

                                // !val.isLoading ? print("done") : null;
                              } else {
                                // return print('Please enter all the values!');
                                return showSnackBar(
                                    context, 'Please enter all the values!');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: Text("Pay \$$totalPrice",
                                style: const TextStyle(color: Colors.white)),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

