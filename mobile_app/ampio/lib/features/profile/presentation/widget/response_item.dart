import 'package:flutter/material.dart';

class ResponseItem extends StatelessWidget {
  const ResponseItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset('assets/images/avatar.jpg', height: 25),
              )
            ],
          )
        ],
      ),
    );
  }
}
