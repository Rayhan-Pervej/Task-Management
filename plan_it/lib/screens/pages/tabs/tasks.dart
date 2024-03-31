import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plan_it/components/box_widgets/task_box.dart';
import 'package:plan_it/screens/dialog/add_task.dart';
import 'package:plan_it/theme/color.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late User user;
  List<Map<String, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    user = auth.currentUser!;
    fetchTasks();
  }

void fetchTasks() {
  firestore
      .collection('tasks')
      .where('userId', isEqualTo: user.uid)
      .snapshots()
      .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Map<String, dynamic>> updatedTasks =
        snapshot.docs.map((doc) {
          // Accessing document ID (taskId) from the document snapshot
          String taskId = doc.id;
          // Merging document ID with task data
          Map<String, dynamic> taskData = doc.data();
          taskData['taskId'] = taskId;
          return taskData;
        }).toList();
    updatedTasks.sort((a, b) =>
        (a['deadline'] as Timestamp).compareTo(b['deadline'] as Timestamp));
    setState(() {
      tasks = updatedTasks;
    });
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.scaffoldColor,
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return TaskBox(
            taskName: task['name'],
            taskDescription: task['description'],
            completed: task['completed'],
            createdTimestamp: task['createdTimestamp']?.toDate(),
            deadline: task['deadline']?.toDate(),
            taskId: task['taskId'],
           
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddTaskForm();
            },
          );
        },
        backgroundColor: MyColor.buttonBlue,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: const Icon(
          FontAwesomeIcons.plus,
          color: MyColor.white,
          size: 30,
        ),
      ),
    );
  }
}
