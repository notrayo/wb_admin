import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItem {
  final String email;
  final List<dynamic> items;
  final double totalPrice;
  final Timestamp timeStamp;
  final String phoneNumber;

  OrderItem({
    required this.email,
    required this.items,
    required this.totalPrice,
    required this.timeStamp,
    required this.phoneNumber,
  });
}
