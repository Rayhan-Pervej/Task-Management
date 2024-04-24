import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plan_it/theme/color.dart';
import 'package:plan_it/theme/text.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  final auth = FirebaseAuth.instance;
  final firebase = FirebaseFirestore.instance;

  var tasksAddedThisWeek = 0;
  var tasksAddedThisMonth = 0;

  @override
  void initState() {
    super.initState();
    final user = auth.currentUser;
    final now = DateTime.now();
    final startOfWeek =
        DateTime(now.year, now.month, now.day - now.weekday + 1);
    final startOfMonth = DateTime(now.year, now.month);

    firebase
        .collection('tasks')
        .where('userId', isEqualTo: user!.uid)
        .where('createdTimestamp', isGreaterThanOrEqualTo: startOfWeek)
        .where('createdTimestamp', isLessThanOrEqualTo: now)
        .get()
        .then((weekQuery) {
      setState(() {
        tasksAddedThisWeek = weekQuery.docs.length;
      });
    });

    firebase
        .collection('tasks')
        .where('userId', isEqualTo: user.uid)
        .where('createdTimestamp', isGreaterThanOrEqualTo: startOfMonth)
        .where('createdTimestamp', isLessThanOrEqualTo: now)
        .get()
        .then((monthQuery) {
      setState(() {
        tasksAddedThisMonth = monthQuery.docs.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.scaffoldColor,
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColor.containerWhite,
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        'Task Added',
                        style: TextDesign().header.copyWith(
                              fontSize: 25,
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColor.containerBlue,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Week',
                                  style: TextDesign().header.copyWith(
                                      fontSize: 25, color: MyColor.white),
                                ),
                                Text(
                                  '$tasksAddedThisWeek',
                                  style: TextDesign().header.copyWith(
                                      fontSize: 50, color: MyColor.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColor.containerBlue,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Month',
                                  style: TextDesign().header.copyWith(
                                      fontSize: 25, color: MyColor.white),
                                ),
                                Text(
                                  '$tasksAddedThisMonth',
                                  style: TextDesign().header.copyWith(
                                      fontSize: 50, color: MyColor.white),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Task Completed',
                        style: TextDesign().header.copyWith(
                              fontSize: 25,
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColor.containerGreen,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Week',
                                  style: TextDesign().header.copyWith(
                                      fontSize: 25, color: MyColor.white),
                                ),
                                Text(
                                  '$tasksAddedThisWeek',
                                  style: TextDesign().header.copyWith(
                                      fontSize: 50, color: MyColor.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColor.containerGreen,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Month',
                                  style: TextDesign().header.copyWith(
                                      fontSize: 25, color: MyColor.white),
                                ),
                                Text(
                                  '$tasksAddedThisMonth',
                                  style: TextDesign().header.copyWith(
                                      fontSize: 50, color: MyColor.white),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }
}
