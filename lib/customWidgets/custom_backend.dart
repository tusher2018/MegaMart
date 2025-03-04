import 'package:flutter_ecommerce_155e5/modelsPages/menu_model.dart';

import 'package:flutter_ecommerce_155e5/Admin%20Pages/app_amdin_helper.dart';
import 'package:flutter_ecommerce_155e5/modelsPages/iteam_model.dart';
import 'package:flutter_ecommerce_155e5/modelsPages/orders_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomBackEnd {
  static Future<MenuModelFirebaseSetData?> firebaseMenuLoader() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection("Menus").doc(appId).get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        return MenuModelFirebaseSetData.fromMap(data);
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching location data: $e');
      return null;
    }
  }

  static Future<List<IteamModel>> fetchCartIteamModelsFromFirestore() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String userId = FirebaseAuth.instance.currentUser!.uid.toString();
      CollectionReference iteamCollection = firestore
          .collection('Users Collections')
          .doc(userId)
          .collection("Cart");

      QuerySnapshot snapshot = await iteamCollection.get();

      List<IteamModel> iteamModels = snapshot.docs.map((doc) {
        print(doc.data());
        return IteamModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      return iteamModels;
    } catch (error) {
      print('Error fetching data from Firestore: $error');
      return [];
    }
  }

  static Future<void> uploadCartDataToFirebase(
      List<IteamModel> iteamList) async {
    try {
      // Initialize Firebase
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to your Firestore collection
      String userId = FirebaseAuth.instance.currentUser!.uid.toString();
      CollectionReference iteamCollection = firestore
          .collection('Users Collections')
          .doc(userId)
          .collection("Cart");

      // Upload each item in the list to Firestore
      for (IteamModel item in iteamList) {
        await iteamCollection.add(item.toMap());
      }

      print('Data uploaded to Firestore successfully');
    } catch (error) {
      print('Error uploading data to Firestore: $error');
    }
  }

  static Future<void> deleteCartCollectionFromFirebase() async {
    try {
      // Initialize Firebase
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to your Firestore collection
      String userId = FirebaseAuth.instance.currentUser!.uid;
      CollectionReference cartCollection = firestore
          .collection('Users Collections')
          .doc(userId)
          .collection("Cart");

      // Fetch all documents within the collection
      QuerySnapshot snapshot = await cartCollection.get();

      // Create a batched write to delete each document
      WriteBatch batch = firestore.batch();
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      // Commit the batched write
      await batch.commit();

      // Delete the collection itself
      await cartCollection.parent!.delete();

      print('Cart collection deleted successfully');
    } catch (error) {
      print('Error deleting cart collection from Firestore: $error');
    }
  }

  static Future<void> uploadOrderToFirestore(
      String appId, String userId, OrderListModel orderList) async {
    try {
      // Initialize Firebase
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to the orders document under the specified location
      DocumentReference orderDoc = firestore
          .collection("Orders")
          .doc(appId)
          .collection("ordersList")
          .doc(userId);

      // Set the order data to Firestore
      await orderDoc.set(orderList.toMap());

      print('Order list uploaded to Firestore successfully');
    } catch (error) {
      print('Error uploading order list to Firestore: $error');
    }
  }

  static Future<OrderListModel?> fetchOrderListFromFirestore(
      String appId, String userId) async {
    try {
      // Initialize Firebase
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to the orders document under the specified location
      DocumentReference orderDoc = firestore
          .collection("Orders")
          .doc(appId)
          .collection("ordersList")
          .doc(userId);

      // Fetch the document snapshot
      DocumentSnapshot snapshot = await orderDoc.get();

      // Parse the data into an OrderListModel object
      if (snapshot.exists) {
        return OrderListModel.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (error) {
      print('Error fetching order list from Firestore: $error');
      return null;
    }
  }
}
