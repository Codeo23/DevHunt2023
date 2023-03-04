import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/search_bar.dart';


class Questions extends StatelessWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(height: 10,),
          SearchBar(),
          Questions(),
          Questions()
        ],
      ),
    );
  }
}
