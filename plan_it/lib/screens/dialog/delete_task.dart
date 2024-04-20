import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plan_it/theme/color.dart';
import 'package:plan_it/theme/text.dart';

import '../../services/utils/snackbar.dart';

class DeleteTask extends StatefulWidget {
  final String taskId;
  const DeleteTask({super.key, required this.taskId});

  @override
  State<DeleteTask> createState() => _DeleteTaskState();
}

class _DeleteTaskState extends State<DeleteTask> {
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');

  @override
  Widget build(BuildContext context) {
    //print('this is $selectedDate');
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      // title: Text(
      //   'Add Task',
      //   style: TextDesign().containerHeader,
      // ),
      contentPadding: EdgeInsetsDirectional.zero,
      content: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: MyColor.containerWhite,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Are you sure?',
                  style: TextDesign().containerHeader.copyWith(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        tasks.doc(widget.taskId).delete();
                        showSnackBar(
                          context: context,
                          message: 'Your Task Deleted',
                          error: false,
                          height: 180,
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColor.alertRed,
                        foregroundColor: MyColor.white,
                        fixedSize: Size(size.width * 0.25, size.height * 0.005),
                      ),
                      child: Text(
                        'Yes',
                        style: TextDesign().buttonText.copyWith(fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColor.buttonBlue,
                        foregroundColor: MyColor.white,
                        fixedSize: Size(size.width * 0.25, size.height * 0.005),
                      ),
                      child: Text(
                        'No',
                        style: TextDesign().buttonText.copyWith(fontSize: 16),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
