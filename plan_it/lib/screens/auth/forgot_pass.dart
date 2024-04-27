import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../services/utils/snackbar.dart';
import '../../../theme/color.dart';
import '../../../theme/text.dart';
import '../../components/input_widgets/input_field.dart';
import '../../services/utils/validators.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final firebase = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();

 Future sendEmail(String email) async{

   try{
      await auth.sendPasswordResetEmail(email: email);
      
      if(mounted){
        showSnackBar(context: context, message: "Check your email", error: false);
        Navigator.of(context).pop();
        
      }
    } on FirebaseException catch(e){
    if (mounted){
      showSnackBar(context: context, message: e.message.toString(), error: false);
      Navigator.of(context).pop();
    }
    
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
            'Plan It',
            style: TextDesign().pageTitle.copyWith(fontSize: 25),
          ),
        ),
        body: Column(
          children: [
            Center(
              heightFactor: 2,
              child: Text(
                'Enter Your Email',
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
                            controller: emailController,
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
                        onPressed: () async{
                          if (formKey.currentState!.validate()) {
                            
                          String email= emailController.text.trim();
                          sendEmail(email);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColor.buttonBlue,
                          foregroundColor: MyColor.white,
                          fixedSize:
                              Size(size.width * 0.35, size.height * 0.005),
                        ),
                        child: Text(
                          'Submit',
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
