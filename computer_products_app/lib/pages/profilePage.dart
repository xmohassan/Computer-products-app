import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computer_products_app/shared/colors.dart';
import 'package:computer_products_app/shared/dataFromFireStore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

File? imgPath;
final credential = FirebaseAuth.instance.currentUser!;

class _ProfilePageState extends State<ProfilePage> {
  uploadImageToScreen() async {
    final pickedImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
        });
      } else {
        print("NO image selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          TextButton.icon(
            label: const Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!mounted) return;
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: bTNBlue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: bluee,
                  ),
                  child: Stack(
                    children: [
                      imgPath == null
                          ? const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 64,
                              backgroundImage:
                                  AssetImage("assets/image/avatar.webp"),
                            )
                          : ClipOval(
                              child: Image.file(
                                imgPath!,
                                width: 145,
                                height: 145,
                                fit: BoxFit.cover,
                              ),
                            ),
                      Positioned(
                        bottom: -10,
                        left: 90,
                        child: IconButton(
                            onPressed: () {
                              uploadImageToScreen();
                            },
                            icon: const Icon(
                              Icons.add_a_photo,
                              color: bTNBlue,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: bTNBlue, borderRadius: BorderRadius.circular(11)),
                  child: const Text(
                    "Info from firebase Auth",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    "Email: ${credential.email}",
                    style: const TextStyle(color: bTNBlue, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    // DateFormat("MMMM d, y").format(credential.metadata.creationTime);
                    "Created date: ${DateFormat("MMMM d, y").format(credential!.metadata.creationTime!)}",
                    style: const TextStyle(color: bTNBlue, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    "Last sign in: ${DateFormat("MMMM d, y").format(credential!.metadata.lastSignInTime!)}",
                    style: const TextStyle(color: bTNBlue, fontSize: 18),
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          CollectionReference users =
                              FirebaseFirestore.instance.collection('users');
                          setState(() {
                            credential.delete();
                            users.doc(credential!.uid).delete();
                            Navigator.pop(context);
                          });
                        },
                        child: const Text(
                          "Delete user",
                          style: TextStyle(
                              fontSize: 18,
                              color: bink,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                          color: bTNBlue,
                          borderRadius: BorderRadius.circular(11)),
                      child: const Text(
                        "Info from firebase firestore",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GetDataFromFireStore(
                    documentId: credential.uid,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
