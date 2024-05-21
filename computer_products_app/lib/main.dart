import 'package:computer_products_app/firebase_options.dart';
import 'package:computer_products_app/model/products.dart';
import 'package:computer_products_app/pages/VeryfyEmail.dart';
import 'package:computer_products_app/pages/detailsScreen.dart';
import 'package:computer_products_app/pages/home.dart';
import 'package:computer_products_app/pages/SignIn.dart';
import 'package:computer_products_app/pages/register.dart';
import 'package:computer_products_app/pages/splash_screen.dart';
import 'package:computer_products_app/provider/cart.dart';
import 'package:computer_products_app/provider/googleSignIn.dart';
import 'package:computer_products_app/shared/snackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return Cart();
        }),
        ChangeNotifierProvider(create: (context) {
          return GoogleSignInProvider();
        }),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(useMaterial3: false),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              } else if (snapshot.hasError) {
                return showSnackBar(context, "Something went wrong");
              } else if (snapshot.hasData) {
                return const Home(); // home() OR verify email
              } else {
                return const Login();
              }
            },
          )),
    );
  }
}
