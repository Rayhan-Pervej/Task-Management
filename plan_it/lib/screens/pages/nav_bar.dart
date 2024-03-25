import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:plan_it/screens/pages/tabs/profile.dart';
import 'package:plan_it/screens/pages/tabs/progress.dart';
import 'package:plan_it/screens/pages/tabs/tasks.dart';
import 'package:plan_it/theme/color.dart';
import 'package:plan_it/theme/text.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int selectedIndex = 1;
  final pageViewController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.scaffoldColor,
      appBar: AppBar(
        title: Text(
          'Plan IT',
          style: TextDesign().pageTitle.copyWith(fontSize: 25),
        ),
        backgroundColor: MyColor.appbarColor,
      ),
      body: PageView(
        controller: pageViewController,
        onPageChanged: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        children: const [
          Progress(),
          Tasks(),
          Profile(),
        ],
      ),
      bottomNavigationBar: Container(
        color: MyColor.appbarColor,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 4, left: 20, right: 20, bottom: 4),
          child: GNav(
            haptic: true,
            gap: 8,
            tabBorderRadius: 30,
            backgroundColor: MyColor.white,
            color: MyColor.buttonBlue,
            activeColor: MyColor.buttonWhite,
            tabBackgroundColor: MyColor.buttonBlue,
            padding: const EdgeInsets.all(20),
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                pageViewController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.ease,
                );
                selectedIndex = index;
              });
            },
            tabs: const [
              GButton(
                icon: FontAwesomeIcons.chartSimple,
                iconSize: 20,
                text: 'Status',
              ),
              GButton(
                icon: FontAwesomeIcons.houseChimney,
                iconSize: 20,
                text: 'Home',
              ),
              GButton(
                icon: FontAwesomeIcons.userLarge,
                iconSize: 20,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
