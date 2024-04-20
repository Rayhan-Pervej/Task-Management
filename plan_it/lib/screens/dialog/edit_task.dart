import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plan_it/services/utils/snackbar.dart';
import 'package:plan_it/services/utils/validators.dart';
import 'package:plan_it/theme/color.dart';
import 'package:plan_it/theme/text.dart';
import 'package:plan_it/components/input_widgets/date_picker.dart';
import 'package:plan_it/components/input_widgets/input_field.dart';
import 'package:plan_it/components/input_widgets/multi_line_input_field.dart';

class EditTaskForm extends StatefulWidget {
  final String taskId;
  final DateTime deadline;
  const EditTaskForm({super.key, required this.taskId, required this.deadline});

  @override
  State<EditTaskForm> createState() => _EditTaskFormState();
}

class _EditTaskFormState extends State<EditTaskForm> {
  final formKey = GlobalKey<FormState>();
  final addTaskController = TextEditingController();
  final addDescriptionController = TextEditingController();
late DateTime selectedDate =DateTime.now() ;
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');

  @override
  void initState() {
    super.initState();
    fetchTaskData();
    
  }

  //fetching data

  void fetchTaskData() {
    tasks.doc(widget.taskId).get().then((DocumentSnapshot taskSnapshot) {
      if (taskSnapshot.exists) {
        setState(() {
          addTaskController.text = taskSnapshot['name'] ?? '';
          addDescriptionController.text = taskSnapshot['description'] ?? '';
          selectedDate = (taskSnapshot['deadline'] as Timestamp).toDate();
        });
        
      }
    }).catchError((error) {
      //print('Error fetching task data: $error');
    });
  }

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
                  'Update Task',
                  style: TextDesign().containerHeader,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputField(
                        controller: addTaskController,
                        fieldLabel: 'Task',
                        backgroundColor: MyColor.fieldGray,
                        hintText: 'Add task name',
                        validation: true,
                        errorMessage: "Enter the Task",
                        validatorClass: ValidatorClass().validatorTaskName,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      MultiLineInputfield(
                        controller: addDescriptionController,
                        fieldLabel: 'Description',
                        backgroundColor: MyColor.fieldGray,
                        hintText: 'Enter description',
                        validation: false,
                        errorMessage: '',
                        numberOfLines: 5,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      
                      DateTimePicker(
                        initialDate: selectedDate,
                        onDateSelected: (DateTime newSelectedDate) {
                          setState(() {
                            selectedDate = newSelectedDate;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 4,
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      String taskName = addTaskController.text.trim();
                      String description = addDescriptionController.text.trim();
                      String userId = user!.uid;

                  tasks.doc(widget.taskId).update({
                        'userId': userId,
                        'name': taskName,
                        'description': description,
                        'deadline': selectedDate,
                        'completed': false,
                        'createdTimestamp': DateTime.now(),
                      }).then((value) {
                        showSnackBar(
                            context: context,
                            message: 'Your Task Updated!',
                            error: false,
                            height: 200);
                        Navigator.pop(context);
                      }).catchError((error) {
                        showSnackBar(
                            context: context,
                            message: "Something went wrong",
                            error: true);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.buttonBlue,
                    foregroundColor: MyColor.white,
                    fixedSize: Size(size.width * 0.35, size.height * 0.005),
                  ),
                  child: Text(
                    'Update',
                    style: TextDesign().buttonText.copyWith(fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
