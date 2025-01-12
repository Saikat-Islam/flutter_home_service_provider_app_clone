// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_home_service_provider_app_clone/AppUtils/app_strings.dart';
// import 'package:flutter_home_service_provider_app_clone/Models/service_provider.dart';
// import 'package:flutter_home_service_provider_app_clone/Presentation/Screens/ServiceProvider/selected_service_provider.dart';
// import 'package:flutter_home_service_provider_app_clone/Presentation/Widgets/service_provider_card_widget.dart';

// class ServiceProviderLayoutWidget extends StatelessWidget {
//   final String title;
//   final String icon;
//   final List<ServiceProvider> listofdata;
//   ServiceProviderLayoutWidget({
//     super.key,
//     required this.title,
//     required this.icon,
//     required this.listofdata,
//   });

//   navigateToAnotherScreen(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => SelectedServiceProviderScreen(
//           title: title,
//           listofdata: listofdata,
//         ),
//       ),
//     );
//   }

//   // Firebase Firestore instance
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Method to fetch users by profession
//   String selectedProfession = "Cleaning Service";
//   Future<List<Map<String, dynamic>>> fetchUsersByProfession(
//       String service) async {
//     try {
//       // Query Firestore for users with the specified profession
//       final QuerySnapshot querySnapshot = await _firestore
//           .collection('users')
//           .where('service', isEqualTo: service)
//           .get();

//       // Extract user data from the query results
//       return querySnapshot.docs.map((doc) {
//         return doc.data() as Map<String, dynamic>;
//       }).toList();
//     } catch (e) {
//       print('Error fetching users: $e');
//       return [];
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 CircleAvatar(
//                   backgroundColor: Colors.transparent,
//                   child: Image.asset(icon),
//                 ),
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     color: Colors.black54,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             TextButton(
//               onPressed: () {
//                 navigateToAnotherScreen(context);
//               },
//               child: const Text(
//                 AppStrings.viewAll,
//                 style: TextStyle(color: Colors.blue),
//               ),
//             ),
//           ],
//         ),
//         FutureBuilder<List<Map<String, dynamic>>>(
//             future: fetchUsersByProfession(selectedProfession),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               } else {
//                 final users = snapshot.data!;

//                 if (users.isEmpty) {
//                   return const Text('No matching users found.');
//                 }
//                 return SizedBox(
//                   height: 240,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: users.length,
//                     itemBuilder: (context, index) {
//                       final user = users[index];
//                       return ServiceProviderCardWidget(
//                           name: user['name'],
//                           profession: user['service'],
//                           rating: listofdata[index].rating.toString());
//                     },
//                   ),
//                 );
//               }
//             }),
//       ],
//     );
//   }
// }
