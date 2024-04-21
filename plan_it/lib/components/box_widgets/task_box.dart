import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plan_it/screens/dialog/delete_task.dart';
import 'package:plan_it/services/utils/snackbar.dart';
import 'package:plan_it/theme/color.dart';
import 'package:plan_it/theme/text.dart';

import '../../screens/dialog/edit_task.dart';

class TaskBox extends StatefulWidget {
  final String taskName;
  final String taskDescription;
  final bool completed;
  final DateTime createdTimestamp;
  final DateTime deadline;
  final String taskId;

  const TaskBox({
    super.key,
    required this.taskName,
    required this.taskDescription,
    required this.completed,
    required this.deadline,
    required this.createdTimestamp,
    required this.taskId,
  });

  @override
  State<TaskBox> createState() => _TaskBoxState();
}

class _TaskBoxState extends State<TaskBox> {
  // @override
  // void initState() {
  //   super.initState();
  //   completed = widget.completed;
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      color: widget.completed ? Color.fromARGB(197, 56, 56, 58) : MyColor.containerYellow,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Task Container
              Container(
                constraints: const BoxConstraints(minHeight: 110),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: 290,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.taskName,
                      style: TextDesign().taskName.copyWith(
                            color: widget.completed
                                ? MyColor.gray
                                : MyColor.headerBlack,
                          ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.taskDescription,
                      style: TextDesign().bodyText.copyWith(fontSize: 14, color: widget.completed
                                ? MyColor.gray
                                : MyColor.headerBlack,),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                        'Deadline: ${widget.deadline.day}/${widget.deadline.month}/${widget.deadline.year}',
                        style: TextDesign().bodyText.copyWith(
                            fontSize: 13, fontWeight: FontWeight.w600, color: widget.completed
                                ? MyColor.gray
                                : MyColor.headerBlack,)),
                  ],
                ),
              ),
            ],
          ),

          // tasks button
          Positioned(
            top: -3,
            right: 0,
            child: Column(
              children: [
                Checkbox(
                  checkColor: widget.completed ?  Color.fromARGB(255, 99, 99, 99) : MyColor.buttonWhite,
                  activeColor: widget.completed ? Color.fromARGB(255, 22, 24, 68) :MyColor.buttonBlue,
                  value: widget.completed,
                  onChanged: (bool? value) {
                    if (value != null) {
                      FirebaseFirestore.instance
                          .collection('tasks')
                          .doc(widget.taskId)
                          .update({'completed': value});
                      if (value == true) {
                        showSnackBar(
                            context: context,
                            message: 'congratulations!',
                            error: false,
                            height: 160);
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 2,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EditTaskForm(
                            taskId: widget.taskId, deadline: widget.deadline);
                      },
                    );
                  },
                  child: Icon(
                    FontAwesomeIcons.pen,
                    size: 18,
                    color: widget.completed
                                ? MyColor.gray
                                : MyColor.headerBlack,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DeleteTask(taskId: widget.taskId);
                      },
                    );
                  },
                  child:  Icon(
                    FontAwesomeIcons.trash,
                    size: 18,
                     color: widget.completed
                                ? MyColor.gray
                                : MyColor.headerBlack,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
