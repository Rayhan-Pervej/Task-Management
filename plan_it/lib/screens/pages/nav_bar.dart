import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:plan_it/theme/color.dart';
import 'package:plan_it/theme/text.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int selectedIndex = 1;
  final pageViewController = PageController();

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
      // body: Expanded(
      //   child: PageView(
      //     controller: pageViewController,
      //     onPageChanged: (value) {
      //       setState(() {});
      //     },
      //     children: const [],
      //   ),
      // ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: const GNav(
            tabBorderRadius: 30,
            backgroundColor: MyColor.buttonWhite,
            color: MyColor.buttonBlue,
            activeColor: MyColor.buttonWhite,
            tabBackgroundColor: MyColor.buttonBlue,
            padding: EdgeInsets.all(20),
            tabs: [
              GButton(
                icon: FontAwesomeIcons.chartSimple,
                iconSize: 20,
              ),
              GButton(
                icon: FontAwesomeIcons.houseChimney,
                iconSize: 20,
              ),
              GButton(
                icon: FontAwesomeIcons.userLarge,
                iconSize: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
