import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  const MyBarrier({super.key, required this.size});
  final size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
        height: size,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(width: 10, color: Colors.black),
        borderRadius: BorderRadius.circular(10)

      ),
    );
  }
}
