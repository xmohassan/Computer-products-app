// ignore_for_file: prefer_const_constructors

import 'package:computer_products_app/pages/forgetPassword.dart';
import 'package:computer_products_app/pages/register.dart';
import 'package:computer_products_app/provider/googleSignIn.dart';
import 'package:computer_products_app/shared/colors.dart';
import 'package:computer_products_app/shared/constant.dart';
import 'package:computer_products_app/shared/snackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool isVisibale = false;
  bool isLoading = false;

  login() async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (!mounted) return;
      showSnackBar(context, "Done");
    } on FirebaseAuthException catch (error) {
      showSnackBar(context, "ERROR! : ${error.code}");
    }
    //stop indicator
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: bTNBlue,
          title: Text("Sign in"),
        ),
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(33.0),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 64,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                decoration: decorationTextField.copyWith(
                  hintText: "Enter Your Email :",
                  suffixIcon: const Icon(
                    Icons.person,
                    color: bTNBlue,
                  ),
                ),
                controller: emailController,
              ),
              const SizedBox(
                height: 22,
              ),
              TextField(
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
                controller: passwordController,
              ),
              const SizedBox(
                height: 22,
              ),
              ElevatedButton(
                onPressed: () async {
                  await login();
                  if (!mounted) return;
                  // showSnackBar(context, "Done.");
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(bTNBlue),
                  padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Sign in",
                        style: TextStyle(fontSize: 19),
                      ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgetPassword()));
                },
                child: Text(
                  "Forget password?",
                  style: TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      color: bTNBlue),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 107, 107, 107)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: bTNBlue),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 17,
              ),
              SizedBox(
                width: 299,
                child: Row(
                  children: const [
                    Expanded(
                        child: Divider(
                      thickness: 0.3,
                      color: bTNBlue,
                    )),
                    Text(
                      "OR",
                      style: TextStyle(
                        color: bTNBlue,
                      ),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 0.3,
                      color: bTNBlue,
                    )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 27),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        googleSignInProvider.googlelogin();
                      },
                      child: Container(
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: bTNBlue, width: 1)),
                        child: SvgPicture.asset(
                          "assets/icon/google.svg",
                          height: 27,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        )));
  }
}
