// ignore_for_file: prefer_const_constructors

import 'package:computer_products_app/pages/login.dart';
import 'package:computer_products_app/shared/colors.dart';
import 'package:computer_products_app/shared/constant.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 64,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: decorationTextField.copyWith(
                          hintText: "Enter username :"),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: decorationTextField.copyWith(
                          hintText: "Enter Your Email :"),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: decorationTextField.copyWith(
                          hintText: "Enter Your Password :"),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(bTNBlue),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                      ),
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
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
                          child: Text(
                            'Login',
                            style: TextStyle(color: bTNBlue),
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
