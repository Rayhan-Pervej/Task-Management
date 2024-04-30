import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
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
  var tasksCompletedThisWeek = 0;
  var tasksCompletedThisMonth = 0;

  @override
  void initState() {
    super.initState();
    final user = auth.currentUser;
    final now = DateTime.now();
    final thisWeek = DateTime(now.year, now.month, now.day - now.weekday + 1);
    final thisMonth = DateTime(now.year, now.month);

    firebase
        .collection('tasks')
        .where('userId', isEqualTo: user!.uid)
        .where('createdTimestamp', isGreaterThanOrEqualTo: thisWeek)
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
        .where('createdTimestamp', isGreaterThanOrEqualTo: thisMonth)
        .where('createdTimestamp', isLessThanOrEqualTo: now)
        .get()
        .then((monthQuery) {
      setState(() {
        tasksAddedThisMonth = monthQuery.docs.length;
      });
    });

    firebase
        .collection('tasks')
        .where('userId', isEqualTo: user.uid)
        .where('completed', isEqualTo: true)
        .where('completedTimestamp', isGreaterThanOrEqualTo: thisWeek)
        .where('completedTimestamp', isLessThanOrEqualTo: now)
        .get()
        .then((weekCompletedQuery) {
      setState(() {
        tasksCompletedThisWeek = weekCompletedQuery.docs.length;
      });
    });

    firebase
        .collection('tasks')
        .where('userId', isEqualTo: user.uid)
        .where('completed', isEqualTo: true)
        .where('completedTimestamp', isGreaterThanOrEqualTo: thisMonth)
        .where('completedTimestamp', isLessThanOrEqualTo: now)
        .get()
        .then((monthCompletedQuery) {
      setState(() {
        tasksCompletedThisMonth = monthCompletedQuery.docs.length;
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
                margin: const EdgeInsets.only(top: 10, left: 50, right: 50),
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
                            fontSize: 20,
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
                                    fontSize: 20, color: MyColor.white),
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
                                    fontSize: 20, color: MyColor.white),
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
                            fontSize: 20,
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
                                    fontSize: 20, color: MyColor.white),
                              ),
                              Text(
                                '$tasksCompletedThisWeek',
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
                                    fontSize: 20, color: MyColor.white),
                              ),
                              Text(
                                '$tasksCompletedThisMonth',
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
              ),

              // Line Chart
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 8,
                  right: 12,
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: LineChart(
                    LineChartData(
                      minX: 0,
                      maxX: 11,
                      minY: 0,
                      maxY: 20,
                      titlesData: FlTitlesData(
                        leftTitles: SideTitles(showTitles: true),
                        bottomTitles: SideTitles(
                          showTitles: true,
                          getTitles: (value) {
                            switch (value.toInt()) {
                              case 0:
                                return 'Jan';
                              case 1:
                                return 'Feb';
                              case 2:
                                return 'Mar';
                              case 3:
                                return 'Apr';
                              case 4:
                                return 'May';
                              case 5:
                                return 'Jun';
                              case 6:
                                return 'Jul';
                              case 7:
                                return 'Aug';
                              case 8:
                                return 'Sep';
                              case 9:
                                return 'Oct';
                              case 10:
                                return 'Nov';
                              case 11:
                                return 'Dec';

                              // Add more months as needed
                              default:
                                return '';
                            }
                          },
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 0),
                            FlSpot(1, 0),
                            FlSpot(2, 0),
                            FlSpot(3, tasksAddedThisMonth.toDouble()),
                            FlSpot(4, tasksAddedThisMonth.toDouble()),
                            FlSpot(5, tasksAddedThisMonth.toDouble()),
                            FlSpot(6, tasksAddedThisMonth.toDouble()),
                            FlSpot(7, tasksAddedThisMonth.toDouble()),
                            FlSpot(8, tasksAddedThisMonth.toDouble()),
                            FlSpot(9, tasksAddedThisMonth.toDouble()),
                            FlSpot(10, tasksAddedThisMonth.toDouble()),
                            FlSpot(11, tasksAddedThisMonth.toDouble()),
                          ],
                          isCurved: false,
                          colors: [Colors.blue],
                          barWidth: 3,
                          isStrokeCapRound: false,
                          belowBarData: BarAreaData(show: false),
                        ),
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 0),
                            FlSpot(1, 0),
                            FlSpot(2, 0),
                            FlSpot(3, tasksCompletedThisMonth.toDouble()),
                            FlSpot(4, tasksCompletedThisMonth.toDouble()),
                            FlSpot(5, tasksCompletedThisMonth.toDouble()),
                            FlSpot(6, tasksCompletedThisMonth.toDouble()),
                            FlSpot(7, tasksCompletedThisMonth.toDouble()),
                            FlSpot(8, tasksCompletedThisMonth.toDouble()),
                            FlSpot(9, tasksCompletedThisMonth.toDouble()),
                            FlSpot(10, tasksCompletedThisMonth.toDouble()),
                            FlSpot(11, tasksCompletedThisMonth.toDouble()),
                          ],
                          isCurved: false,
                          colors: [Colors.green],
                          barWidth: 3,
                          isStrokeCapRound: true,
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
