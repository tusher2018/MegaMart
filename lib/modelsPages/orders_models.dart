import 'package:flutter_ecommerce_155e5/modelsPages/iteam_model.dart';

class OrderModel {
  final String deliveryLocation;
  final List<IteamModel> orderList;

  OrderModel({required this.deliveryLocation, required this.orderList});

  Map<String, dynamic> toMap() {
    return {
      'deliveryLocation': deliveryLocation,
      'orderList': orderList.map((item) => item.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      deliveryLocation: map['deliveryLocation'],
      orderList: List<IteamModel>.from(
          map['orderList'].map((x) => IteamModel.fromMap(x))),
    );
  }
}

class OrderListModel {
  final List<OrderModel> orders;

  OrderListModel({required this.orders});

  Map<String, dynamic> toMap() {
    return {
      'orders': orders.map((order) => order.toMap()).toList(),
    };
  }

  factory OrderListModel.fromMap(Map<String, dynamic> map) {
    return OrderListModel(
      orders: List<OrderModel>.from(
          map['orders'].map((order) => OrderModel.fromMap(order))),
    );
  }
}
