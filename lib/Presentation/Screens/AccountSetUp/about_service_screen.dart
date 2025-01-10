import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_colors.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_images.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_strings.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_text_style.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Screens/AccountSetUp/service_working_hours_screen.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Widgets/button_style_widget.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Widgets/dropdown_menu_box_widget.dart';

class AboutServiceScreen extends StatefulWidget {
  const AboutServiceScreen({super.key});

  @override
  State<AboutServiceScreen> createState() => _AboutServiceState();
}

class _AboutServiceState extends State<AboutServiceScreen> {
  List<String> services = [
    AppStrings.acService,
    AppStrings.carService,
    AppStrings.busService,
    AppStrings.plumberService,
    AppStrings.electricianService,
    AppStrings.cleaningService,
    AppStrings.carpenterService,
    AppStrings.gardeningService,
    AppStrings.pestControlService,
    AppStrings.paintingService
  ];
  List<String> experience = [
    AppStrings.noExp,
    AppStrings.lessExp,
    AppStrings.oneyearExp,
    AppStrings.twoExp,
    AppStrings.threeExp,
    AppStrings.fourExp,
    AppStrings.fievExp,
    AppStrings.tenExp,
  ];
  List<String> area = [
    AppStrings.bhat,
    AppStrings.hansol,
    AppStrings.maninagar,
    AppStrings.naroda,
    AppStrings.navrangpura,
    AppStrings.nikol,
    AppStrings.vasna,
    AppStrings.vastral,
    AppStrings.vastrapur,
  ];

  // Variables to store selected values
  String? selectedService;
  String? selectedExperience;
  String? selectedServiceArea;

  // Function to save the data to Firestore
  Future<void> selectService() async {
    if (selectedService == null ||
        selectedExperience == null ||
        selectedServiceArea == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select all options')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'service': selectedService,
        'experience': selectedExperience,
        'area': selectedServiceArea,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data saved successfully!')),
      );
      // Navigate to next screen if required
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ServiceWorkingHoursScreen()));
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
            AppImages.frame5Img,
          ),
          const SizedBox(
            width: 24,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 36, left: 24, right: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.selectaService,
              style: AppTextStyle.textStyle,
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: DropdownButtonFormField<String>(
                value: selectedService,
                hint: Text('Select a service'),
                items: services.map((service) {
                  return DropdownMenuItem(value: service, child: Text(service));
                }).toList(),
                onChanged: (value) => setState(() => selectedService = value),
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            DropdownButtonFormField<String>(
              value: selectedExperience,
              hint: Text('Select Your Experience'),
              items: experience.map((experience) {
                return DropdownMenuItem(
                    value: experience, child: Text(experience));
              }).toList(),
              onChanged: (value) => setState(() => selectedExperience = value),
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 16,
            ),
            DropdownButtonFormField<String>(
              value: selectedServiceArea,
              hint: Text('Select Your Area'),
              items: area.map((area) {
                return DropdownMenuItem(value: area, child: Text(area));
              }).toList(),
              onChanged: (value) => setState(() => selectedServiceArea = value),
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 126,
            ),
            InkWell(
              onTap: () {
                selectService();
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
