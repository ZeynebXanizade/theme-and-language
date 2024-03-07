import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final Color color;
  final Widget child;
  const MyContainer({super.key, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width ,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          color: color),
      child: child,
    );
  }
}
