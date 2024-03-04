import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEmp extends StatelessWidget {
  final double height;
  const ShimmerEmp({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: height,
            decoration: ShapeDecoration(
                color: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20),
                )),
          )),
    );
  }
}
