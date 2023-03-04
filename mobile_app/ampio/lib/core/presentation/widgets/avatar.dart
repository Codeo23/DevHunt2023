import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {

  final ImageProvider? imageProvider;
  final double borderRadius;

  const Avatar({
    Key? key,
    required this.borderRadius,
    this.imageProvider
  }): super(key: key);

  @override
  Widget build(BuildContext context) {

    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: borderRadius,
      child: CircleAvatar(
        backgroundImage: imageProvider,
        radius: borderRadius - 3,
      ),
    );
  }
}