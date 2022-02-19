import 'package:flutter/material.dart';

class SquaryImage extends StatelessWidget {
  final double size;
  const SquaryImage({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
    );
  }
}
