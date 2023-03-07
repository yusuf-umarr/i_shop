import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, index) {
              return shimmer(context);
            }));
  }

  Widget shimmer(context) => ListTile(
        leading: Shimmer.fromColors(
          baseColor: Colors.grey[400]!,
          highlightColor: Colors.grey[300]!,
          child: CircleAvatar(
            radius: 18,
            child: ClipOval(
              child: Container(
                color: Colors.grey,
              ),
            ),
          ),
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              color: Colors.grey,
              width: MediaQuery.of(context).size.width * 0.3,
              height: 16,
            ),
          ),
        ),
      );
}
