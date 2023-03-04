import 'package:flutter/material.dart';

import 'widget/search_field.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          const SearchField(),
        ]
      ),
    );
  }
}