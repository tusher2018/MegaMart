import 'package:flutter_ecommerce_155e5/Admin%20Pages/app_amdin_helper.dart';
import 'package:flutter_ecommerce_155e5/customWidgets/custom_backend.dart';
import 'package:flutter_ecommerce_155e5/customWidgets/custom_text.dart';
import 'package:flutter_ecommerce_155e5/modelsPages/orders_models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_155e5/modelsPages/iteam_model.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  _MyOrders createState() => _MyOrders();
}

class _MyOrders extends State<MyOrders> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  OrderListModel? orders;

  bool ordersLoaded = false;

  @override
  void initState() {
    super.initState();
    orderLoaderCaller();
  }

  void orderLoaderCaller() async {
    String userId = FirebaseAuth.instance.currentUser!.uid.toString();
    orders = await CustomBackEnd.fetchOrderListFromFirestore(appId, userId);
    orders ??= OrderListModel(orders: [
      OrderModel(deliveryLocation: "No active orders", orderList: [])
    ]);
    ordersLoaded = true;
    print(ordersLoaded);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (orders != null &&
              ordersLoaded == true &&
              orders!.orders.isNotEmpty)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Container(
                          height: 2,
                          color: Colors.black12,
                        );
                      },
                      shrinkWrap: true,
                      itemCount: orders!.orders.length,
                      itemBuilder: (context, index) {
                        OrderModel order = orders!.orders[index];
                        return Column(
                          children: [
                            ListTile(
                              title: customText("Delivary Address:",
                                  fontWeigth: FontWeight.bold),
                              subtitle:
                                  customText(order.deliveryLocation, size: 11),
                            ),
                            Column(
                              children: List.generate(
                                order.orderList.length,
                                (index2) {
                                  IteamModel iteam = order.orderList[index2];
                                  return ListTile(
                                    title: Text(
                                        "${iteam.iteam!.iteamName} x${iteam.quantity}",
                                        style: const TextStyle(fontSize: 14)),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Tk: ${iteam.iteam!.price ?? 0.0 * iteam.quantity}   ",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : (ordersLoaded == false)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: customText("No Cart Iteam found"),
                ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(
          DateTime.now().year + 1, DateTime.now().month, DateTime.now().day),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }
}
