import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../components/input_widgets/input_field.dart';
import '../../../services/utils/snackbar.dart';
import '../../../services/utils/validators.dart';
import '../../../theme/color.dart';
import '../../../theme/text.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final editFirstNameController = TextEditingController();
  final editLastNameController = TextEditingController();
  final editEmailController = TextEditingController();
  final editAddressController = TextEditingController();
  final editPasswordController = TextEditingController();
  final editConfirmPasswordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final firebase = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() {
    firebase
        .collection('users')
        .doc(auth.currentUser!.uid)
        .snapshots()
        .listen((DocumentSnapshot userData) {
      if (userData.exists) {
        editFirstNameController.text = userData['firstName'];
        editLastNameController.text = userData['lastName'];
        editAddressController.text = userData['address'] ?? '';
        editEmailController.text = userData['email'];
      }
    });
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
        body: ListView(
          padding: const EdgeInsets.only(top: 20),
          children: [
            Center(
              child: Text(
                'Edit Profile',
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
                          InputField(
                            controller: editFirstNameController,
                            fieldLabel: "First Name",
                            backgroundColor: MyColor.fieldGray,
                            hintText: 'Enter your first name',
                            validation: true,
                            errorMessage: "",
                            validatorClass: ValidatorClass().validateUserName,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          InputField(
                            controller: editLastNameController,
                            fieldLabel: "Last Name",
                            backgroundColor: MyColor.fieldGray,
                            hintText: 'Enter your last name',
                            validation: true,
                            errorMessage: "",
                            validatorClass: ValidatorClass().validateUserName,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          InputField(
                            controller: editAddressController,
                            fieldLabel: "Address",
                            backgroundColor: MyColor.fieldGray,
                            hintText: 'Enter your address',
                            validation: false,
                            errorMessage: "",
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          InputField(
                            controller: editEmailController,
                            fieldLabel: "Email",
                            backgroundColor: MyColor.fieldGray,
                            hintText: 'Enter your email',
                            validation: true,
                            errorMessage: "",
                            validatorClass: ValidatorClass().validateEmail,
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
                            Map<String, dynamic> userData = {
                              'firstName': editFirstNameController.text.trim(),
                              'lastName': editLastNameController.text.trim(),
                              'email': editEmailController.text.trim(),
                              'address': editAddressController.text.trim(),
                              // Add more fields if needed
                            };

                            firebase
                                .collection('users')
                                .doc(auth.currentUser!.uid)
                                .update(userData)
                                .then((_) {
                              // If update successful, show success message and close the page
                              showSnackBar(
                                context: context,
                                message: 'Your profile Updated!',
                                error: false,
                                height: 180,
                              );
                              Navigator.of(context).pop();
                            }).catchError((error) {
                              // If any error occurs during update, show error message
                              showSnackBar(
                                context: context,
                                message: "Something went wrong",
                                error: true,
                              );
                            });
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
