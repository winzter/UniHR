import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class GradientButton extends StatelessWidget {

  final VoidCallback? function;
  final String text;
  const GradientButton({super.key, this.function, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: const Color(0xff68D5E8),
              ),
              borderRadius: BorderRadius.circular(20))),
      child: GradientText(
        text,
        style:
        TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        colors: const [
          Color(0xff68D5E8),
          Color(0xffF394BC),
        ],
      ),
    );
  }
}
