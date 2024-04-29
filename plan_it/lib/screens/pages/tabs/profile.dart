import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plan_it/components/box_widgets/text_box.dart';
import 'package:plan_it/screens/pages/tabs/edit_password.dart';
import 'package:plan_it/screens/pages/tabs/edit_profile.dart';
import 'package:plan_it/theme/color.dart';
import 'package:random_avatar/random_avatar.dart';
import '../../../theme/text.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final auth = FirebaseAuth.instance;
  final firebase = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  String firstName = '';
  String lastName = '';
  String email = '';
  String address = '';
  String? imageUrl;

  // @override
  // void initState() {
  //   fetchUserData();
  //   super.initState();
  // }

  // Future<void> fetchUserData() async {
  //   final userData =
  //       await firebase.collection('users').doc(auth.currentUser!.uid).get();
  //   if (userData.exists) {
  //     setState(() {
  //       firstName = userData['firstName'];
  //       lastName = userData['lastName'];
  //       email = userData['email'];
  //       address = userData['address'] ?? 'No address given';
  //     });
  //   }
  // }

  //Below code is for real time data reading without any statechange or anything.

  Stream<DocumentSnapshot> userDataStream() {
    return firebase.collection('users').doc(auth.currentUser!.uid).snapshots();
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
    // userDataStream().listen((DocumentSnapshot userData) {
    //   if (userData.exists) {
    //     setState(() {
    //       firstName = userData['firstName'] ?? '';
    //       lastName = userData['lastName'] ?? '';
    //       email = userData['email'] ?? '';
    //       address = userData['address'] ?? '';
    //       if (address.isEmpty) {
    //         address = 'Add your address';
    //       }
    //     });
    //   }
    // });
  }

  Future<void> fetchUserData() async {
    final userData =
        await firebase.collection('users').doc(auth.currentUser!.uid).get();
    if (userData.exists) {
      setState(() {
        firstName = userData['firstName'] ?? '';
        lastName = userData['lastName'] ?? '';
        email = userData['email'] ?? '';
        address = userData['address'] ?? '';
        if (address.isEmpty) {
          address = 'Add your address';
        }
      });
    }

    // Fetch the image URL and update state
    imageUrl = await getImageUrl();
    setState(() {});
  }

  Future<String?> getImageUrl() async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('profile_images/${auth.currentUser!.uid}.jpg');
    final url = await ref.getDownloadURL();
    return url;

    // Handle error, such as image not found
    //print('Error fetching image: $e');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColor.scaffoldColor,
        body: ListView(
          padding: const EdgeInsets.only(top: 20),
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const SizedBox(
            //   height: 10,
            // ),
            Center(
              child: Stack(
                children: [
                  SizedBox(
                    child: imageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(75),
                            child: Image.network(
                              imageUrl!,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.medium,
                            ),
                          )
                        : RandomAvatar(
                            "129",
                            trBackground: false,
                            width: 150,
                            height: 150,
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () async {
                        final imagePicker = ImagePicker();
                        final pickedFile = await imagePicker.pickImage(
                            source: ImageSource.gallery, imageQuality: 75);
                        if (pickedFile != null) {
                          final firebaseStorageRef = firebaseStorage
                              .ref()
                              .child('profile_images')
                              .child('${auth.currentUser!.uid}.jpg');

                          await firebaseStorageRef
                              .putFile(File(pickedFile.path));
                        } else {}
                      },
                      icon: const Icon(
                        FontAwesomeIcons.penToSquare,
                        color: MyColor.buttonBlue,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            Center(
              child: Stack(
                children: [
                  Container(
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
                        TextBox(
                            textHeader: 'Name',
                            textBody: '$firstName $lastName'),
                        TextBox(textHeader: 'Address', textBody: address),
                        TextBox(textHeader: 'Email', textBody: email),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: -7,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditProfile()));
                      },
                      icon: const Icon(
                        FontAwesomeIcons.penToSquare,
                        color: MyColor.buttonBlue,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditPassword()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      'Tap To Change Your Password',
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
        ));
  }
}
