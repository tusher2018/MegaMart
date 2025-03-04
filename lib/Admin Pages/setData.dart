// import 'package:flutter_ecommerce_155e5/modelsPages/loation_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class setData extends StatefulWidget {
//   const setData({super.key});

//   @override
//   _setData createState() => _setData();
// }

// class _setData extends State<setData> {
//   @override
//   void initState() {
//     super.initState();
//     setLocationToFirebase();
//     // setMenuToFirebase();
//   }

//   void setLocationToFirebase() async {
//     //admin uid
//     String uid = FirebaseAuth.instance.currentUser!.uid;
//     print(uid);
//     FirebaseFirestore.instance
//         .collection("Location")
//         .doc(uid)
//         .set(LocationModel(destricts: [
//           DistrictModel(destrict: "Narayangonj", upazilas: [
//             UpazilaModel(
//                 upazila: "Narayangonj Sador",
//                 areas: ["casara", "khanpur", "golachipa", "collage road"]),
//             UpazilaModel(
//                 upazila: "Bondor",
//                 areas: ["spahani", "nobigonj", "rupali", "amin"]),
//             UpazilaModel(upazila: "Sonarga", areas: [
//               "sona",
//               "rupa",
//               "hira",
//             ])
//           ]),
//           DistrictModel(destrict: "p", upazilas: [
//             UpazilaModel(upazila: "q", areas: ["r", "s", "t", "u"]),
//             UpazilaModel(upazila: "v", areas: ["w", "x", "y", "z"]),
//             UpazilaModel(upazila: "a1", areas: [
//               "b1",
//               "c1",
//               "d1",
//             ])
//           ]),
//           DistrictModel(destrict: "e1", upazilas: [
//             UpazilaModel(upazila: "f1", areas: ["g1", "h1", "i1", "j1"]),
//             UpazilaModel(upazila: "k1", areas: ["l1", "m1", "n1", "o1"]),
//             UpazilaModel(upazila: "p1", areas: [
//               "q1",
//               "r1",
//               "s1",
//             ])
//           ])
//         ]).toMap());
//   }

//   // void setMenuToFirebase() async {
//   //   String uid = FirebaseAuth.instance.currentUser!.uid;
//   //   print(uid);
//   //   FirebaseFirestore.instance
//   //       .collection("Menus")
//   //       .doc(uid)
//   //       .set((MenuModelFirebaseSetData(menuIteamList: [
//   //         MenuModel(menuName: "breakfast", uid: "0123", iteams: [
//   //           MenuIteamModel(iteamName: "b1", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "b2", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "b3", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "b4", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "b5", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "b6", iteamImagePath: "aaa"),
//   //         ]),
//   //         MenuModel(menuName: "Dinner", uid: "234", iteams: [
//   //           MenuIteamModel(iteamName: "d1", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "d2", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "d3", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "d4", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "d5", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "d6", iteamImagePath: "aaa"),
//   //         ]),
//   //         MenuModel(menuName: "desert", uid: "0123", iteams: [
//   //           MenuIteamModel(iteamName: "b1", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "b2", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "b3", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "b4", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "b5", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "b6", iteamImagePath: "aaa"),
//   //         ]),
//   //         MenuModel(menuName: "lunch", uid: "234", iteams: [
//   //           MenuIteamModel(iteamName: "d1", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "d2", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "d3", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "d4", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "d5", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "d6", iteamImagePath: "aaa"),
//   //         ]),
//   //         MenuModel(menuName: "milk", uid: "0123", iteams: [
//   //           MenuIteamModel(iteamName: "b1", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "b2", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "b3", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "b4", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "b5", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "b6", iteamImagePath: "aaa"),
//   //         ]),
//   //         MenuModel(menuName: "food", uid: "234", iteams: [
//   //           MenuIteamModel(iteamName: "d1", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "d2", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "d3", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "d4", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "d5", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "d6", iteamImagePath: "aaa"),
//   //         ]),
//   //         MenuModel(menuName: "mango", uid: "0123", iteams: [
//   //           MenuIteamModel(iteamName: "b1", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "b2", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "b3", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "b4", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "b5", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "b6", iteamImagePath: "aaa"),
//   //         ]),
//   //         MenuModel(menuName: "Dinner", uid: "234", iteams: [
//   //           MenuIteamModel(iteamName: "d1", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "d2", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "d3", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "d4", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "d5", iteamImagePath: "aaa"),
//   //           MenuIteamModel(iteamName: "d6", iteamImagePath: "aaa"),
//   //         ]),
//   //       ])).toMap());
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text("Hello"),
//       ),
//     );
//   }
// }
