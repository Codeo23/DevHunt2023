import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../../core/utils/colors/app_colors.dart';
import 'widget/bottom_nav_bar_item.dart';
import 'widget/customized_app_bar.dart';

class Home extends StatelessWidget {

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const CustomizedAppBar(),
      floatingActionButton: FloatingActionButton(
        elevation: 5.0,
        backgroundColor: AppColors.yellowPrimary,
        onPressed: () {},
        child: const Icon(
          Icons.home,
          size: 36.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildBottomNavigationBar() {

    return SimpleShadow(
      opacity: 0.5,
      sigma: 5.0,
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 0.0,
        child: SizedBox(
          height: 60.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomNavBarItem(
                icon: Icons.home_filled,
                onTap: () {},
                borderSide: BorderSide(
                  color: AppColors.greenSecondary,
                  width: 3.5,
                ),
              ),
              BottomNavBarItem(
                icon: Icons.person,
                onTap: () {},
                borderSide: BorderSide(
                  color: AppColors.greenSecondary,
                  width: 3.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}