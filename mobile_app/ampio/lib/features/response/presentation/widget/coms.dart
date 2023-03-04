import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Coms extends StatelessWidget {
  const Coms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Votre réponse...',
          filled: true
        ),
      ),
    );
  }
}
