import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Report'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [Text('Ordered drugs to be displayed here ...')],
        ),
      ),
    );
  }
}
