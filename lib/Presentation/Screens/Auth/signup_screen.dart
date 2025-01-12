import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_colors.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_images.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_strings.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Screens/AccountSetUp/im_looking_for_screen.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Widgets/button_style_widget.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Widgets/google_or_facebook_widget.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Widgets/signup_checkbox_widget.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Widgets/textfromfield_box_widget.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
   const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final nameController = TextEditingController();
  // final emailController = TextEditingController();
  // final passwordController = TextEditingController();

  Future<void> _signup(BuildContext context) async {
    String name = nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    try {
      // Check if the email is already registered
      final query = await FirebaseFirestore.instance
    .collection('users')
    .where('email', isEqualTo: email)
    .get();
      if (query.docs.isNotEmpty) {
        // Email is already registered
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Email Already Exists"),
            content:
                Text("This email is already registered. Please try another."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("OK"),
              ),
            ],
          ),
        );
        return;
      }

      // Create a new user
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user details to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'createdAt': DateTime.now(),
        'name': name,
        'email': email,
      });

      // Navigate to the next page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ImLookingForScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signup failed: $e")),
      );
    }
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
                style: TextStyle(fontSize: 24, color: Colors.grey),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormFieldBoxUserWidget(
                controller: nameController,
                hintText: AppStrings.fullName,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppStrings.pleaseEnterName;
                  }
                  return null;
                },
                prefixIcon: Icons.person,
              ),
              const SizedBox(
                height: 16,
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
              const SignupCheckBoxWidget(),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  print("signup");
                  _signup(context);
                },
                child: const ButtonStyleWidget(
                  title: AppStrings.signUp,
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
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text.rich(
                  TextSpan(
                    text: AppStrings.alreadyAccount,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text: AppStrings.signInNow,
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
                title: AppStrings.signUpWith,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
