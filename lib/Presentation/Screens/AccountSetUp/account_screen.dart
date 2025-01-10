import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_colors.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_images.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_strings.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Screens/AccountSetUp/account_details_screen.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Widgets/button_style_widget.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Widgets/payment_method_option_widget.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Widgets/selected_payment_method_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreensState();
}

class _AccountScreensState extends State<AccountScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String selectedType = "";

  Future<void> saveAccountType(String payment) async {
    try {
      selectedType = payment;

      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({'Payment Method': payment}, SetOptions(merge: true));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AccountDetailScreen()),
      );

      // Get.snackbar('Success', 'Account type saved successfully!');
    } catch (e) {
      if (selectedType!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select an option')),
        );
        return;
      }
    }
  }

  String _selectedPaymentMethod = AppStrings.easyPaisa;
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
            AppImages.frame7Img,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.selectPaymentMethod,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 12),
                PaymentMethodOptionWidget(
                  title: AppStrings.easyPaisa,
                  imageUrl: AppImages.easypaisaImg,
                  isSelected: _selectedPaymentMethod == AppStrings.easyPaisa,
                  onTap: () {
                    setState(() {
                      selectedType = "BKash";
                      _selectedPaymentMethod = AppStrings.easyPaisa;
                    });
                  },
                ),
                PaymentMethodOptionWidget(
                  title: AppStrings.bankAccount,
                  imageUrl: AppImages.bankAccountImg,
                  isSelected: _selectedPaymentMethod == AppStrings.bankAccount,
                  onTap: () {
                    setState(() {
                      selectedType = "Bank Account";
                      _selectedPaymentMethod = AppStrings.bankAccount;
                    });
                  },
                ),
                PaymentMethodOptionWidget(
                  title: AppStrings.jazzCash,
                  imageUrl: AppImages.jazzcashImg,
                  isSelected: _selectedPaymentMethod == AppStrings.jazzCash,
                  onTap: () {
                    setState(() {
                      selectedType = "Nagad";
                      _selectedPaymentMethod = AppStrings.jazzCash;
                    });
                  },
                ),
                PaymentMethodOptionWidget(
                  title: AppStrings.payPal,
                  imageUrl: AppImages.paypalImg,
                  isSelected: _selectedPaymentMethod == AppStrings.payPal,
                  onTap: () {
                    setState(() {
                      selectedType = "PayPal";
                      _selectedPaymentMethod = AppStrings.payPal;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 54,
            ),
            InkWell(
              onTap: () {
                saveAccountType(selectedType);
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
