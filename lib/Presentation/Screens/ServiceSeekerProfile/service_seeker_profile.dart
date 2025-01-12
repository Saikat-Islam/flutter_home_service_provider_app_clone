import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_colors.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_images.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_strings.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_text_style.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Screens/ServiceSeekerProfile/edit_profile_seeker_screen.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Screens/ServiceSeekerProfile/help_support_screen.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Screens/ServiceSeekerProfile/notification_screen.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Screens/ServiceSeekerProfile/payment_method_profile.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Screens/Splash/splash_screen.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Widgets/button_style_widget.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Widgets/profile_card_edit_widget.dart';

class ServiceSeekerProfileScreen extends StatefulWidget {
  const ServiceSeekerProfileScreen({super.key});

  @override
  State<ServiceSeekerProfileScreen> createState() =>
      _ServiceSeekerProfileState();
}

class _ServiceSeekerProfileState extends State<ServiceSeekerProfileScreen> {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //if ologout button tapped...
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/icons/logoutpop.png",
              height: 80,
              width: 80,
            ),
            const SizedBox(height: 7),
            Text(
              AppStrings.logout,
              style: AppTextStyle.textStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              AppStrings.confirmlogout,
              style: AppTextStyle.textStyle.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
                );
              },
              child: const ButtonStyleWidget(
                title: AppStrings.logout,
                colors: AppColors.blueColors,
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  AppStrings.cancel,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.myProfile,
          style: TextStyle(
            color: AppColors.blueColors,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Image.asset(
            AppImages.logofixitImg,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
          children: [
            Container(
              height: 96,
              width: 96,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48),
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
                image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    AppImages.kalpeshImg,
                  ),
                ),
              ),
            ),
            ShowUserName(userId: uid),
            ProfileCardEditWidget(
                title: AppStrings.editProifle,
                image: AppImages.editeprofileImg,
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileSeekerScreen(),
                    ),
                  );
                }),
            ProfileCardEditWidget(
                title: AppStrings.notification,
                image: AppImages.notificationImg,
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ));
                }),
            ProfileCardEditWidget(
                title: AppStrings.paymentMethod,
                image: AppImages.paymentmethodImg,
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentMethodProfileScreen(),
                    ),
                  );
                }),
            ProfileCardEditWidget(
                title: AppStrings.helpSupport,
                image: AppImages.helpandsupportImg,
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpSupportScreen(),
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: InkWell(
                onTap: _showConfirmationDialog,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image.asset(
                            AppImages.logoutImg,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          AppStrings.logout,
                          style: AppTextStyle.textStyle
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      AppImages.changeprofileImg,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    AppStrings.changeProfile,
                    style: AppTextStyle.textStyle.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 56,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.blue, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            AppImages.kalpeshImg,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    ShowUserName(
                      userId: uid,
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowUserName extends StatelessWidget {
  const ShowUserName({
    super.key,
    required this.userId,
    this.color,
  });
  final String userId;
  final Color? color;

  Future<Map<String, dynamic>?> _fetchUserData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      return doc.data();
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || snapshot.data == null) {
          return const Center(child: Text('Error fetching user data.'));
        }

        final userData = snapshot.data!;
        return Center(
          child: Text(
            userData['name'],
            style: AppTextStyle.textStyle.copyWith(
                fontWeight: FontWeight.w600, fontSize: 20, color: color),
          ),
        );
      },
    );
  }
}
