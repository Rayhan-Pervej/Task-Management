import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../components/input_widgets/password_field.dart';
import '../../../services/utils/snackbar.dart';
import '../../../theme/color.dart';
import '../../../theme/text.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({super.key});

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final editPasswordController = TextEditingController();
  final editConfirmPasswordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final firebase = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();

  void changePassword(String password) async {
    User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updatePassword(password);
        
        if (mounted) {
          Navigator.of(context).pop();
          showSnackBar(
              context: context, message: "Your password Changed", error: false, height: 200);
        }
      
    } else{
      showSnackBar(context: context, message: 'user dont found', error: true,);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MyColor.scaffoldColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              FontAwesomeIcons.arrowLeft,
              color: MyColor.buttonBlue,
            ),
          ),
          backgroundColor: MyColor.appbarColor,
          centerTitle: true,
          title: Text(
            'Plan IT',
            style: TextDesign().pageTitle.copyWith(fontSize: 25),
          ),
        ),
        body: Column(
          children: [
            Center(
              heightFactor: 2,
              child: Text(
                'Change Password',
                style: TextDesign().containerHeader,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                // width: 300,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColor.containerWhite,
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          PasswordField(
                            password: editPasswordController,
                            backgroundColor: MyColor.fieldGray,
                            fieldLabel: 'Password',
                            hintText: 'Enter your password',
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          PasswordField(
                            password: editConfirmPasswordController,
                            backgroundColor: MyColor.fieldGray,
                            fieldLabel: 'Confirm Password',
                            hintText: 'Enter same password',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            String password = editPasswordController.text;
                            String confirmPassword =
                                editConfirmPasswordController.text;

                            if (password != confirmPassword) {
                              showSnackBar(
                                context: context,
                                message: "Password didn't match.",
                                error: true,
                                height: 120,
                              );
                            } else {
                              changePassword(password);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColor.buttonBlue,
                          foregroundColor: MyColor.white,
                          fixedSize:
                              Size(size.width * 0.35, size.height * 0.005),
                        ),
                        child: Text(
                          'Update',
                          style: TextDesign().buttonText.copyWith(fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
