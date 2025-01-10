import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_colors.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_images.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_strings.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_text_style.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Screens/AccountSetUp/about_service_screen.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Widgets/button_style_widget.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Widgets/textfromfield_widget.dart';

class LocationDetailScreen extends StatefulWidget {
  const LocationDetailScreen({super.key});

  @override
  State<LocationDetailScreen> createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetailScreen> {
  TextEditingController _businessName = TextEditingController();
  TextEditingController _businessAddress = TextEditingController();

  void saveNameAndAddress() async {
    final businessName = _businessName.text.trim();
    final businessAddress = _businessAddress.text.trim();

    if (businessName.isEmpty && businessAddress.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter name and address')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'business name': businessName,
        'business address': businessAddress,
      }, SetOptions(merge: true));
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AboutServiceScreen()), // Replace with your next page
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
            AppImages.frame4Img,
          ),
          const SizedBox(
            width: 24,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 36, left: 24, right: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                AppStrings.allow,
                style: AppTextStyle.textStyle,
              ),
              const SizedBox(
                height: 6,
              ),
              const Text(
                AppStrings.weSend,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 165,
                width: double.infinity,
                child: Image.asset(
                  AppImages.livelocationImg,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 84,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.location_pin,
                    ),
                    Expanded(
                      child: Text(
                        AppStrings.address,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFromFieldWidget(
                controller: _businessName,
                hintText: AppStrings.businessName,
                colors: Colors.black,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFromFieldWidget(
                controller: _businessAddress,
                hintText: AppStrings.businessAddress,
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
      ),
    );
  }
}
