import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  const ShowImage(
      {super.key,
      required this.imagePath,
      required this.height,
      required this.width});
  final String imagePath;
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image:
            DecorationImage(image: AssetImage(imagePath), fit: BoxFit.contain),
      ),
    );
  }
}
