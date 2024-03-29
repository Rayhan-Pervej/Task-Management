import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plan_it/components/box_widgets/text_box.dart';
import 'package:plan_it/theme/color.dart';
import 'package:plan_it/theme/text.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.scaffoldColor,
        body: ListView(
          padding: const EdgeInsets.only(top: 20),
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const SizedBox(
            //   height: 10,
            // ),
            Center(
              child: Stack(
                children: [
                  const SizedBox(
                    width: 150,
                    height: 150,
                    child: CircleAvatar(
                      backgroundColor: MyColor.green,
                      child: Icon(
                        FontAwesomeIcons.user, // FontAwesome icon
                        size: 60,
                        color: MyColor.white,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.penToSquare,
                        color: MyColor.buttonBlue,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            Center(
              child: Stack(
                children: [
                  Container(
                    width: 300,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColor.containerWhite,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextBox(textHeader: 'Name', textBody: 'Rayhan Pervej'),
                        TextBox(
                            textHeader: 'Address',
                            textBody: 'Bashundhara R/A, Dhaka'),
                        TextBox(
                            textHeader: 'Email',
                            textBody: 'rayhanp1011@gmail.com'),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: -7,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.penToSquare,
                        color: MyColor.buttonBlue,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
