import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_images.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_strings.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Screens/AccountSetUp/im_looking_for_screen.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Screens/Home/home_page_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleOrFacebookWidget extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }

      //Google authentication details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential for Firebase
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          // Navigate to next page for new users
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ImLookingForScreen()),
          );
        } else {
          // Navigate to home page for existing users
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePageScreen()),
          );
        }
      }
    } catch (e) {
      print("Error during Google sign-in: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed: $e')),
      );
    }
  }

  final String title;
   GoogleOrFacebookWidget({
    super.key,
    required this.title,
  });


  

  @override
  Widget build(BuildContext context) {
    final double lineSize = MediaQuery.of(context).size.width * 0.38;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: lineSize,
              child: const Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey,
              ),
            ),
            const Text(
              "or",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              width: lineSize,
              child: const Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => _signInWithGoogle(context),
              child: gfBox(
                AppStrings.google,
                AppImages.googleImg,
              ),
            ),
            gfBox(
              AppStrings.facebook,
              AppImages.facebookImg,
            ),
          ],
        ),
      ],
    );
  }

  Widget gfBox(String title, String img) {
    return Container(
      width: 160,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(img),
          const SizedBox(
            width: 12,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
