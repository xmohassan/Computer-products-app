import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computer_products_app/pages/SignIn.dart';
import 'package:computer_products_app/shared/colors.dart';
import 'package:computer_products_app/shared/constant.dart';
import 'package:computer_products_app/shared/snackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename;

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  File? imgPath;
  String? imgName;
  bool isLoading = false;
  bool isVisibale = true;
  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final titleController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isPassword8Chars = false;
  bool isPasswordHas1Number = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;

  showModel() {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              padding: const EdgeInsets.all(22),
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      uploadImageToScreen(ImageSource.camera);
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.add_a_photo,
                          color: bTNBlue,
                          size: 30,
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text(
                          "From Camera",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: bTNBlue),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await uploadImageToScreen(ImageSource.gallery);
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.photo,
                          color: bTNBlue,
                          size: 30,
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("From Gallery",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: bTNBlue)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 22, color: bink),
                    ),
                  )
                ],
              ));
        });
  }

  uploadImageToScreen(ImageSource cameraOrGallery) async {
    final pickedImg = await ImagePicker().pickImage(source: cameraOrGallery);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
          print(imgName);
        });
      } else {
        print("NO image selected");
      }
    } catch (e) {
      print("Error => $e");
    }
    if (!mounted) return;
    Navigator.pop(context);
  }

  onPasswordChanged(String password) {
    isPassword8Chars = false;
    isPasswordHas1Number = false;
    hasUppercase = false;
    hasLowercase = false;
    hasSpecialCharacters = false;
    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        isPassword8Chars = true;
      }
      if (password.contains(RegExp(r'[0-9]'))) {
        isPasswordHas1Number = true;
      }

      if (password.contains(RegExp(r'[A-Z]'))) {
        hasUppercase = true;
      }

      if (password.contains(RegExp(r'[a-z]'))) {
        hasLowercase = true;
      }

      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        hasSpecialCharacters = true;
      }
    });
  }

  signUp() async {
    setState(() {
      isLoading = true;
    });

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Upload image to firebase storage
      final storageRef = FirebaseStorage.instance.ref("users-imgs/$imgName");
      await storageRef.putFile(imgPath!);

      // Get img url
      String url = await storageRef.getDownloadURL();

      // // Store img url in firestore[database]
      // CollectionReference userss =
      //     FirebaseFirestore.instance.collection('users');
      // userss.doc(credential!.user!.uid).set({
      //   "imgURL": url,
      // });

      // ignore: avoid_print
      print(credential.user!.uid);

      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      users
          .doc(credential.user!.uid)
          .set({
            'image': url,
            'username': usernameController.text,
            'age': ageController.text,
            "title": titleController.text,
            "email": emailController.text,
            "pass": passwordController.text,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        //print('The password provided is too weak.');
        if (!mounted) return;
        showSnackBar(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        //print('The account already exists for that email.');
        if (!mounted) return;
        showSnackBar(context, "The account already exists for that email.");
      } else {
        if (!mounted) return;
        showSnackBar(context, "ERORR - Please try again later.");
      }
    } catch (erorr) {
      if (!mounted) return;
      showSnackBar(context, erorr.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    ageController.dispose();
    titleController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
        elevation: 0,
        backgroundColor: bTNBlue,
      ),
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(33.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
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
                                uploadImageToScreen(ImageSource.gallery);
                                showModel();
                              },
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: bTNBlue,
                              )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  TextField(
                    controller: usernameController,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    decoration: decorationTextField.copyWith(
                      hintText: "Enter username :",
                      suffixIcon: const Icon(
                        Icons.person,
                        color: bTNBlue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  TextField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    decoration: decorationTextField.copyWith(
                      hintText: "Enter Your Age :",
                      suffixIcon: const Icon(
                        Icons.calendar_month,
                        color: bTNBlue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  TextField(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    decoration: decorationTextField.copyWith(
                      hintText: "Enter Your Title :",
                      suffixIcon: const Icon(
                        Icons.description,
                        color: bTNBlue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                    // we return "null" when something is valid
                    validator: (email) {
                      return email!.contains(RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                          ? null
                          : "Enter a valid email";
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    decoration: decorationTextField.copyWith(
                      hintText: "Enter Your Email :",
                      suffixIcon: const Icon(
                        Icons.email,
                        color: bTNBlue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                    onChanged: (password) {
                      onPasswordChanged(password);
                    },
                    // we return "null" when something is valid
                    validator: (value) {
                      return value!.length < 8
                          ? "Enter at least 8 characters"
                          : null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: isVisibale ? true : false,
                    decoration: decorationTextField.copyWith(
                      hintText: "Enter Your Password :",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisibale = !isVisibale;
                          });
                        },
                        icon: isVisibale
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        color: bTNBlue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isPassword8Chars ? Colors.green : Colors.white,
                          border: Border.all(
                              color: const Color.fromARGB(255, 189, 189, 189)),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      const Text("At least 8 characters"),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isPasswordHas1Number
                              ? Colors.green
                              : Colors.white,
                          border: Border.all(
                              color: const Color.fromARGB(255, 189, 189, 189)),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      const Text("At least 1 number"),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: hasUppercase ? Colors.green : Colors.white,
                          border: Border.all(
                              color: const Color.fromARGB(255, 189, 189, 189)),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      const Text("Has Uppercase"),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: hasLowercase ? Colors.green : Colors.white,
                          border: Border.all(
                              color: const Color.fromARGB(255, 189, 189, 189)),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      const Text("Has  Lowercase "),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: hasSpecialCharacters
                              ? Colors.green
                              : Colors.white,
                          border: Border.all(
                              color: const Color.fromARGB(255, 189, 189, 189)),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      const Text("Has  Special Characters "),
                    ],
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          imgName != null &&
                          imgPath != null) {
                        await signUp();
                        if (!context.mounted) return;
                        showSnackBar(context, "Account created.");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      } else {
                        showSnackBar(context, "Try again");
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(bTNBlue),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "SIGN UP",
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 107, 107, 107)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(color: bTNBlue),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
