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

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final formKey = GlobalKey<FormState>();
  final addTaskController = TextEditingController();
  final addDescriptionController = TextEditingController();
  late DateTime selectedDate = DateTime.now();
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');

  @override
  Widget build(BuildContext context) {
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
                  'Add Task',
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

                      tasks.add({
                        'userId': userId,
                        'name': taskName,
                        'description': description,
                        'deadline': selectedDate,
                        'completed': false,
                        'createdTimestamp': DateTime.now(),
                      }).then((value) {
                        showSnackBar(
                            context: context,
                            message: 'Your Task Added!',
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
                    fixedSize: Size(size.width * 0.25, size.height * 0.005),
                  ),
                  child: Text(
                    'Add',
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
