import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {

  final String imageUrl;
  final double borderRadius;

  const Avatar({
    Key? key,
    required this.borderRadius,
    required this.imageUrl
  }): super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        CircleAvatar(
          radius: borderRadius,
          backgroundColor: Colors.grey[200],
        ),
        ClipOval(
          child: Image.asset(
            imageUrl,
            width: borderRadius * 2,
            height: borderRadius * 2,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}