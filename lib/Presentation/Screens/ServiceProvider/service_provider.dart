import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_colors.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_constants.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_images.dart';
import 'package:flutter_home_service_provider_app_clone/AppUtils/app_strings.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Widgets/service_provider_card_widget.dart';
import 'package:flutter_home_service_provider_app_clone/Presentation/Widgets/service_provider_layout_widget.dart';

class ServiceProviderScreens extends StatefulWidget {
  const ServiceProviderScreens({super.key});

  @override
  State<ServiceProviderScreens> createState() => _ServiceProviderScreensState();
}

// Firebase Firestore instance
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Method to fetch users by profession
String selectedProfession = "Carpenter Service";
Future<List<Map<String, dynamic>>> fetchUsersByProfession(
    String service) async {
  try {
    // Query Firestore for users with the specified profession
    final QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('service', isEqualTo: service)
        .get();

    // Extract user data from the query results
    return querySnapshot.docs.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();
  } catch (e) {
    print('Error fetching users: $e');
    return [];
  }
}

String selectedProfession1 = "Ac Service";
Future<List<Map<String, dynamic>>> fetchUsersByProfession1(
    String service) async {
  try {
    // Query Firestore for users with the specified profession
    final QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('service', isEqualTo: service)
        .get();

    // Extract user data from the query results
    return querySnapshot.docs.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();
  } catch (e) {
    print('Error fetching users: $e');
    return [];
  }
}

String selectedProfession2 = "Car Service";
Future<List<Map<String, dynamic>>> fetchUsersByProfession2(
    String service) async {
  try {
    // Query Firestore for users with the specified profession
    final QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('service', isEqualTo: service)
        .get();

    // Extract user data from the query results
    return querySnapshot.docs.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();
  } catch (e) {
    print('Error fetching users: $e');
    return [];
  }
}

String selectedProfession3 = "Plumber Service";
Future<List<Map<String, dynamic>>> fetchUsersByProfession3(
    String service) async {
  try {
    // Query Firestore for users with the specified profession
    final QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('service', isEqualTo: service)
        .get();

    // Extract user data from the query results
    return querySnapshot.docs.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();
  } catch (e) {
    print('Error fetching users: $e');
    return [];
  }
}

String selectedProfession4 = "Electrician Service";
Future<List<Map<String, dynamic>>> fetchUsersByProfession4(
    String service) async {
  try {
    // Query Firestore for users with the specified profession
    final QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('service', isEqualTo: service)
        .get();

    // Extract user data from the query results
    return querySnapshot.docs.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();
  } catch (e) {
    print('Error fetching users: $e');
    return [];
  }
}

String selectedProfession5 = "Cleaning Service";
Future<List<Map<String, dynamic>>> fetchUsersByProfession5(
    String service) async {
  try {
    // Query Firestore for users with the specified profession
    final QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('service', isEqualTo: service)
        .get();

    // Extract user data from the query results
    return querySnapshot.docs.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();
  } catch (e) {
    print('Error fetching users: $e');
    return [];
  }
}

class _ServiceProviderScreensState extends State<ServiceProviderScreens> {
  final CollectionReference fetchData =
      FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.blueColors,
              )),
        ),
        title: const Text(
          AppStrings.servicesprovider,
          style: TextStyle(
            color: AppColors.blueColors,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ServiceHeader(
                    image: AppImages.carpentericonImg,
                    text: 'Carpenter Provider',
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'View All',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchUsersByProfession(selectedProfession),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      final users = snapshot.data!;

                      if (users.isEmpty) {
                        return const Text('No matching users found.');
                      }
                      return SizedBox(
                        height: 240,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return ServiceProviderCardWidget(
                                name: user['name'],
                                profession: user['service'],
                                rating: "4.5");
                          },
                        ),
                      );
                    }
                  }),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ServiceHeader(
                    image: AppImages.airconditeniorImg,
                    text: 'Ac Provider',
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'View All',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchUsersByProfession1(selectedProfession1),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      final users = snapshot.data!;

                      if (users.isEmpty) {
                        return const Text('No matching users found.');
                      }
                      return SizedBox(
                        height: 240,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return ServiceProviderCardWidget(
                                name: user['name'],
                                profession: user['service'],
                                rating: "4.5");
                          },
                        ),
                      );
                    }
                  }),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ServiceHeader(
                    image: AppImages.carwasherImg,
                    text: 'Car Provider',
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'View All',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchUsersByProfession2(selectedProfession2),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      final users = snapshot.data!;

                      if (users.isEmpty) {
                        return const Text('No matching users found.');
                      }
                      return SizedBox(
                        height: 240,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return ServiceProviderCardWidget(
                                name: user['name'],
                                profession: user['service'],
                                rating: "4.5");
                          },
                        ),
                      );
                    }
                  }),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ServiceHeader(
                    image: AppImages.plumbericonImg,
                    text: 'Plumber Provider',
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'View All',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchUsersByProfession3(selectedProfession3),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      final users = snapshot.data!;

                      if (users.isEmpty) {
                        return const Text('No matching users found.');
                      }
                      return SizedBox(
                        height: 240,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return ServiceProviderCardWidget(
                                name: user['name'],
                                profession: user['service'],
                                rating: "4.5");
                          },
                        ),
                      );
                    }
                  }),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ServiceHeader(
                    image: AppImages.electricianiconImg,
                    text: 'Electrician Provider',
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'View All',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchUsersByProfession4(selectedProfession4),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      final users = snapshot.data!;

                      if (users.isEmpty) {
                        return const Text('No matching users found.');
                      }
                      return SizedBox(
                        height: 240,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return ServiceProviderCardWidget(
                                name: user['name'],
                                profession: user['service'],
                                rating: "4.5");
                          },
                        ),
                      );
                    }
                  }),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ServiceHeader(
                    image: AppImages.cleanericonImg,
                    text: 'Cleaner Provider',
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'View All',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchUsersByProfession5(selectedProfession5),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      final users = snapshot.data!;

                      if (users.isEmpty) {
                        return const Text('No matching users found.');
                      }
                      return SizedBox(
                        height: 240,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return ServiceProviderCardWidget(
                                name: user['name'],
                                profession: user['service'],
                                rating: "4.5");
                          },
                        ),
                      );
                    }
                  }),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceHeader extends StatelessWidget {
  const ServiceHeader({
    super.key,
    required this.image,
    required this.text,
  });
  final String image, text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(image: AssetImage(image)),
        Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 18),
        ),
      ],
    );
  }
}
