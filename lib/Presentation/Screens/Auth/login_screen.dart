import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_colors.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_images.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_strings.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Screens/AccountSetUp/im_looking_for_screen.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Screens/Auth/signup_screen.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Screens/Home/home_page_screen.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Widgets/button_style_widget.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Widgets/google_or_facebook_widget.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Widgets/textfromfield_box_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signIn(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    try {
      // Sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // If successful, navigate to home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePageScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = "";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found for this email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Wrong password. Please try again.";
      } else {
        errorMessage = "Sign-in failed: ${e.message}";
      }

      // Show error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final double lineSize = MediaQuery.of(context).size.width * 0.38;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Image.asset(
            AppImages.logofixitImg,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 36, left: 24, right: 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                AppStrings.enterEmailOr,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormFieldBoxUserWidget(
                controller: _emailController,
                hintText: AppStrings.enterEmail,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppStrings.pleaseEnterEmail;
                  }
                  return null;
                },
                prefixIcon: Icons.mail_rounded,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFromFieldBoxPassword(
                controller: _passwordController,
                hintText: AppStrings.enterPass,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppStrings.pleaseEnterPass;
                  }
                  return null;
                },
                prefixIcon: Icons.lock,
              ),
              const SizedBox(
                height: 8,
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  AppStrings.enterPass,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  _signIn(context);
                },
                child: const ButtonStyleWidget(
                  title: AppStrings.signIn,
                  colors: AppColors.blueColors,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
                child: const Text.rich(
                  TextSpan(
                    text: AppStrings.newTo,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text: AppStrings.signUpNow,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              GoogleOrFacebookWidget(
                title: AppStrings.signInWith,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
