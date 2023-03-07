import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/features/auth/view_model/auth_view_model.dart';

class AddressBox extends ConsumerWidget {
   AddressBox({Key? key}) : super(key: key);

  String userAddre = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   userAddre= ref.watch(authViewModel).user.address!;

    return Container(
      height: 40,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 114, 226, 221),
            Color.fromARGB(255, 162, 236, 233),
          ],
          stops: [0.5, 1.0],
        ),
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                'Delivery to $userAddre',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 5,
              top: 2,
            ),
            child: Icon(
              Icons.arrow_drop_down_outlined,
              size: 18,
            ),
          )
        ],
      ),
    );
  }
}
