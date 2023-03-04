import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../../core/utils/colors/app_colors.dart';
import 'home_screen.dart';
import 'widget/bottom_nav_bar_item.dart';
import 'widget/customized_app_bar.dart';

class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  static const List<Widget> pages = [
    HomeScreen()
  ];

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: const CustomizedAppBar(),
        extendBodyBehindAppBar: true,
        floatingActionButton: FloatingActionButton(
          elevation: 5.0,
          backgroundColor: AppColors.yellowPrimary,
          onPressed: () => setState(() => index = 1),
          child: const Icon(
            Icons.home,
            size: 36.0,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: buildBottomNavigationBar(),
        resizeToAvoidBottomInset: false,
        body: pages[index],
      ),
    );
  }

  Widget buildBottomNavigationBar() {

    return SimpleShadow(
      opacity: 0.5,
      sigma: 5.0,
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 5.0,
        notchMargin: 8.0,
        child: SizedBox(
          height: 60.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomNavBarItem(
                icon: Icons.home_filled,
                onTap: () => setState(() => index = 0),
                borderSide: index == 0 ? BorderSide(
                  color: AppColors.greenSecondary,
                  width: 3.5,
                ) : BorderSide.none,
              ),
              BottomNavBarItem(
                icon: Icons.person,
                onTap: () => setState(() => index = 2),
                borderSide: index == 2 ? BorderSide(
                  color: AppColors.greenSecondary,
                  width: 3.5,
                ) : BorderSide.none,
              ),
            ],
          ),
        ),
      ),
    );
  }
}