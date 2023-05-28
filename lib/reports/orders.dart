import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import '../models/orders_model.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class OrderItem {
  final String email;
  final String items;
  final double totalPrice;
  final Timestamp orderDate;
  final String phoneNumber;
  bool orderState;

  OrderItem({
    required this.email,
    required this.items,
    required this.totalPrice,
    required this.orderDate,
    required this.phoneNumber,
    this.orderState = false,
  });

  factory OrderItem.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return OrderItem(
      email: data['email'] ?? '',
      items: data['items'] ?? '',
      totalPrice: data['totalPrice'] ?? 0.0,
      orderDate: data['orderDate'] ?? Timestamp.now(),
      phoneNumber: data['phoneNumber'] ?? '',
      orderState: data['orderState'] ?? false,
    );
  }
}

class _OrdersScreenState extends State<OrdersScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<OrderItem>> getOrderItems() async {
    List<OrderItem> orderItems = [];

    QuerySnapshot querySnapshot = await _firestore
        .collection('orders')
        .orderBy('orderDate', descending: true)
        .get();

    querySnapshot.docs.forEach((doc) {
      orderItems.add(OrderItem.fromSnapshot(doc));
    });

    return orderItems;
  }

  Future<void> updateOrderState(String orderId) async {
    await _firestore
        .collection('orders')
        .doc(orderId)
        .update({'orderState': true});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Placed Orders Report'),
      ),
      body: FutureBuilder<List<OrderItem>>(
        future: getOrderItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<OrderItem> orderItems = snapshot.data!;

            if (orderItems.isEmpty) {
              return const Center(child: Text('No data available'));
            }

            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: orderItems.length,
                itemBuilder: (BuildContext context, int index) {
                  OrderItem order = orderItems[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 249, 95, 95),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Card(
                        child: ListTile(
                          leading: const Icon(
                              Icons.av_timer), // Icon representing email
                          title: RichText(
                            text: TextSpan(
                              text: 'Farmer Email    : ',
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: order.email,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Medicine Ordered    : ',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: order.items,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Total Price   :     ',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${order.totalPrice} Kshs.',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Phone Number   :    ',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: order.phoneNumber,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Date Ordered    :    ',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${order.orderDate.toDate()}',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
