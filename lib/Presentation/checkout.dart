import 'package:flutter_ecommerce_155e5/Admin%20Pages/app_amdin_helper.dart';
import 'package:flutter_ecommerce_155e5/customWidgets/custom_backend.dart';
import 'package:flutter_ecommerce_155e5/customWidgets/custom_widgets.dart';
import 'package:flutter_ecommerce_155e5/demo_for_today.dart';
import 'package:flutter_ecommerce_155e5/modelsPages/iteam_model.dart';
import 'package:flutter_ecommerce_155e5/modelsPages/loation_model.dart';
import 'package:flutter_ecommerce_155e5/modelsPages/orders_models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Checkout extends StatefulWidget {
  @override
  _Checkout createState() => _Checkout();

  List<IteamModel>? iteamList;
  double payablePrice;
  Checkout({super.key, required this.iteamList, required this.payablePrice});
}

class _Checkout extends State<Checkout> {
  LocationModel? location = FullBDLocations;

  late DistrictModel destrict;
  late UpazilaModel upazila;
  late String area;

  late int destrictIndex;
  late int upazilaIndex;
  late int areaIndex;
  OrderListModel? orders;
  bool isOrderLoaded = false;

  TextEditingController addressControllet = TextEditingController();

  void orderListLoaderCaller() async {
    String userId = FirebaseAuth.instance.currentUser!.uid.toString();
    orders = await CustomBackEnd.fetchOrderListFromFirestore(appId, userId);
    isOrderLoaded = true;
    setState(() {});
  }

  void locationLoaderCaller() async {
    // location = await CustomBackEnd.firebaseLocationLoader();
    destrict = location!.destricts[destrictIndex];
    destrict = location!.destricts[destrictIndex];
    upazila = destrict.upazilas[upazilaIndex];
    area = upazila.areas[areaIndex];
    orderListLoaderCaller();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    destrictIndex = 0;
    upazilaIndex = 0;
    areaIndex = 0;
    total = widget.payablePrice;
    locationLoaderCaller();
  }

  double total = 0;
  int _paymentMethodSelectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Checkout"),
        ),
        body: (location != null)
            ? SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Row(
                            children: [
                              Text(
                                "Delivery Address",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ListTile(
                            title: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Destrict"),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      DropdownButton(
                                        value: destrict.destrict,
                                        items: location!.destricts
                                            .map((DistrictModel destrictName) {
                                          return DropdownMenuItem(
                                              value: destrictName.destrict,
                                              child:
                                                  Text(destrictName.destrict));
                                        }).toList(),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        onChanged: (value) {
                                          destrictIndex = location!.destricts
                                              .indexWhere((element) {
                                            return element.destrict == value;
                                          });
                                          destrict = location!
                                              .destricts[destrictIndex];
                                          upazilaIndex = 0;
                                          areaIndex = 0;
                                          upazila =
                                              destrict.upazilas[upazilaIndex];
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Upazila"),
                                      DropdownButton(
                                        value: upazila.upazila,
                                        items: destrict.upazilas
                                            .map((UpazilaModel upazilaName) {
                                          return DropdownMenuItem(
                                              value: upazilaName.upazila,
                                              child: Text(upazilaName.upazila));
                                        }).toList(),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        onChanged: (value) {
                                          upazilaIndex = destrict.upazilas
                                              .indexWhere((element) {
                                            return element.upazila == value;
                                          });
                                          upazila =
                                              destrict.upazilas[upazilaIndex];
                                          areaIndex = 0;
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  // Column(
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.start,
                                  //   children: [
                                  //     const Text("Area"),
                                  //     DropdownButton(
                                  //       value: upazila.areas[areaIndex],
                                  //       items: upazila.areas
                                  //           .map((String areaName) {
                                  //         return DropdownMenuItem(
                                  //             value: areaName,
                                  //             child: Text(areaName));
                                  //       }).toList(),
                                  //       borderRadius: const BorderRadius.all(
                                  //           Radius.circular(15)),
                                  //       onChanged: (value) {
                                  //         areaIndex = upazila.areas
                                  //             .indexWhere((element) {
                                  //           return element == value;
                                  //         });
                                  //         setState(() {});
                                  //       },
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: addressControllet,
                            decoration: InputDecoration(
                              hintText: 'House No. or Road',
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Payment method",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              paymentCard("Bkash", "assets/images/bkash.png"),
                              Radio(
                                value: 1,
                                groupValue: _paymentMethodSelectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    _paymentMethodSelectedValue = value as int;
                                  });
                                },
                              ),
                              // Add any additional widgets here as needed
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              paymentCard("Nogod", "assets/images/nogod.png"),
                              Radio(
                                value: 2,
                                groupValue: _paymentMethodSelectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    _paymentMethodSelectedValue = value as int;
                                  });
                                },
                              ),

                              // Add any additional widgets here as needed
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ListTile(
                            title: const Text("Total:",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            trailing: Text(
                              "Tk: ${total.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.red),
                            ),
                          ),
                          CustomWidgets.elevatedButtonCustom(
                              hintText: "Send order",
                              onPressedButton: () async {
                                String deliveryLocation =
                                    "${(addressControllet.text.isEmpty) ? "" : "${addressControllet.text}, "}$area, ${upazila.upazila}, ${destrict.destrict}";
                                List<IteamModel> orderlist = [];
                                widget.iteamList ??= [];
                                for (int i = 0;
                                    i < widget.iteamList!.length;
                                    i++) {
                                  if (widget.iteamList![i].quantity > 0) {
                                    orderlist.add(widget.iteamList![i]);
                                  }
                                }
                                if (orderlist.isNotEmpty) {
                                  String userId = FirebaseAuth
                                      .instance.currentUser!.uid
                                      .toString();

                                  OrderModel orderModel = OrderModel(
                                      deliveryLocation: deliveryLocation,
                                      orderList: orderlist);

                                  orders ??= OrderListModel(orders: []);
                                  orders!.orders.add(orderModel);

                                  await CustomBackEnd.uploadOrderToFirestore(
                                          appId, userId, orders!)
                                      .then((value) {
                                    CustomBackEnd
                                            .deleteCartCollectionFromFirebase()
                                        .then((value) {
                                      CustomWidgets.CustomPageRouteAnimation(
                                          context,
                                          pageName: const DemoForToday());
                                      CustomWidgets.snackBarCustom(context,
                                          massage: "Order Placed");
                                    });
                                  });
                                }
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }

  Widget paymentCard(String cardName, String imagePath) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          child: Image.asset(imagePath),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            cardName,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget locationDropdown(
      {String? titleName,
      dynamic value,
      Set<dynamic>? locationList,
      void Function(dynamic)? onchanged}) {
    if (locationList!.first == null || value.toString().isEmpty) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titleName!),
        DropdownButton(
          value: value,
          items: locationList.map((dynamic value) {
            return DropdownMenuItem<dynamic>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          onChanged: onchanged,
        ),
      ],
    );
  }
}
