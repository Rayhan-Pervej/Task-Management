import 'package:flutter/material.dart';
import 'package:plan_it/screens/auth/login.dart';
import 'package:plan_it/services/utils/validators.dart';
import 'package:plan_it/theme/color.dart';
import 'package:plan_it/theme/text.dart';
import 'package:plan_it/widgets/input_widgets/input_field.dart';

import '../../widgets/input_widgets/password_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MyColor.scaffoldColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Plan IT',
                      style: TextDesign().headerLarge,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: MyColor.containerWhite,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(13),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            InputField(
                              controller: firstNameController,
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
                              controller: lastNameController,
                              fieldLabel: "Last Name",
                              backgroundColor: MyColor.fieldGray,
                              hintText: 'Enter your Last name',
                              validation: true,
                              errorMessage: "",
                              validatorClass: ValidatorClass().validateUserName,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            InputField(
                              controller: emailController,
                              fieldLabel: "Email",
                              backgroundColor: MyColor.fieldGray,
                              hintText: 'Enter your email',
                              validation: true,
                              errorMessage: "",
                              validatorClass: ValidatorClass().validateEmail,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            PasswordField(
                              password: passwordController,
                              backgroundColor: MyColor.fieldGray,
                              fieldLabel: 'Password',
                              hintText: 'Enter your password',
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PasswordField(
                              password: confirmPasswordController,
                              backgroundColor: MyColor.fieldGray,
                              fieldLabel: 'Confirm Password',
                              hintText: 'Enter same password',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (formKey.currentState!.validate()) {}
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyColor.buttonBlue,
                                foregroundColor: MyColor.white,
                                fixedSize:
                                    Size(size.width * 0.5, size.height * 0.05),
                              ),
                              child: Text(
                                'Submit',
                                style: TextDesign().buttonText,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: TextDesign().bodyText.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Login()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(
                                      'Login!',
                                      style: TextDesign().buttonText.copyWith(
                                          fontSize: 14,
                                          color: MyColor.blue,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
