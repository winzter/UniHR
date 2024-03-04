import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProfile extends StatelessWidget {

  final double width;
  final double height;
  const ShimmerProfile({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child:Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
              color: Colors.grey, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),)
          ),
        ));
  }
}
