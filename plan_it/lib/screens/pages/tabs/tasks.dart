import 'package:flutter/material.dart';
import 'package:plan_it/theme/color.dart';
import 'package:plan_it/theme/text.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.scaffoldColor,
      body: Center(
          child: Text(
        'Tasks coming soon',
        style: TextDesign().containerHeader,
      )),
    );
  }
}
