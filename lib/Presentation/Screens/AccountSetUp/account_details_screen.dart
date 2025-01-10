import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_colors.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_images.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_strings.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_text_style.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Screens/AccountSetUp/how_to_case_screen.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Widgets/button_style_widget.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Widgets/textfromfield_widget.dart';

class AccountDetailScreen extends StatefulWidget {
  const AccountDetailScreen({super.key});

  @override
  State<AccountDetailScreen> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetailScreen> {
  TextEditingController _ownerControllerName = TextEditingController();
  TextEditingController _nicNumberController = TextEditingController();
  TextEditingController _phonenumberController = TextEditingController();
  TextEditingController _nicExpiryController = TextEditingController();

  void saveNameAndAddress() async {
    final ownerControllerName = _ownerControllerName.text.trim();
    final nicNumberController = _nicNumberController.text.trim();
    final phonenumberController = _phonenumberController.text.trim();
    final nicExpiryController = _nicExpiryController.text.trim();

    if (ownerControllerName.isEmpty ||
        nicNumberController.isEmpty ||
        phonenumberController.isEmpty ||
        nicExpiryController.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter payment details')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'owner name': ownerControllerName,
        'NID number': nicNumberController,
        'phone number': phonenumberController,
        'expiry date': nicExpiryController,
      }, SetOptions(merge: true));
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HowToCaseScreen()), // Replace with your next page
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Image.asset(
            AppImages.logofixitImg,
          ),
        ),
        actions: [
          Image.asset(
            AppImages.frame8Img,
          ),
          const SizedBox(
            width: 24,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 36, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppStrings.selectPaymentMethod,
              style: AppTextStyle.textStyle,
            ),
            const SizedBox(height: 20),
            TextFromFieldWidget(
              controller: _ownerControllerName,
              hintText: AppStrings.ownerName,
              colors: Colors.black,
            ),
            const SizedBox(height: 16),
            TextFromFieldWidget(
              controller: _nicNumberController,
              hintText: AppStrings.nICNumber,
              colors: Colors.black,
            ),
            const SizedBox(height: 16),
            TextFromFieldWidget(
              controller: _phonenumberController,
              hintText: AppStrings.phoneNumber,
              colors: Colors.black,
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.nICExpirydate,
              style: AppTextStyle.textStyle
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            TextFromFieldWidget(
              controller: _nicExpiryController,
              hintText: AppStrings.dateFormat,
              colors: Colors.black,
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                saveNameAndAddress();
              },
              child: const ButtonStyleWidget(
                title: AppStrings.next,
                colors: AppColors.blueColors,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
