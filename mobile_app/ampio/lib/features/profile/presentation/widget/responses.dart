import 'package:flutter/material.dart';

import '../../../../features/profile/presentation/widget/response_item.dart';

class Responses extends StatelessWidget {
  const Responses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return const ResponseItem();
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: 5),
          ),
        ],
      ),
    );
  }
}
